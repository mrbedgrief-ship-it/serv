@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0.."

set PRISM_EXE=launcher\PrismPortable\prismlauncher.exe
set PRISM_DATA=launcher\prism-data
set INSTANCE_ID=cripcraft-zone-frontier

echo ========================================
echo CripCraft Play
echo ========================================
echo This will start the local server and then launch the game.
echo Turn shaders OFF before testing.
echo.

if not exist "%PRISM_EXE%" (
  echo [ERROR] Prism Launcher is missing.
  echo Run scripts\setup.bat first.
  pause
  exit /b 1
)

if not exist "%PRISM_DATA%\instances\%INSTANCE_ID%\instance.cfg" (
  echo [ERROR] The CripCraft game instance is missing.
  echo Run scripts\setup.bat first.
  pause
  exit /b 1
)

start "CripCraft Server" cmd /c scripts\start-server.bat

echo Waiting a few seconds for the server to begin starting...
timeout /t 12 /nobreak >nul

echo Launching the CripCraft game instance...
start "CripCraft Game" "%PRISM_EXE%" -d "%PRISM_DATA%" -l "%INSTANCE_ID%" -s localhost
