@echo off

:: 1. Prüfen: Sind wir Admin?
net session >nul 2>&1
set "IS_ADMIN=%errorLevel%"

:: 2. Prüfen: Kommen wir gerade aus dem Selbstanlauf? (Marker checken)
if "%1"=="--elevated" goto :MAIN_START

:: 3. Wenn KEIN Admin -> Countdown zeigen und hochstufen
if %IS_ADMIN% neq 0 (
echo ====================================================
echo        NIJENNA ROBOCOPY ALLROUNDER
echo ====================================================
echo.
echo [^!] USE AT YOUR OWN RISK [^!] 
echo I am not responsible for any data loss or damage 
echo caused by using this script.
echo.
echo ====================================================
echo.
    timeout /t 1 /nobreak >nul
    echo Asking for Admin Rights in 3...
    timeout /t 1 /nobreak >nul
    echo Asking for Admin Rights in 2...
    timeout /t 1 /nobreak >nul
    echo Asking for Admin Rights in 1...
    
    :: Neustart mit Marker --elevated
    powershell -Command "Start-Process -FilePath '%0' -ArgumentList '--elevated' -Verb RunAs"
    exit /b
)

:MAIN_START
setlocal enabledelayedexpansion

:: --- Log-Verzeichnis erstellen ---
set "LOG_DIR=%USERPROFILE%\Documents\Nijenna Robocopy Log"
if not exist "%LOG_DIR%" (
    mkdir "%LOG_DIR%" [cite: 23]
)

:: --- Der Header für das Arbeitsfenster ---
echo ====================================================
echo        NIJENNA ROBOCOPY ALLROUNDER
echo ====================================================
echo.
echo [^^!] USE AT YOUR OWN RISK [^^!] 
echo I am not responsible for any data loss or damage 
echo caused by using this script.
echo.
echo ====================================================
echo.

:START
set /p "SOURCE=Bitte Quellpfad eingeben: "


:: Anführungszeichen entfernen, falls der Nutzer sie mitkopiert hat
set "SOURCE=%SOURCE:"=%"

:: Validierung
if not exist "%SOURCE%" (
    echo.
    echo ----------------------------------------------------
    echo ERROR: Sourcepath not found!
    echo Please check your path and copy ^& paste it again
    echo Hint: to copy you can use right mouse button instead
    echo ----------------------------------------------------
    echo.
    goto :START
)

set /p "DEST=Bitte Zielpfad eingeben: "
set "DEST=%DEST:"=%"

:: --- Zeitstempel fuer Log-Datei ---
set "t=%date:~-4%-%date:~3,2%-%date:~0,2%_%time:~0,2%-%time:~3,2%"
set "t=%t: =0%"
set "LOG_FILE=%LOG_DIR%\Log_%t%.txt"

:: --- Robocopy Ausfuehrung ---
echo.
echo Kopiere von: "%SOURCE%"
echo Nach:        "%DEST%"
echo Log:         "%LOG_FILE%"
echo.
echo Vorgang laeuft...

:: /E       : Unterverzeichnisse (auch leere)
:: /ZB      : Restartable + Backup Modus
:: /COPYALL : Alle Infos (Attribute, Zeitstempel, ACLs)
:: /XJ      : Junction Points ignorieren
:: /R:3 /W:5: Wiederholungen bei Fehlern
:: /MT:16   : Multi-Threading
:: /TEE     : Anzeige in Konsole + Log
:: /V       : Ausfuehrliche Statusmeldung

robocopy "%SOURCE%" "%DEST%" /E /ZB /COPYALL /XJ /R:3 /W:5 /MT:16 /V /TEE /LOG:"%LOG_FILE%"

echo.
echo ====================================================
echo Vorgang abgeschlossen.
echo Log-Datei: "%LOG_FILE%"
echo ====================================================
pause
