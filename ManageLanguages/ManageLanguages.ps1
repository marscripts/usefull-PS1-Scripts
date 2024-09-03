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
        $defaultChoice = Read-Host "Geben Sie die Nummer der Sprache ein, die Sie als Standard festlegen möchten"
        $defaultLanguage = $currentLanguages[$defaultChoice - 1].LanguageTag
        Set-WinUILanguageOverride -Language $defaultLanguage
        Set-WinDefaultInputMethodOverride -InputTip $defaultLanguage

        Write-Host "Language '$languageName' ($languageCode) wurde hinzugefügt und als Standard festgelegt."
    } else {
        Write-Host "Language '$languageName' ist nicht auf die liste."
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
            Write-Host "Die einzige Sprache in der Liste kann nicht entfernt werden."
            return
        }

        Set-WinUserLanguageList $newLanguages -Force
        Write-Host "Language '$languageName' ($languageCode) wurde entfernt"

        # Ask which remaining language to set as the default
        $currentLanguages = Show-CurrentLanguages
        $defaultChoice = Read-Host "Geben Sie die Nummer der Sprache ein, die Sie als Standard festlegen möchten"
        $defaultLanguage = $currentLanguages[$defaultChoice - 1].LanguageTag
        Set-WinUILanguageOverride -Language $defaultLanguage
        Set-WinDefaultInputMethodOverride -InputTip $defaultLanguage

        Write-Host "Default language set to '$defaultLanguage'."
    } else {
        Write-Host "Language '$languageName' ist nicht auf die liste."
    }
}

# Main menu for the script
function Main-Menu {
    Write-Host "Was Möchten Sie gerne machen?"
    Write-Host "1: Aktuelle Sprachen anzeigen"
    Write-Host "2: Fügen Sie eine Sprache hinzu"
    Write-Host "3: Die Sprache entfehrnen"
    Write-Host "4: Ausgang"
    
    $choice = Read-Host "Geben Sie Ihre Wahl eine (1/2/3/4)"

    switch ($choice) {
        1 {
            Show-CurrentLanguages
        }
        2 {
            $languageName = Read-Host "Geben Sie den deutschen Namen der hinzuzufügenden Sprache ein"
            Add-Language -languageName $languageName
        }
        3 {
            $languageName = Read-Host "Geben Sie den deutschen Namen der zu entfernenden Sprache ein"
            Remove-Language -languageName $languageName
        }
        4 {
            Write-Host "Skript wird beendet."
            return
        }
        default {
            Write-Host "Ungültige Auswahl. Bitte versuchen Sie es erneut."
            Main-Menu
        }
    }
    Main-Menu # Loop back to the menu
}

# Start the script by showing the main menu
Main-Menu
