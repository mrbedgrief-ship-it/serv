@echo off
setlocal
cd /d "%~dp0.."

echo ========================================
echo CripCraft Setup
echo ========================================
echo This script downloads the official Minecraft Java server jar.
echo.

where java >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Java was not found.
  echo Please install Java 21 first, then run this file again.
  pause
  exit /b 1
)

if exist "downloads\vanilla-server-1.20.4.jar" (
  echo [OK] The server jar is already present.
  echo File: downloads\vanilla-server-1.20.4.jar
  pause
  exit /b 0
)

echo Downloading the official Minecraft server jar for version 1.20.4...
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\download-server.ps1"
if errorlevel 1 (
  echo.
  echo [ERROR] The download failed.
  echo Check your internet connection and try again.
  pause
  exit /b 1
)

echo.
echo [OK] Setup finished.
echo You can now open launcher\start-launcher.bat
pause
