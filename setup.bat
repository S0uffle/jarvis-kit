@echo off
REM Jarvis Kit - Setup Script (Windows)
REM Tạo Python virtual environment và cài dependencies

setlocal enabledelayedexpansion

set SCRIPT_DIR=%~dp0
set VENV_DIR=%SCRIPT_DIR%.venv

echo === Jarvis Kit Setup ===

REM Yeu cau: Python >= 3.13
set REQUIRED_MAJOR=3
set REQUIRED_MINOR=13

REM Tim Python: uu tien py launcher > python
set PYTHON_CMD=

REM Thu py launcher (Windows Python Launcher)
py -3 --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=py -3
    goto :found_python
)

REM Thu python mac dinh
where python >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=python
    goto :found_python
)

echo ERROR: Khong tim thay Python.
echo Cai Python ^>= %REQUIRED_MAJOR%.%REQUIRED_MINOR% tu https://www.python.org/downloads/
exit /b 1

:found_python
for /f %%i in ('%PYTHON_CMD% -c "import sys; print(sys.version_info.minor)"') do set PYTHON_MINOR=%%i
for /f %%i in ('%PYTHON_CMD% -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"') do set PYTHON_VERSION=%%i
echo Dung: %PYTHON_CMD% (Python %PYTHON_VERSION%)

for /f %%i in ('%PYTHON_CMD% -c "import sys; print(sys.version_info.major)"') do set PYTHON_MAJOR=%%i
if %PYTHON_MAJOR% LSS %REQUIRED_MAJOR% goto :version_too_old
if %PYTHON_MAJOR% EQU %REQUIRED_MAJOR% if %PYTHON_MINOR% LSS %REQUIRED_MINOR% goto :version_too_old
goto :version_ok

:version_too_old
echo.
echo ERROR: Yeu cau Python ^>= %REQUIRED_MAJOR%.%REQUIRED_MINOR%, ban dang dung %PYTHON_VERSION%.
echo.
echo Download Python %REQUIRED_MAJOR%.%REQUIRED_MINOR% tro len tu https://www.python.org/downloads/
echo Khi cai: check "Add to PATH" va "Install py launcher"
exit /b 1

:version_ok

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
