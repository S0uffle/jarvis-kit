@echo off
REM Jarvis Kit - Setup Script (Windows)
REM Tạo Python virtual environment và cài dependencies

setlocal enabledelayedexpansion

set SCRIPT_DIR=%~dp0
set VENV_DIR=%SCRIPT_DIR%.venv

echo === Jarvis Kit Setup ===

REM Yeu cau: Python 3.13.x (version da test voi tat ca dependencies)
set REQUIRED_MAJOR=3
set REQUIRED_MINOR=13

REM Tim Python dung version: uu tien py -3.13 > python
set PYTHON_CMD=

REM Thu py launcher voi version cu the (Windows Python Launcher)
py -%REQUIRED_MAJOR%.%REQUIRED_MINOR% --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=py -%REQUIRED_MAJOR%.%REQUIRED_MINOR%
    goto :found_python
)

REM Thu python mac dinh
where python >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=python
    goto :found_python
)

echo ERROR: Khong tim thay Python.
echo Cai Python %REQUIRED_MAJOR%.%REQUIRED_MINOR%.x tu https://www.python.org/downloads/
exit /b 1

:found_python
for /f %%i in ('%PYTHON_CMD% -c "import sys; print(sys.version_info.minor)"') do set PYTHON_MINOR=%%i
for /f %%i in ('%PYTHON_CMD% -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"') do set PYTHON_VERSION=%%i
echo Dung: %PYTHON_CMD% (Python %PYTHON_VERSION%)

if not "%PYTHON_MINOR%"=="%REQUIRED_MINOR%" (
    echo.
    echo WARNING: Yeu cau Python %REQUIRED_MAJOR%.%REQUIRED_MINOR%.x, ban dang dung %PYTHON_VERSION%.
    echo Co the gap loi tuong thich packages.
    echo.
    echo Cach cai Python %REQUIRED_MAJOR%.%REQUIRED_MINOR% song song:
    echo   Download tu https://www.python.org/downloads/
    echo   Khi cai: check "Add to PATH" va "Install py launcher"
    echo   Sau do chay lai setup.bat — script se tu dung py -%REQUIRED_MAJOR%.%REQUIRED_MINOR%
    echo.
    set /p answer=Tiep tuc voi Python %PYTHON_VERSION%? (y/n):
    if not "!answer!"=="y" (
        echo Huy setup.
        exit /b 1
    )
)

REM Tao venv
if exist "%VENV_DIR%" (
    echo venv da ton tai tai %VENV_DIR% — bo qua tao moi.
) else (
    echo Tao virtual environment tai %VENV_DIR% (Python %PYTHON_VERSION%) ...
    %PYTHON_CMD% -m venv "%VENV_DIR%"
)

REM Cài dependencies
echo Cai dependencies...
"%VENV_DIR%\Scripts\pip.exe" install --upgrade pip -q
"%VENV_DIR%\Scripts\pip.exe" install -r "%SCRIPT_DIR%requirements.txt" -q

echo.
echo === Setup hoan tat ===
echo venv: %VENV_DIR%
echo.
echo Buoc tiep theo:
echo   1. Authenticate BigQuery: gcloud auth application-default login
echo   2. Mo folder nay trong VSCode va bat dau dung Jarvis

endlocal
