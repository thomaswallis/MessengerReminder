@echo off
setlocal

REM Configuration
set "messengerLink=https://www.messenger.com/t/100023694813088/"
setlocal enabledelayedexpansion
set "messages[0]=Hey, can i swing by and we can have some tea and hangout?"
set "messages[1]=you up ;)"
set "messages[2]=oi, dont forget im coming by later today"

REM Open Facebook Messenger in Chrome
start chrome "%messengerLink%"

REM Delay to allow time for Messenger to load
timeout /t 10

REM Choose a random message from the list
set /a "rand=%random% %% 3"
set "message=!messages[%rand%]!"

REM Commit message to clipboard
echo %message% | clip

REM Simulate keyboard inputs to paste and send the message
powershell -Command "$wshell = New-Object -ComObject wscript.shell; Start-Sleep -Seconds 2; $wshell.SendKeys('^{V}~')"

REM Close the Messenger window after 5 seconds
timeout /t 5
powershell -Command "Start-Sleep -Seconds 5; Get-Process chrome | Where-Object { $_.MainWindowTitle -match 'Messenger' } | ForEach-Object { $_.CloseMainWindow() | Out-Null }"

endlocal
