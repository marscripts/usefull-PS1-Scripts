# Function to ensure the file extension starts with a dot
Clear-Host

function Validate-FileExtension {
    param (
        [string]$extension
    )

    if (-not $extension.StartsWith(".")) {
        return ".$extension"
    }
    return $extension
}

try {
    # Prompt user for the file extension they want to create (e.g., .txt, .bat)
    $fileExtension = Read-Host "Enter the file extension you want to create (e.g., .txt, .bat)"
    
    # Validate and format the file extension
    $fileExtension = Validate-FileExtension -extension $fileExtension

    # Prompt user for the number of files they want to create
    $numFiles = Read-Host "Enter the number of files you want to create"

    # Validate that the number entered is a valid integer
    if (-not [int]::TryParse($numFiles, [ref]$null)) {
        Write-Host "Please enter a valid number for the number of files." -ForegroundColor Red
        exit
    }

    # Prompt user for the directory where they want to create the files
    $directoryPath = Read-Host "Enter the destination directory path"

    # Create the directory if it doesn't exist
    if (-not (Test-Path -Path $directoryPath)) {
        New-Item -Path $directoryPath -ItemType Directory
    }

    # Loop to create the specified number of files with the chosen extension
    for ($i = 1; $i -le $numFiles; $i++) {
        $filePath = Join-Path -Path $directoryPath -ChildPath "File$i$fileExtension"
        New-Item -Path $filePath -ItemType File -Force
    }

    Write-Host "$numFiles files with the extension $fileExtension have been created in $directoryPath"
}
catch {
    # Catch any errors and display a meaningful message
    Write-Host "An error occurred: $_" -ForegroundColor Red
}
