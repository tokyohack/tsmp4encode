set "mojierr="
set "mojierr=%~n1"
set "paket="
set "paketsub="
set "AAC_DROPED="

if not "%mojierr:_HD=%" == "%mojierr%" goto skip_drop_chkk

for /F "tokens=* delims=" %%d in ('findstr "/c:0x0341" "/c:0x104F" "/c:0x104C" "/c:0x1048" "/c:0x1045" "/c:0x104E" "/c:0x1047" "/c:0x1046" "/c:0x104D" "/c:0x0210" "/c:0x1041" "/c:0x0410" "/c:0x0110" "/c:0x0112" "/c:0x0141" "/c:0x0241" "/c:0x1042" "D:%~pnx1.err"') do @set paket=%%d
for /F "tokens=* delims=" %%d in ('findstr "/c:0x0341" "/c:0x104F" "/c:0x104C" "/c:0x1048" "/c:0x1045" "/c:0x104E" "/c:0x1047" "/c:0x1046" "/c:0x104D" "/c:0x0210" "/c:0x1041" "/c:0x0410" "/c:0x0110" "/c:0x0112" "/c:0x0141" "/c:0x0241" "/c:0x1042" "D:\my videos\%mojierr:~0,-12%*.err"') do @set paket=%%d
for /F "tokens=* delims=" %%d in ('findstr "/c:0x0341" "/c:0x104F" "/c:0x104C" "/c:0x1048" "/c:0x1045" "/c:0x104E" "/c:0x1047" "/c:0x1046" "/c:0x104D" "/c:0x0210" "/c:0x1041" "/c:0x0410" "/c:0x0110" "/c:0x0112" "/c:0x0141" "/c:0x0241" "/c:0x1042" "%~1.err"') do @set paket=%%d


for /F "tokens=* delims=" %%d in ('findstr "/c:0x0111" "/c:0x0113" "/c:0x1047" "/c:0x1058" "/c:0x1C02" "%~1.err"') do @set paketsub=%%d
for /F "tokens=* delims=" %%d in ('findstr "/c:0x0111" "/c:0x0113" "/c:0x1047" "/c:0x1058" "/c:0x1C02" "D:%~pnx1.err"') do @set paketsub=%%d
for /F "tokens=* delims=" %%d in ('findstr "/c:0x0111" "/c:0x0113" "/c:0x1047" "/c:0x1058" "/c:0x1C02" "T:%~pnx1.err"') do @set paketsub=%%d
for /F "tokens=* delims=" %%d in ('findstr "/c:0x0111" "/c:0x0113" "/c:0x1047" "/c:0x1058" "/c:0x1C02" "D:\my videos\%mojierr:~0,-12%*.err"') do @set paketsub=%%d

if not defined paket goto skip_drop_chkk
echo. %paket%
if not "%paket:Drop:        0  Scramble:=%" == "%paket%" (
  echo ドロップなしcallbatセット無
  set "AAC_DROPED=AAC_NON_DROP"
  timeout /t 10
  if defined paketsub goto paket_sub
) else (
    echo ドロップありcallbatセット有
    set "AAC_DROPED=AAC_DROPED"
    timeout /t 10
  )
goto set_exit
:paket_sub
if not "%paketsub:Drop:        0  Scramble:=%" == "%paketsub%" (
  echo SUBドロップなしcallbatセット無
  set "AAC_DROPED=AAC_NON_DROP"
  timeout /t 10
  ) else (
    echo SUBドロップありcallbatセット有
    set "AAC_DROPED=AAC_DROPED"
    timeout /t 10
          )
goto set_exit

:skip_drop_chkk
"C:\12\x86\Multi2DecDos.exe" /C "%~1" "%~dpn1_dec.txt"
for /F "tokens=* delims=" %%d in ('findstr "/c:0x0341" "/c:0x104F" "/c:0x104C" "/c:0x1048" "/c:0x1045" "/c:0x104E" "/c:0x1047" "/c:0x1046" "/c:0x104D" "/c:0x0210" "/c:0x1041" "/c:0x0410" "/c:0x0110" "/c:0x0112" "/c:0x0141" "/c:0x0241" "/c:0x1042" "%~dpn1_dec.txt"') do @set paket=%%d
if not defined paket goto set_exit
echo. %paket%
if not "%paket:Drop: 0=%" == "%paket%" (
  echo ドロップなしcallbatセット無
  set "AAC_DROPED=AAC_NON_DROP"
  timeout /t 10
) else (
  echo ドロップありcallbatセット有
  timeout /t 10
  set "AAC_DROPED=AAC_DROPED"
  )
goto set_exit

for /F "tokens=* delims=" %%d in ('findstr "/c:0x0111" "/c:0x0111" "/c:0x1047" "/c:0x1058" "/c:0x1C02" "%~dpn1_dec.txt"') do @set paketsub=%%d
if not defined paketsub goto set_exit
echo. %paketsub%
if not "%paketsub:Drop: 0=%" == "%paketsub%" (
  echo ドロップなしcallbatセット無
  set "AAC_DROPED=AAC_NON_DROP"
  timeout /t 10
) else (
  echo ドロップありcallbatセット有
  timeout /t 10
  set "AAC_DROPED=AAC_DROPED"
  )


goto set_exit
if not defined AAC_DROPED  set "AAC_DROPED=AAC_DROPED_NULL"

timeout /t 44
:exitt

:set_exit
exit /b 0
