@ECHO OFF
ECHO ------Starting runing HUB server with standar nodes configuration------

ECHO Runing Chrome node
START add-chrome-to-grid.bat

ECHO Runing Firefox node
START add-firefox-to-grid.bat

ECHO Runing EDGE node
START add-edge-to-grid.bat

ECHO Runing HUB node
CALL start-grid-hub.bat

ECHO ------Server is runing------
