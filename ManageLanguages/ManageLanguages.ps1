# Define the mapping of German language names to language codes
Clear-Host
$languageMap = @{
    "Deutsch (Schweiz)" = "de-CH"
    "Deutsch (Deutschland)" = "de-DE"
    "Französisch (Schweiz)" = "fr-CH"
    "Englisch" = "en-US"
    "Spanisch" = "es-ES"
    "Italienisch" = "it-IT"
    "Russisch" = "ru-RU"
    "Chinesisch" = "zh-CN"
    "Japanisch" = "ja-JP"
    "Arabisch" = "ar-SA"
    # Add more languages as needed
}

# Function to display the current languages
function Show-CurrentLanguages {
    $currentLanguages = Get-WinUserLanguageList
    Write-Host "Currently installed languages:"
    for ($i = 0; $i -lt $currentLanguages.Count; $i++) {
        Write-Host "$($i+1): $($currentLanguages[$i].LanguageTag)"
    }
    return $currentLanguages
}

# Function to add a keyboard language
function Add-Language {
    param (
        [string]$languageName
    )

    if ($languageMap.ContainsKey($languageName)) {
        $languageCode = $languageMap[$languageName]
        $currentLanguages = Get-WinUserLanguageList

        # Create a new language list including the added language
        $newLanguage = New-WinUserLanguageList $languageCode
        $newLanguages = $currentLanguages + $newLanguage
        Set-WinUserLanguageList $newLanguages -Force

        # Ask which language to set as the default
        $currentLanguages = Show-CurrentLanguages
        $defaultChoice = Read-Host "Enter the number of the language you want to set as default"
        $defaultLanguage = $currentLanguages[$defaultChoice - 1].LanguageTag
        Set-WinUILanguageOverride -Language $defaultLanguage
        Set-WinDefaultInputMethodOverride -InputTip $defaultLanguage

        Write-Host "Language '$languageName' ($languageCode) has been added and set as default."
    } else {
        Write-Host "Language '$languageName' is not in the list."
    }
}

# Function to remove a keyboard language
function Remove-Language {
    param (
        [string]$languageName
    )

    if ($languageMap.ContainsKey($languageName)) {
        $languageCode = $languageMap[$languageName]
        $currentLanguages = Get-WinUserLanguageList
        $newLanguages = $currentLanguages | Where-Object { $_.LanguageTag -ne $languageCode }

        if ($newLanguages.Count -eq 0) {
            Write-Host "Cannot remove the only language in the list."
            return
        }

        Set-WinUserLanguageList $newLanguages -Force
        Write-Host "Language '$languageName' ($languageCode) has been removed."

        # Ask which remaining language to set as the default
        $currentLanguages = Show-CurrentLanguages
        $defaultChoice = Read-Host "Enter the number of the language you want to set as default"
        $defaultLanguage = $currentLanguages[$defaultChoice - 1].LanguageTag
        Set-WinUILanguageOverride -Language $defaultLanguage
        Set-WinDefaultInputMethodOverride -InputTip $defaultLanguage

        Write-Host "Default language set to '$defaultLanguage'."
    } else {
        Write-Host "Language '$languageName' is not in the list."
    }
}

# Main menu for the script
function Main-Menu {
    Write-Host "What would you like to do?"
    Write-Host "1: Show current languages"
    Write-Host "2: Add a language"
    Write-Host "3: Remove a language"
    Write-Host "4: Exit"
    
    $choice = Read-Host "Enter your choice (1/2/3/4)"

    switch ($choice) {
        1 {
            Show-CurrentLanguages
        }
        2 {
            $languageName = Read-Host "Enter the German name of the language to add"
            Add-Language -languageName $languageName
        }
        3 {
            $languageName = Read-Host "Enter the German name of the language to remove"
            Remove-Language -languageName $languageName
        }
        4 {
            Write-Host "Exiting script."
            return
        }
        default {
            Write-Host "Invalid choice. Please try again."
            Main-Menu
        }
    }
    Main-Menu # Loop back to the menu
}

# Start the script by showing the main menu
Main-Menu
