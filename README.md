# VeeamTest
Veeam Test - Synchronizing two folders

I used Powershell

It's not necessary but I created a virtual environment: venv
To activate this environment use the command: venv/Scripts/Activate

To execute a script I had to use the command below on visual studio code:
Set-ExecutionPolicy Unrestricted -Scope Process

To run the script use this command, with your correct paths:
.\SyncFolders.ps1 -originalFolder "C:\Users\Pedro Jorge\Documents\GitHub\VeeamTest\Original" -replicaFolder "C:\Users\Pedro Jorge\Documents\GitHub\VeeamTest\Replica" -logFilePath "C:\Users\Pedro Jorge\Documents\GitHub\VeeamTest\LOGG.txt"