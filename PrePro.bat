@echo off
set num=0
timeout /t 100

:stt
set /a num=num+1
if %num% equ 100 (
  goto end_finish
  )
:NonIncrement
if not exist %1 (
  goto nextFileNotShift
  )
if "%~1" == "" if "%~x1" == ".mp4" (
  goto nextFileNotShift
)
if not "%~x1" == ".ts" (
  goto nextFileNotShift
)

title %~n1


if not defined drivepath set "drivepath=Y"
set "split_drive_path=Y"

set "NOLOgo="
set "name1=%~nx1"
set "NHKCHK=%name1:&=^&%"


rem nogolo_check
call C:\tsmp4encode\nologo_chk.bat %1
REM nogolo_check

REM フォルダが無い場合作成
call C:\tsmp4encode\Folder_Exists_CHK.bat


REM フォルダにavsある場合は中断されたので再リトライ
echo "%drivepath%:\15r%NOLOgo%\%~n1\%~n1obs_cut.avs"
if exist "%drivepath%:\15r%NOLOgo%\%~n1\%~n1obs_cut.avs" (
  call "C:\tsmp4encode\Stoped.bat" %1
  goto next_file
  )
if exist "%drivepath%:\15r%NOLOgo%\%~n1\obs_cut.avs" (
  call "C:\tsmp4encode\Stoped.bat" %1
  goto next_file
  )

REM フォルダがある場合スキップ
echo "%drivepath%:\15r%NOLOgo%\%~n1\"
if exist "%drivepath%:\15r%NOLOgo%\%~n1\" (
   goto nextFileNotShift 
   )
if exist "%drivepath%:\15r%NOLOgo%\%~n1" (
   goto nextFileNotShift 
   )


REM フォルダがある場合スキップ
echo "%drivepath%:\cmcutter\join_logo_scp_set_v4\join_logo_scp_set_v4\join_logo_scp試行環境_2\join_logo_scp試行環境%NOLOgo%\result\%~n1"
if exist "%drivepath%:\cmcutter\join_logo_scp_set_v4\join_logo_scp_set_v4\join_logo_scp試行環境_2\join_logo_scp試行環境%NOLOgo%\result\%~n1" (
  goto NonIncrement
  )


REM AAC_DROP_CHK
call C:\tsmp4encode\aac_drop_checkdd.bat %1
if not defined AAC_DROPED (
  goto nextFileNotShift
  )

REM アス比チェック
@set SinkuSuperLiteC="C:\tsmp4encode\sinkusuperlite\SinkuSuperLiteC.exe"
%SinkuSuperLiteC% %1 >>"%drivepath%:\15r%NOLOgo%\%~n1_medialog.txt"
for /F "tokens=* delims=" %%i in ('findstr "Interlace" "%drivepath%:\15r%NOLOgo%\%~n1_medialog.txt"') do @set sar=%%i
if not defined sar (
  goto nextFileNotShift
  )
echo %sar%
if not "%sar:1920=%" == "%sar%" ( set asuhi=1:1 )
if not "%sar:1440=%" == "%sar%" ( set asuhi=4:3 )
if not "%sar:720=%" == "%sar%" ( set asuhi=32:27 )
if not defined asuhi (
  goto nextFileNotShift
)
echo %asuhi%

REM #Namecheck
call C:\tsmp4encode\nameSplit.bat
echo nameSplit_is_%namebranch%
timeout /t 1
if not defined namebranch (
  goto nextFileNotShift
)

echo %namebranch%
goto %namebranch%

:tssd
cmd /c C:\tsmp4encode\MITM.bat "%~1"

goto next_file
REM goto skip_tss
:tss
set "output_drive=%split_drive_path%:"
call "C:\tsmp4encode\TsSplitter.bat" %1

set date_tmp=%date:/=%
set time_tmp=%time: =0%
set yyyy=%date_tmp:~0,4%
set yy=%date_tmp:~2,2%
set mm=%date_tmp:~4,2%
set dd=%date_tmp:~6,2%
set hh=%time_tmp:~0,2%
set mi=%time_tmp:~3,2%
set ss=%time_tmp:~6,2%
set sss=%time_tmp:~9,2%
set datetime=%yyyy%%mm%%dd%%hh%%mi%%ss%%sss%
set ran=%random%

for /f "usebackq tokens=*" %%k in (`dir /B "%output_drive%\%~n1.log"`) ^
do @set TsSplitter_log=%%k
echo %TsSplitter_log%
echo.

if not defined TsSplitter_log goto nextFileNotShift
echo コピー "%output_drive%\%TsSplitter_log%" "%~d1\%datetime%_%ran%.log"
copy "%output_drive%\%TsSplitter_log%" "%~d1\%datetime%_%ran%.log"


setlocal enabledelayedexpansion
for /f "tokens=1 delims=," %%f in (%~d1\%datetime%_%ran%.log) do (
  echo %%f
  call C:\tsmp4encode\path_get.bat %%f
  call C:\tsmp4encode\sar_chk.bat %%f
  call C:\tsmp4encode\aac_drop_checkdd.bat %%f >> "%drivepath%:\15r%NOLOgo%\!f_name!.drop_chk.log.txt"
  if !AAC_DROPED! == AAC_DROPED (
    echo ドロップあり
    timeout /t 30
    call C:\tsmp4encode\DropTs.bat %%f >> "%drivepath%:\15r%NOLOgo%\!mojierr!.end.log.txt"
    REM goto droptss
  ) else if !AAC_DROPED! == AAC_NON_DROP (
    echo ドロップなし
    timeout /t 30
    call C:\tsmp4encode\MITM.bat %%f
    REM goto nondroptss
  ) else (
    call C:\tsmp4encode\echobaacnull.bat %%f
  )
)
endlocal
del "%output_drive%\%TsSplitter_log%"
del "%~d1\%datetime%_%ran%.log"
goto dropend


if %AAC_DROPED% == AAC_DROPED (
  echo ドロップあり
  timeout /t 30
  set JLS=C:\tsmp4encode\DropTs.bat
  goto droptss
  ) else (
    echo ドロップなし
  timeout /t 30
  set JLS=C:\tsmp4encode\MITM.bat
  goto nondroptss
)

:droptss
for /f "tokens=1 delims=," %%f in (%~d1%datetime%.log) do (
  call C:\tsmp4encode\dropenc_C.bat %%f
  )
goto dropend

:nondroptss
for /f "tokens=1 delims=," %%f in (%~d1%datetime%.log) do (
  call %JLS% %%f
  )
goto dropend

:dropend
:next_file
if defined move_ goto end_finish
shift
timeout /t 10
goto NonIncrement
:nextFileNotShift
shift
goto stt
:end_finish
exit /b