# Specify the directory where you want to create the files
$directoryPath = "C:\Users\mra\Documents\testingfolder"

# Create the directory if it doesn't exist
if (-not (Test-Path -Path $directoryPath)) {
    New-Item -Path $directoryPath -ItemType Directory
}

# Loop to create 15 text files
for ($i = 1; $i -le 15; $i++) {
    $filePath = Join-Path -Path $directoryPath -ChildPath "File$i.ps1"
    New-Item -Path $filePath -ItemType File -Force
}

Write-Host "15 text files have been created in $directoryPath"
