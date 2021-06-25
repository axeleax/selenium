#Microsoft Edge Driver  (Drivers page - https://msedgedriver.azureedge.net/80.0.361.109/)
java -Dwebdriver.edge.driver="C:\selenium\driver\msedgedriver.exe" -jar "C:\selenium\selenium-server-standalone-3.141.59.jar" -role node -nodeConfig "C:\selenium\edge.json"
exit