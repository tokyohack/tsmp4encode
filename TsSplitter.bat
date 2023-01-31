set TsSplitter=.\TsSplitter.exe
if not "%~x1" == ".ts" goto :eof
%TsSplitter% -EIT -ECM -SD -1SEG -OUT "%output_drive%" -SEP3 -SEPA -GOP -GOPCH -GOPTIME -LOGFILE -FLEN -UNI %1
del /f /s %1
exit /b
