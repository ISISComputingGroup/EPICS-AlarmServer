@echo off

REM get root configuration name from ini file
set CONFIG_NAME=
for /F %%i in ( %MYDIRALARM%config_name.ini ) DO set CONFIG_NAME=%%i


@echo Starting Alarm Server (Root Configuration: %CONFIG_NAME%)
start AlarmServer.exe -root %CONFIG_NAME% -pluginCustomization alarm_server_settings.ini