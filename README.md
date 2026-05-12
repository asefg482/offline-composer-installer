## 📌 Description (English)

This project provides a lightweight `.bat` script that:

- Detects current **System PATH** from Windows Registry
- Checks whether Composer directory already exists in PATH
- Adds Composer directory to **System PATH** (machine-level) if not present
- Prints clear success/error messages

It is useful for users who want to run Composer globally in `cmd` / `PowerShell` without manually editing environment variables.

---

## 📌 توضیحات (فارسی)

این پروژه یک اسکریپت ساده‌ی Batch برای ویندوز است که:

- مقدار فعلی **System PATH** را از رجیستری ویندوز می‌خواند
- بررسی می‌کند مسیر Composer از قبل وجود دارد یا نه
- اگر وجود نداشته باشد، آن را به **System PATH** (سطح سیستم) اضافه می‌کند
- پیام‌های واضح موفقیت/خطا نمایش می‌دهد

این ابزار برای زمانی مفید است که بخواهید Composer به‌صورت سراسری در `cmd` یا `PowerShell` اجرا شود، بدون تنظیم دستی Environment Variables.

---

## ⚙️ Script

```bat
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
```
