# VeeamTest
Veeam Test - Synchronizing two folders

It's not necessary but I created a virtual environment: venv
To activate this environment use the command: venv/Scripts/Activate

To execute a script I had to use the command below on visual studio code:
Set-ExecutionPolicy Unrestricted -Scope Process

To run the script use this command, with your correct paths:
.\SyncFolders.ps1 -originalFolder "C:\Users\Pedro Jorge\Documents\Veeam Test\Original" -replicaFolder "C:\Users\Pedro Jorge\Documents\Veeam Test\Replica" -logFilePath "C:\Users\Pedro Jorge\Documents\Veeam Test\LOGG.txt"
