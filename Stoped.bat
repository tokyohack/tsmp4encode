cd /d "%drivepath%:\15r%NOLOgo%\%~n1\"
ren "%~n1obs_cut.avs" "obs_cut.avs"
ren "%~n1.avs" "in_cutcm_logo.avs"
ren "%~n1_log.txt" "!%~n1_log.txt"
del "%~n1*.aac"
call "C:\tsmp4encode\MainPro.bat" "%drivepath%:\15r%NOLOgo%\%~n1\in_cutcm_logo.avs"  > "%drivepath%:\15r%NOLOgo%\%~n1.end.log.txt"
exit /b