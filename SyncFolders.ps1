param (
    [string]$originalFolder,
    [string]$replicaFolder,
    [string]$logFilePath
)

function Log_Message {
    param (
        [string]$message
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $message"
    Add-Content -Path $logFilePath -Value $logEntry
    Write-Host $logEntry
}

function Synchronize_Folders {
    param (
        [string]$originalPath,
        [string]$replicaPath
    )

    # Get list of files and subdirectories in the original folder
    $originalItems = Get-ChildItem -Path $originalPath

    foreach ($item in $originalItems) {
        $originalItemPath = $item.FullName
        $replicaItemPath = Join-Path -Path $replicaPath -ChildPath $item.Name

        if ($item.PSIsContainer) {     #$item.PSIsContainer if is an item that can hold other items, such as a directory (folder).
            # If it's a folder, create it in the replica folder
            if (!(Test-Path -Path $replicaItemPath -PathType Container)) {
                New-Item -Path $replicaItemPath -ItemType Directory | Out-Null
                Log_Message "Created folder: $replicaItemPath"
            }

            # Recursively synchronize subfolders
            Synchronize_Folders -originalPath $originalItemPath -replicaPath $replicaItemPath
        } else {
            # If it's a file, copy it to the replica folder
            Copy-Item -Path $originalItemPath -Destination $replicaItemPath -Force
            Log_Message "Copied file: $replicaItemPath"
        }
    }

    # Remove any items in replica folder that do not exist in the original folder
    $replicaItems = Get-ChildItem -Path $replicaPath
    foreach ($replicaItem in $replicaItems) {
        $originalItem = $originalItems | Where-Object { $_.Name -eq $replicaItem.Name }
        if (!$originalItem) {
            Remove-Item -Path $replicaItem.FullName -Force
            Log_Message "Removed item: $($replicaItem.FullName)"
        }
    }
}

# Check if original and replica paths are provided
if (-not $originalFolder -or -not $replicaFolder -or -not $logFilePath) {
    Write-Host "Usage: .\SyncFolders.ps1 -originalFolder <originalPath> -replicaFolder <replicaPath> -logFilePath <logFilePath>"
    exit
}

# Check if original folder exists
if (-not (Test-Path -Path $originalFolder -PathType Container)) {
    Write-Host "Original folder does not exist."
    exit
}

# Check if replica folder exists; if not, create it
if (-not (Test-Path -Path $replicaFolder -PathType Container)) {
    New-Item -Path $replicaFolder -ItemType Directory | Out-Null
    Log_Message "Created folder: $replicaFolder"
}

# Perform synchronization
Log_Message "Starting synchronization from $originalFolder to $replicaFolder"
Synchronize_Folders -originalPath $originalFolder -replicaPath $replicaFolder
Log_Message "Synchronization completed"

# ---- RUN SCRIPT: ----
# .\SyncFolders.ps1 -originalFolder "C:\Users\Pedro Jorge\Documents\GitHub\VeeamTest\Original" -replicaFolder "C:\Users\Pedro Jorge\Documents\GitHub\VeeamTest\Replica" -logFilePath "C:\Users\Pedro Jorge\Documents\GitHub\VeeamTest\LOGG.txt"