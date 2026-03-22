@echo off
setlocal
cd /d "%~dp0.."

echo ========================================
echo CripCraft Repair

echo ========================================
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\repair.ps1"
if errorlevel 1 (
  echo.
  echo [ERROR] Repair did not finish successfully.
  pause
  exit /b 1
)

echo.
echo [OK] Repair finished.
pause
