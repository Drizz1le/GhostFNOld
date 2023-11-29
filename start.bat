@echo off


Mode 52,14
cls
SLEEP 1

set Version=1.02

::Highlight Color Blue
set col3=[94m
::Text Color White
set col1=[97m
::Highlight Color Red
set col2=[31m

::Highlight Color Green
set col4=[2m




cls

:begin
title Option Picker - Drizz1le
Mode 52,14
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
echo           [%col3%5%col1%] Settings  [%col3%X%col1%] Exit%col2% 
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
cd ./other
py fortnite.py
cd ../
goto exit

:op2
title Ghost Equiper - Drizz1le
cls
cd ./other
npm start
cd ../
cls
goto begin

:op3
title Launch Code Generator - Drizz1le
set /p exchangeCode=Type Enter your exchange code:
set /p account_id=Type Enter your account ID:


start /d "C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64" FortniteLauncher.exe -AUTH_LOGIN=unused -AUTH_PASSWORD=%exchangeCode% -AUTH_TYPE=exchangecode -epicapp=Fortnite -epicenv=Prod -EpicPortal -epicuserid=%account_id%
goto begin

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

goto begin


:op5
cls
cd ./other
set /p crownWins=<crowns.txt
cd ../

set UseGUI=%col3%True
echo.
echo                                          %col2%Page 1/1
echo  %col1%[%col2%1%col1%] Crown wins [ %col3%%crownWins%%col1% ]
echo  [90mChange the number of crown wins you have
echo.
echo  %col1%[%col2%2%col1%] Re-install packages
echo  [90mThis will re-install all packages required to work
echo.
echo  %col1%[%col2%3%col1%] Use separate GUI %UseGUI%
echo  [90mUses a GUI vs Terminal for ghost equipping
echo.
echo  %col1%[%col2%4%col1%] Credits
echo  [90mSee the credits for this program%col1%
echo.
choice /c:1234X /n /m "%BS%                [X] Exit"

set MenuItem=%errorlevel%

if "%MenuItem%"=="1" goto changeCrowns
if "%MenuItem%"=="2" goto reinstall
if "%MenuItem%"=="3" goto op4
if "%MenuItem%"=="4" goto op3
if "%MenuItem%"=="X" goto begin

goto begin

:reinstall
echo [Info] Installing required python packages
pip install -r requirements.txt
echo [Info] Installing required nodejs packages
cd ./other
npm i
cd ../
pause
goto op5

:changeCrowns
echo [Note] Crown wins with a value of 0 makes everyones levels disappear
set /p "crowns=[Info] Please enter a number of crown wins: "
cd ./other
(
echo {
echo     "numOfCrowns": %crowns%
echo }
) > settings.json

echo %crowns% > crowns.txt
cd ../
goto op5

:exit
@exit