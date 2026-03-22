@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0.."

echo ========================================
echo Starting CripCraft
echo ========================================
echo This build is configured for LOCAL TESTING.
echo Username verification is disabled so you can join localhost.
echo.

where java >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Java was not found.
  echo Install Java 21 first.
  pause
  exit /b 1
)

if not exist "downloads\vanilla-server-1.20.4.jar" (
  echo [ERROR] The official server jar is missing.
  echo Run scripts\setup.bat first.
  pause
  exit /b 1
)

if not exist "server\runtime" mkdir "server\runtime"
if not exist "server\runtime\server.properties" (
  echo Copying the CripCraft server template for first launch...
  xcopy /E /I /Y "server\template\*" "server\runtime\" >nul
)

set PROPS_FILE=server\runtime\server.properties
if exist "%PROPS_FILE%" (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-Content '%PROPS_FILE%') -replace '^online-mode=.*','online-mode=false' | Set-Content '%PROPS_FILE%'"
)

set EULA_FILE=server\runtime\eula.txt
if not exist "%EULA_FILE%" (
  >"%EULA_FILE%" echo eula=false
)
findstr /C:"eula=true" "%EULA_FILE%" >nul
if errorlevel 1 (
  echo.
  echo Minecraft requires EULA acceptance before the server can start.
  echo Read the EULA here: https://aka.ms/MinecraftEULA
  set /p ACCEPT=Type YES to accept the EULA and continue: 
  if /I not "!ACCEPT!"=="YES" (
    echo EULA not accepted. Closing.
    pause
    exit /b 1
  )
  >"%EULA_FILE%" echo eula=true
)

echo.
echo Starting the server window...
echo Wait for the word Done in the server window.
echo Then open Minecraft Java Edition 1.20.4 and join localhost.
echo If localhost does not work, try 127.0.0.1.
echo.
cd /d "server\runtime"
java -Xms1G -Xmx2G -jar "..\..\downloads\vanilla-server-1.20.4.jar" nogui
