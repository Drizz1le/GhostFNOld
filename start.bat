echo off
@echo off


cls

:begin
cls
title Option Picker - Drizz1le

py ascii.py

echo Select an Option:
echo 1) Generate an auth code [ Needed for ghost equip to work ]
echo 2) Start ghost equip program
echo 3) Generate an launch code [ Windows 10 only ]
echo 4) Account page launch
echo 5) Install Python, NodeJS and packages [ Needed for everything to work ]
echo 6) Credits
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4
if "%op%"=="5" goto op5

echo Please pick an option:
goto begin


:op1
title Auth Generator - Drizz1le
py fortnite.py
goto exit

:op2
title Ghost Equiper - Drizz1le
cls
npm start
cls
goto begin

:op3
title Launch Code Generator - Drizz1le
set /p exchangeCode=Type Enter your exchange code:
set /p account_id=Type Enter your account ID:


start /d "C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64" FortniteLauncher.exe -AUTH_LOGIN=unused -AUTH_PASSWORD=%exchangeCode% -AUTH_TYPE=exchangecode -epicapp=Fortnite -epicenv=Prod -EpicPortal -epicuserid=%account_id%
goto exit 

:op4
set /p exchangeCode=Type Enter your exchange code:
start "" https://www.epicgames.com/id/exchange?exchangeCode=%exchangeCode%

:op5
cls
ECHO [Info] Installing the required python packages!

py -3 -m pip install -U -r requirements.txt

ECHO [Info] Successfully installed packages!

echo [Info] Installing nodejs packages...
npm install
echo [Info] Done!
pause
goto begin




:op6
title Credits - Drizz1le
cls

echo Made by @drizz1le on discord. 
echo ----------------------------

pause
goto begin

:exit
@exit