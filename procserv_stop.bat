@echo off

set MYDIR=%~dp0
REM kill procservs that manage log servers, which in turn terminates the log servers

set CSPID=
for /F %%i in ( c:\windows\temp\EPICS_ALARM.pid ) DO set CSPID=%%i
if "%CSPID%" == "" (
    @echo Alarm server is not running
) else (
    @echo Killing Alarm server PID %CSPID%
    %ICPTOOLS%\cygwin_bin\cygwin_kill.exe %CSPID%
    del c:\windows\temp\EPICS_ALARM.pid
)
