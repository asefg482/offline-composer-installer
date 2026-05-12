@echo off
setlocal

@REM set "COMPOSER_DIR=C:\composer"
set "COMPOSER_DIR=%~dp0"

for /f "tokens=2,*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul') do set "SYS_PATH=%%B"

if not defined SYS_PATH (
    echo [ERROR] System PATH not found !.
    pause
    exit /b 1
)

echo %SYS_PATH% | find /I "%COMPOSER_DIR%" >nul
if %errorlevel%==0 (
    echo [INFO] %COMPOSER_DIR% composer added to your system PATH.
    pause
    exit /b 1
    goto :done
)

setx /M PATH "%SYS_PATH%;%COMPOSER_DIR%" >nul

if %errorlevel%==0 (
    echo [OK] %COMPOSER_DIR% added to System PATH.
    echo [INFO] Open a new PowerShell or cmd for test.
    pause
    exit /b 1
) else (
    echo [ERROR] Please Run as Administrator script.
    pause
    exit /b 1
)

:done
endlocal