@echo off
setlocal
cd /d "%~dp0.."

echo ========================================
echo CripCraft Setup

echo ========================================
echo This script prepares the local server and the playable game client.
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\setup.ps1"
if errorlevel 1 (
  echo.
  echo [ERROR] Setup did not finish successfully.
  pause
  exit /b 1
)

echo.
echo [OK] Setup finished.
echo Next steps:
echo 1. If mod pages opened, download the missing jars and place them into the folders shown.
echo 2. Double-click launcher\start-launcher.bat
echo 3. Click Check Files
echo 4. Click Play
pause
