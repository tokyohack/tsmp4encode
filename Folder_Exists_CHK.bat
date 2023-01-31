REM ロゴ系フォルダが無い場合作成
if not exist "%drivepath%:\15r%NOLOgo%\" md "%drivepath%:\15r%NOLOgo%\"
REM ロゴ系フォルダが無い場合作成

REM VIDEO_TSフォルダが無い場合作成
if not exist "%drivepath%:\VIDEO_TS\" md "%drivepath%:\VIDEO_TS\"
REM VIDEO_TSフォルダが無い場合作成

REM TSフォルダが無い場合作成
if not exist "%drivepath%:\TS\" md "%drivepath%:\TS\"
REM TSフォルダが無い場合作成

exit /b
