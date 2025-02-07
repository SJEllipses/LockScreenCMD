@echo off

if not exist ".\tools\extract_one_file.exe" (
    echo Error: extract_one_file.exe not exists.
    pause
    exit /b 1
)

mkdir temp

powershell -Command "Invoke-WebRequest -Uri "https://download.microsoft.com/download/3/1/9/319F5FDB-4E78-4C20-8696-F71E8B6AA34A/14393.67.160804-2231.rs1_release_amd64fre_IOTCORE_PACKAGES.iso" -OutFile ".\temp\win10iotcore.iso""
.\tools\extract_one_file.exe .\temp\win10iotcore.iso "Windows_10_IoT_Core_X64_Packages.msi" .\temp iso
.\tools\extract_one_file.exe .\temp\Windows_10_IoT_Core_X64_Packages.msi "765fbafcc84c528ffe77df97cbce70f0.cab" .\temp msi
.\tools\extract_one_file.exe .\temp\765fbafcc84c528ffe77df97cbce70f0.cab "fil4cfed34a04a06069f08b7eca0e5b1f17" .\temp cab
.\tools\extract_one_file.exe .\temp\fil4cfed34a04a06069f08b7eca0e5b1f17 "amd64_microsoft-windows-sfpcopy_31bf3856ad364e35_10.0.14393.67_none_0e3eefda7177f36e\sfpcopy.exe" .\temp cab

copy .\temp\amd64_microsoft-windows-sfpcopy_31bf3856ad364e35_10.0.14393.67_none_0e3eefda7177f36e\sfpcopy.exe .\tools\sfpcopy.exe
rmdir /s /q .\temp

echo.
if exist ".\files\sfpcopy.exe" (
    echo sfpcopy.exe downloaded successfully.
) else (
    echo Fail to get sfpcopy.exe.
    pause
    exit /b 1
)