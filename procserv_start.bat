@echo off

set CYGWIN=nodosfilewarning
set MYDIRALARM=%~dp0
set WORKINGDIR=%cd%

REM Set Logging file
IF "%ICPVARDIR%"=="" (
	set ICPVARDIR=C:\Instrument\Var
)
set ALARMLOGROOT=%ICPVARDIR%\logs\alarm\
set LOG_FILE=%ALARMLOGROOT%\alarm-%%Y%%m%%d.log

IF NOT exist %ALARMLOGROOT%NUL ( 
	mkdir %ALARMLOGROOT%
	echo %ALARMLOGROOT% created 
)

REM get root configuration name from ini file
set CONFIG_NAME=
for /F %%i in ( %MYDIRALARM%config_name.ini ) DO set CONFIG_NAME=%%i

cd %MYDIRALARM%

set ALARMCMD=AlarmServer.exe -root %CONFIG_NAME% -pluginCustomization alarm_server_settings.ini
set CONSOLEPORT=90010

@echo Starting Alarm Server (Root Configuration: %CONFIG_NAME%)
@echo * Note: Root Configuration can be set in file: 'config_name.ini'
%MYDIRALARM%..\..\tools\cygwin_bin\procServ.exe --logstamp --logfile="%LOG_FILE%" --timefmt="%%c" --restrict --ignore="^D^C" --name=ALARM --pidfile="/cygdrive/c/windows/temp/EPICS_ALARM.pid" %CONSOLEPORT% %ALARMCMD%


cd %WORKINGDIR%