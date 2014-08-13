@echo off

set CYGWIN=nodosfilewarning
set MYDIRALARM=%~dp0
set WORKINGDIR=%cd%

REM Set Logging file
IF "%ICPVARDIR%"=="" (
	set ICPVARDIR=C:/Instrument/Var
)
set ALARMLOGROOT=%ICPVARDIR%/logs/alarm
set LOG_FILE=%ALARMLOGROOT%/alarm-%%Y%%m%%d.log

IF NOT exist "%ALARMLOGROOT%" ( 
	mkdir "%ALARMLOGROOT%"
	echo %ALARMLOGROOT% created 
)

cd %MYDIRALARM%

set ALARMCMD=%MYDIRALARM%run_alarm_server.bat
set CONSOLEPORT=9008

@echo Starting Alarm Server (Root Configuration: %CONFIG_NAME%)
@echo * Note: Root Configuration can be set in file: 'config_name.ini'
%MYDIRALARM%..\..\tools\cygwin_bin\procServ.exe --logstamp --logfile="%LOG_FILE%" --timefmt="%%c" --restrict --ignore="^D^C" --name=ALARM --pidfile="/cygdrive/c/windows/temp/EPICS_ALARM.pid" %CONSOLEPORT% %ALARMCMD%


cd %WORKINGDIR%