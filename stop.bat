@ECHO OFF
ECHO ------Stopping Nodes processes and HUB server process------

FOR %%P IN (5555 5556 5557 5558 4444) DO (
    ECHO Stoping port %%P
    FOR /F "tokens=5" %%T IN ('netstat -a -n -o ^| findstr %%P') DO (
        ECHO ProcessId to kill = %%T
        TASKKILL /f /pid %%T 
    )   
)
ECHO ------Server and Nodes were stopped------
PAUSE