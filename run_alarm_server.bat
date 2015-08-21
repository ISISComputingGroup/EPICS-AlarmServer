@echo off

set MYDIRALARM=%~dp0

call %MYDIRALARM%..\..\..\config_env_base.bat

%HIDEWINDOW% h

REM get root configuration name from ini file
set CONFIG_NAME=
for /F %%i in ( %MYDIRALARM%config_name.ini ) DO set CONFIG_NAME=%%i

@echo Starting Alarm Server (Root Configuration: %CONFIG_NAME%)
%MYDIRALARM%AlarmServer.exe -root %CONFIG_NAME% -pluginCustomization %MYDIRALARM%alarm_server_settings.ini