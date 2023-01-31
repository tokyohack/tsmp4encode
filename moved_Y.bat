@echo off
set num=0
set "move_=move_"
:stt0
set /a num=num+1
if %num% equ 10 (goto nothingFiles)

set name=%~nx1
set NHKCHK=%name%
set "pass=Y"
echo "%~1"
echo %pass%à⁄ìÆ
timeout /t 100

if not exist %1 ( goto nextFile0 )
if "%~1" == "" if "%~x1" == ".mp4" goto nextFile0
if not "%~x1" == ".ts" goto nextFile0

echo if not exist "%pass%:%~pnx1" (move "%~1" "%pass%:%~p1")
echo à⁄ìÆÇµÇ‹Ç∑ÅB
timeout /t 20
if not exist "%pass%:%~p1" (md "%~1" "%pass%:%~p1")
if not exist "%pass%:%~pnx1" (move "%~1" "%pass%:%~p1")
timeout /t 10
call C:\tsmp4encode\PrePro.bat "%pass%:%~pnx1"

:nextFile0
shift
goto stt0

:nothingFiles
exit /b
