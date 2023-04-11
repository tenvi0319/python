@echo off

setlocal enabledelayedexpansion

if [%1]==[] goto usage

set input_file=%1
set output_file=%~n1_replaced%~x1

set tmp_file=%~n1_tmp.txt

powershell -Command "(Get-Content -Path '%input_file%' -Raw) -replace [Environment]::NewLine, '@@@' | Set-Content -Path '%tmp_file%'"

powershell -Command "(Get-Content -Path '%tmp_file%' -Raw) -replace 'a@@@b@@@c', 'd' | Set-Content -Path '%output_file%'"

powershell -Command "(Get-Content -Path '%output_file%' -Raw) -replace '@@@', [Environment]::NewLine | Set-Content -Path '%output_file%'"

:: Remove empty lines
powershell -Command "(Get-Content -Path '%output_file%') | Where-Object { $_.Trim() -ne '' } | Set-Content -Path '%output_file%'"

del "%tmp_file%"

echo Done.
pause
exit /b

:usage
echo Usage: %0 ^<file_path^>
pause
exit /b