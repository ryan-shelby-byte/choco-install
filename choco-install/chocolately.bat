@echo off
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
    ) else (
        echo ######## ########  ########   #######  ########  
   echo ##       ##     ## ##     ## ##     ## ##     ## 
   echo ##       ##     ## ##     ## ##     ## ##     ## 
   echo ######   ########  ########  ##     ## ########  
   echo ##       ##   ##   ##   ##   ##     ## ##   ##   
   echo ##       ##    ##  ##    ##  ##     ## ##    ##  
   echo ######## ##     ## ##     ##  #######  ##     ## 
   echo.
   echo.
   echo ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
   echo This script must be run as administrator to work properly!  
   echo If you're seeing this after clicking on a start menu icon, then right click on the shortcut and select "Run As Administrator".
   echo ##########################################################
    )

    popd
    Pause
	
CLS
set currentpath=%cd%
echo "Starting automatic file installation by chocolatey"
ECHO.
:MENU
ECHO ...............................................
ECHO PRESS 1, 2 to 3 select your task, or 4 to EXIT.
ECHO FIRST TIME press 1!
ECHO ...............................................
ECHO.
ECHO 1 - Install Chocolatey
ECHO 2 - Install apps
ECHO 3 - Upgrade apps
ECHO 4 - EXIT
ECHO.


SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==1 GOTO FIR
IF %M%==2 GOTO GEN
IF %M%==3 GOTO UPG
IF %M%==4 GOTO EOF


REM developer tools
:FIR
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco feature enable -n allowGlobalConfirmation
choco upgrade chocolatey
ECHO ...............................................
ECHO A RESTART OF THE BATCH FILE MAYBE NECESSARY!!
ECHO ...............................................
ECHO ...............................................
GOTO MENU

:GEN
REM basic apps
choco install %currentpath%\apps.config   
GOTO MENU

:UPG
choco upgrade all
GOTO MENU

:EOF
