@echo off

set CYGWIN=nodosfilewarning
set MYDIRALARM=%~dp0
set WORKINGDIR=%cd%

call %MYDIRIOCLOG%..\..\config_env_base.bat

REM Set Logging file
IF "%ICPVARDIR%"=="" (
	set ICPVARDIR=C:/Instrument/Var
)
set ALARMLOGROOT=%ICPVARDIR%/logs/alarm

IF NOT exist "%ALARMLOGROOT%" ( 
	mkdir "%ALARMLOGROOT%"
	echo %ALARMLOGROOT% created 
)
for /F "usebackq" %%I in (`cygpath %ALARMLOGROOT%`) do SET ALARMCYGLOGROOT=%%I

set LOG_FILE=%ALARMCYGLOGROOT%/alarm-%%Y%%m%%d.log

cd %MYDIRALARM%

set ALARMCMD=%ComSpec% /c %MYDIRALARM%run_alarm_server.bat
set CONSOLEPORT=9008

@echo Starting Alarm Server (Root Configuration: %CONFIG_NAME%)
@echo * log file - %LOG_FILE%
@echo * Note: Root Configuration can be set in file: 'config_name.ini'
%MYDIRALARM%..\..\tools\cygwin_bin\procServ.exe --logstamp --logfile="%LOG_FILE%" --timefmt="%%c" --restrict --ignore="^D^C" --name=ALARM --pidfile="/cygdrive/c/windows/temp/EPICS_ALARM.pid" %CONSOLEPORT% %ALARMCMD%

cd %WORKINGDIR%