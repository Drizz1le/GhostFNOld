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

:: Check for Python Installation
py -3 --version 2>NUL
if errorlevel 1 goto errorNoPython

:: Reaching here means Python is installed.
IF EXIST "python-3.6.0-amd64.exe" (
    del "python-3.6.0-amd64.exe"
)

cls
echo [Info] Python is installed!
ECHO [Info] Installing the required packages!
TIMEOUT 3

py -3 -m pip install -U -r requirements.txt

ECHO [Info] Successfully installed packages!
goto nodejs


:: Once done, exit the batch file -- skips executing the errorNoPython section

:errorNoPython
echo [Info] Error^: Python not installed or not added to PATH.
:: set mypath=%cd%
:: bitsadmin.exe /transfer "InstallPython" https://www.python.org/ftp/python/3.7.0/python-3.7.0-amd64.exe %mypath%\python-3.7.0-amd64.exe

IF EXIST "python-3.7.0-amd64.exe" (
    echo [Info] Python Installer is already installed, install and/or add Python to PATH
) ELSE (
    echo [Info] Installing Python Installer now, this will take a minute or 2.
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.6.0/python-3.6.0-amd64.exe', 'python-3.7.0-amd64.exe')"
    powershell -Command "Invoke-WebRequest https://www.python.org/ftp/python/3.7.0/python-3.7.0-amd64.exe -OutFile python-3.7.0-amd64.exe"   
    echo [Info] Python Installer is now installed, install and/or add Python to PATH.
    goto nodejs
)

:nodejs
set NULL_VAL=null
set NODE_VER=%NULL_VAL%
set NODE_EXEC=node-v10.15.3-x86.msi

node -v >.tmp_nodever
set /p NODE_VER=<.tmp_nodever
del .tmp_nodever

IF "%NODE_VER%"=="%NULL_VAL%" (
	echo.
	echo [Info] Node.js is not installed! Please press a key to download and install it from the website that will open.
	PAUSE
	start "" https://nodejs.org/en/download
	echo.
	echo.
	echo [Info] After you have installed Node.js, restart this command to make sure it is installed.
	PAUSE
	EXIT
) ELSE (
	echo [Info] A version of Node.js ^(%NODE_VER%^) is installed.
	echo [Info] Installing nodejs packages...
	npm install
	echo [Info] Done!
	pause
	goto begin
)



:op6
title Credits - Drizz1le
cls

echo Made by @drizz1le on discord. 
echo ----------------------------

pause
goto begin

:exit
@exit