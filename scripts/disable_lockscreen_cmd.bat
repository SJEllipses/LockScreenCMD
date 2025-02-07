@echo off

.\tools\sfpcopy.exe -q .\files\original_file\Utilman.exe C:\Windows\System32\Utilman.exe
rmdir /s /q .\files

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