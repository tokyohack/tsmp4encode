@echo off
:stt
if not defined drivepath set drivepath=Y

set "mojierr="
set "mojierr=%~n1"

if not exist %1 ( goto end_finish )
if "%~1" == "" if "%~x1" == ".mp4" goto next_file
if not defined AAC_DROPED goto next_file
if %AAC_DROPED% == AAC_DROPED (
  echo ドロップあり
  timeout /t 30
  call "C:\tsmp4encode\DropTs.bat" %1 > "%drivepath%:\15r%NOLOgo%\%~n1.end.log.txt"
  goto next_file
  ) else (
    echo ドロップなし
    timeout /t 30
    )


if NOLOgo==%NOLOgo% echo ロゴ有
if NOLOgo==%NOLOgo% goto START


:waiting
tasklist | findstr logoframe.exe
if errorlevel 1 goto START
if errorlevel 0 timeout /t 2
goto waiting
:START


if exist "%drivepath%:\15r%NOLOgo%\%~n1\" goto next_file
if exist "C:\cmcutter\join_logo_scp_set_v4\join_logo_scp_set_v4\join_logo_scp試行環境\join_logo_scp試行環境%NOLOgo%\result\%~n1" goto next_file

if exist "%~dpn1.srt" del "%~dpn1.srt"
if exist "%~dpn1.ass" del "%~dpn1.ass"
if exist "%~dpn1_new.ass" del "%~dpn1_new.ass"
if exist "%~dpn1_new.srt" del "%~dpn1_new.srt"

title logoF-%~n1

call "C:\cmcutter\join_logo_scp_set_v4\join_logo_scp_set_v4\join_logo_scp試行環境\join_logo_scp試行環境%NOLOgo%\jlse_bat.bat" "%~1"
robocopy "C:\cmcutter\join_logo_scp_set_v4\join_logo_scp_set_v4\join_logo_scp試行環境\join_logo_scp試行環境%NOLOgo%\result\%~n1" "%drivepath%:\15r%NOLOgo%\%~n1" /MOVE /COPYALL /S

if not exist "%drivepath%:\15r%NOLOgo%\%~n1\in_cutcm_logo.avs" goto next_file

call "C:\tsmp4encode\MainPro.bat" "%drivepath%:\15r%NOLOgo%\%~n1\in_cutcm_logo.avs"  > "%drivepath%:\15r%NOLOgo%\%~n1.end.log.txt"

:next_file
shift
goto stt
:end_finish
exit /b
