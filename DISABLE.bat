@echo off
pushd %~dp0

if not exist "%~dp0tools\sfpcopy.exe" (
    echo sfpcopy.exe not exists, starting download...
    echo.
    call %~dp0scripts\get_sfpcopy.bat
    if errorlevel 1 (
        exit /b 1
    )
) else (
    echo sfpcopy.exe exists
)

if not exist "%~dp0tools\run_as_admin.exe" (
    echo Error: run_as_admin.exe not exists, administrator privileges are required.
    pause
    exit /b 1
)

%~dp0tools\run_as_admin.exe .\scripts\disable_lockscreen_cmd.bat