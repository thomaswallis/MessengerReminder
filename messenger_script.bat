@echo off
setlocal

::This works by essentially opening google chrome, going to a specific facebook messenger link, picking a random message
::once it has picked a message it will comit the message to your clipboard and then paste and send the message in the fb chat
::it isnt anything complicated but it works, i wrote this in bat as i have a windows based homeserver

REM Configuration
REM replace YOURCHATLINK with the URL from the chat you wish to talk to someone on
set "messengerLink=https://www.messenger.com/t/YOURCHATLINK/"
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
