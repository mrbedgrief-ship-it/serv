@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0.."

echo ========================================
echo Starting CripCraft Forge Server
echo ========================================
echo Local testing mode is enabled.
echo Username verification is OFF for localhost testing.
echo Turn shaders OFF on the client before joining.
echo.

where java >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Java was not found.
  echo Install Java 17 first.
  pause
  exit /b 1
)

if not exist "server\runtime\run.bat" (
  echo [ERROR] Forge server is not installed yet.
  echo Run scripts\setup.bat first.
  pause
  exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\repair.ps1"
if errorlevel 1 (
  echo [ERROR] Repair/sync step failed.
  pause
  exit /b 1
)

set EULA_FILE=server\runtime\eula.txt
if not exist "%EULA_FILE%" (
  >"%EULA_FILE%" echo eula=false
)
findstr /C:"eula=true" "%EULA_FILE%" >nul
if errorlevel 1 (
  echo.
  echo Minecraft requires EULA acceptance before the Forge server can start.
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
echo Starting the Forge server...
echo Wait for the word Done in the server window.
echo Then launch Minecraft Forge 1.20.1 and join localhost.
echo If localhost does not work, try 127.0.0.1.
echo.
cd /d "server\runtime"
call run.bat --nogui
