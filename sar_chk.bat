REM アス比チェック
set "asuhi="
@set SinkuSuperLiteC="C:\tsmp4encode\sinkusuperlite\SinkuSuperLiteC.exe"
%SinkuSuperLiteC% %1 >"%drivepath%:\15r%NOLOgo%\%~n1_medialog.txt"
for /F "tokens=* delims=" %%i in ('findstr "Interlace" "%drivepath%:\15r%NOLOgo%\%~n1_medialog.txt"') do @set sar=%%i
if not defined sar goto :EOF
echo %sar%
if not "%sar:1920=%" == "%sar%" ( set asuhi=1:1 )
if not "%sar:1440=%" == "%sar%" ( set asuhi=4:3 )
if not "%sar:720=%" == "%sar%" ( set asuhi=32:27 )
if not defined asuhi goto :EOF
echo %asuhi%
exit /b
