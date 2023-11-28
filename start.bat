echo off
@echo off
Mode 52,14
cls
SLEEP 1

set Version=1.1.3

::Highlight Color Blue
set col3=[94m
::Text Color White
set col1=[97m
::Highlight Color Red
set col2=[31m




cls

:begin
title Option Picker - Drizz1le

cls
cls
echo.
echo       %col1%Fortnite Ghost Equiper By %col3%Drizzle%col1%
cd ./other
py ascii.py
cd ../
echo.
echo         %col1%[%col3%1%col1%] Login  [%col3%2%col1%] Ghost Equipper
echo      [%col3%3%col1%] Switch Account  [%col3%4%col1%] Launch 
echo           [%col3%5%col1%] Credits  [%col3%X%col1%] Exit%col2% 
echo.
choice /c:12345XR /n /m "           [ Press a corresponding number ]   Version %Version%"
set MenuItem=%errorlevel%

if "%MenuItem%"=="1" goto op1
if "%MenuItem%"=="2" goto op2
if "%MenuItem%"=="3" goto op4
if "%MenuItem%"=="4" goto op3
if "%MenuItem%"=="5" goto op5
if "%MenuItem%"=="X" goto exit
if "%MenuItem%"=="R" goto reload

echo Please pick an option:
goto begin

:reload
start.bat
goto exit


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
cls
echo.
echo               %col1%Saved auths in %col3%./auths%col1%
echo.
echo ----------------------------------------------------
echo.
cd ./auths
dir /b /o:-g
cd ../
echo.
echo Type the %col3%full name%col1% of the auth you
set /p "selectedAuth=want to select: "

cd ./other
(
echo {
echo   "selectedAccount": "%selectedAuth%"
echo }
) > selectedAccount.json
cd ../


goto begin



:: Check for Python Installation
py -3 --version 2>NUL
if errorlevel 1 goto errorNoPython

:: Reaching here means Python is installed.
IF EXIST "python-3.6.0-amd64.exe" (
    del "python-3.6.0-amd64.exe"
)

=======
>>>>>>> e604b1045cee4a849216c8076dd74c12bfd40313
cls
ECHO [Info] Installing the required python packages!

py -3 -m pip install -U -r requirements.txt

ECHO [Info] Successfully installed packages!

echo [Info] Installing nodejs packages...
npm install
echo [Info] Done!
pause
goto begin




:op5
title Credits - Drizz1le
cls

echo Made by @drizz1le on discord. 
echo ----------------------------

pause
goto begin

:exit
@exit