:start
cls
@echo off

powershell.exe Set-ExecutionPolicy Unrestricted -Scope CurrentUser
powershell.exe .\NewADUser.ps1

Echo.
Echo.
Echo.
Echo Finished.
Echo.
:choice
Echo Create Another 
choice 
if errorlevel=2 goto end
if errorlevel=1 goto start
goto choice

:end
exit

