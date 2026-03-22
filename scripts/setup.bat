@echo off
setlocal
cd /d "%~dp0.."

echo ========================================
echo CripCraft Forge Setup
echo ========================================
echo This script prepares the local Forge server.
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
echo 1. Download any missing mod jars if the script told you to.
echo 2. Double-click downloads\forge-1.20.1-47.4.10-installer.jar and click Install client.
echo 3. Copy client-pack\mods\* into %%APPDATA%%\.minecraft\mods\
echo 4. Start launcher\start-launcher.bat
pause
