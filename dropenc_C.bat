if not defined drivepath goto Not_definition

:Not_definition
call %JLS% "%~1" > "%drivepath%:\15r%NOLOgo%\%~n1.end.log.txt"
goto Fin_Drop

:Not_definition
call %JLS% "%~1" > "C:\15r%NOLOgo%\%~n1.end.log.txt"
goto Fin_Drop

:Fin_Drop
exit /b 0