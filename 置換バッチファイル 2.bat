@echo off

setlocal enabledelayedexpansion

if [%1]==[] goto usage

set input_file=%1
set output_file=%~n1_replaced%~x1

set tmp_file=%~n1_tmp.txt

powershell -Command "(Get-Content -Path '%input_file%' -Raw) -replace [Environment]::NewLine, '@@@' | Set-Content -Path '%tmp_file%'"

powershell -Command "(Get-Content -Path '%tmp_file%' -Raw) -replace '2023/3/4 23:53:12 Code=12@@@Len=12 \+0 \+1 \+2 \+3 \+4 \+5 \+6 \+7  \+8 \+9 \+A \+B \+C \+D \+E \+F@@@0000   FF 46 cb 86 11 d1 c4 3c  ea b9 c0 20 08 00 45 00@@@0010   05 ae cd 4c 00 00 37 06  d4 7d 34 df db f5 c0 a8', '' | Set-Content -Path '%output_file%'"

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