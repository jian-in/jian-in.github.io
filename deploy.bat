@echo off
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File deploy.ps1
pause
