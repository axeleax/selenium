#Gecko Driver compatible with FF >= 60 version  (Drivers page - https://github.com/mozilla/geckodriver/releases/download/v0.29.1/)
java -Dwebdriver.gecko.driver="C:\selenium\driver\geckodriver.exe" -jar "C:\selenium\selenium-server-standalone-3.141.59.jar" -role node -nodeConfig C:\selenium\firefox.json
exit