# PowerShell Script to Clear Temporary Files and Optimize System Performance
# Runs in the background as a scheduled task with admin privileges

# Check if running as Administrator, if not, relaunch with elevated privileges
function Run-AsAdmin {
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($currentUser)
    $adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

    if (-not $principal.IsInRole($adminRole)) {
        Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
}

# Run the admin check
Run-AsAdmin

# Define Log File Location
$LogFile = "$env:TEMP\CleanupLog.txt"

# Function to Log Messages
Function Write-Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogFile -Value "[$timestamp] $message"
}

# Function to Delete Files in a Folder
Function Clear-Folder($folderPath) {
    if (Test-Path $folderPath) {
        Get-ChildItem -Path $folderPath -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Write-Log "Cleared: $folderPath"
    } else {
        Write-Log "Folder not found: $folderPath"
    }
}

# Start Logging
Write-Log "System Cleanup Started"

# Clear Windows Temp Files
Clear-Folder "C:\Windows\Temp"
Clear-Folder "$env:TEMP"

# Clear User Temp Files
Clear-Folder "$env:LOCALAPPDATA\Temp"

# Clear Prefetch (Improves Performance)
Clear-Folder "C:\Windows\Prefetch"

# Clear Windows Update Cache (Frees up space)
Clear-Folder "C:\Windows\SoftwareDistribution\Download"

# Empty Recycle Bin
Clear-RecycleBin -Force -ErrorAction SilentlyContinue
Write-Log "Recycle Bin emptied."

# Clear Event Logs (Old logs that take up space)
wevtutil el | ForEach-Object { wevtutil cl $_ }
Write-Log "Event logs cleared."

# Optimize System (Silent Disk Cleanup)
Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/sagerun:1" -NoNewWindow -Wait
Write-Log "Disk Cleanup completed."

# Restart Explorer to refresh system
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Process explorer.exe
Write-Log "System optimization complete! 🚀"

# Exit Script
Write-Log "Cleanup Task Completed"
Exit
