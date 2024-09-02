# Function to list directories and files
function Get-DirectoryFileCounts {
    param (
        [string[]]$FileExtensions
    )
    
    # Initialize an array to store all files
    $allFiles = @()
    
    foreach ($extension in $FileExtensions) {
        # Find all files of the specified type
        $files = Get-ChildItem -Path C:\ -Recurse -File -Include *$extension -ErrorAction SilentlyContinue
        $allFiles += $files
    }
    
    if ($allFiles.Count -eq 0) {
        Write-Host "No files with the specified extensions were found."
        return
    }

    # Group files by their directory
    $fileGroups = $allFiles | Group-Object -Property DirectoryName | Sort-Object Count -Descending
    
    # Display directories and file counts
    $index = 1
    $fileGroups | ForEach-Object {
        Write-Host "$index. $($_.Name) - $($_.Count) files"
        $index++
    }
    
    # Return the list of directories for later selection
    return $fileGroups
}

# Main script
Clear-Host
Write-Host "Welcome to the File Finder Script"
Write-Host "--------------------------------"

# Get file extensions from user
$fileExtensionsInput = Read-Host "Enter the file extensions to search for (e.g., '.txt, exe, ps1, docx, jpg, png, bat')"
$fileExtensions = $fileExtensionsInput -split '\s*,\s*' | ForEach-Object { "*$_" }

# Get directory file counts
$fileGroups = Get-DirectoryFileCounts -FileExtensions $fileExtensions

if ($fileGroups -ne $null) {
    # Get user selection
    $choice = Read-Host "Enter the number of the directory you want to navigate to"
    
    if ($choice -ge 1 -and $choice -le $fileGroups.Count) {
        $selectedDirectory = $fileGroups[$choice - 1].Name
        Write-Host "Navigating to directory: $selectedDirectory"
        Start-Process explorer.exe $selectedDirectory
    } else {
        Write-Host "Invalid choice. Please run the script again and select a valid number."
    }
}
