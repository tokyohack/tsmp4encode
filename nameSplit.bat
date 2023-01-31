set "namebranch=" 
if not "%NHKCHK:ERR=%" == "%NHKCHK%" goto next_file
if not "%NHKCHK:_HD-=%" == "%NHKCHK%" goto tssd
if not "%NHKCHK:‚m‚g‚j=%" == "%NHKCHK%" goto tss

goto SplitResult

:next_file
set "namebranch=next_file"
goto SplitResult

:tssd
set "namebranch=tssd"
goto SplitResult

:tss
set "namebranch=tss"
goto SplitResult


:SplitResult
if not defined namebranch set "namebranch=tssd" 
exit /b