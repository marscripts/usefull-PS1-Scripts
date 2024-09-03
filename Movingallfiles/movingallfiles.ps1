Clear-Host

try {
    # Prompt user for the file types they want to move (e.g., *.txt, *.ps1)
    $fileTypes = Read-Host "Enter the file types you want to move (e.g., *.txt, *.ps1), separated by commas"
    
    # Convert the file types input into an array
    $fileTypesArray = $fileTypes.Split(',').Trim()

    # Prompt user for the source directory
    $sourceDirectory = Read-Host "Enter the source directory path"
    $sourceDirectory = $sourceDirectory.Trim()

    # Prompt user for the destination directory
    $destinationDirectory = Read-Host "Enter the destination directory path"
    $destinationDirectory = $destinationDirectory.Trim()

    # Check if the destination directory exists, create it if it doesn't
    if (-not (Test-Path -Path $destinationDirectory)) {
        ni -Path $destinationDirectory -ItemType Directory -ErrorAction Stop
    }

    # Get all files of the specified types in the source directory
    $filesToMove = dir -Path $sourceDirectory -Recurse -Include $fileTypesArray -ErrorAction Stop

    # Move each file to the destination directory
    foreach ($file in $filesToMove) {
        mv -Path $file.FullName -Destination $destinationDirectory -ErrorAction Stop
    }

    Write-Host "All specified files have been moved from $sourceDirectory to $destinationDirectory"
}
catch {
    # Catch any errors and display a meaningful message
    Write-Host "An error occurred: $_" -ForegroundColor Red
}
