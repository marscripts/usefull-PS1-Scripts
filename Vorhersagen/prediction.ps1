Clear-Host

function Vorhersagen{
$name = Read-Host "wie heisst du?"
$alter = Read-Host "wie alt bist du?"
$lieblingsfarbe = Read-Host "was ist dein Lieblingsfarbe?"
$traumjob = Read-Host "was ist dein Traumjob"
$Hobby = Read-Host "was ist dein lieblingshobby?"
$LieblingsProgrammiersprache = Read-Host "Was ist dein Lieblings-Programmiersprache?"
$techTrend = Read-Host "Welcher technologische Trend begeistert dich am meisten (z.B. KI, Blockchain, Cloud Computing)?"
 $IT_Berufe = @(
        "Informatiker",
        "IT-Techniker",
        "Softwareentwickler",
        "Plattformentwickler",
        "Datenanalyst",
        "Systemadministrator",
        "Netzwerkadministrator",
        "Sicherheitsanalyst",
        "IT-Projektmanager",
        "DevOps-Ingenieur",
        "Machine Learning Engineer",
        "Cloud Architekt",
        "Webentwickler",
        "UX/UI-Designer",
        "Informatikerin"
        
    )
     if ($IT_Berufe -contains $traumjob){
        # Create a humorous prediction message based on the user's input
        $vorhersagen = @"
Hallo, $name!

Du bist $alter Jahre alt und träumst davon, als $traumjob in der IT-Branche durchzustarten. Hier ist, was dich erwartet:

1. **Dein Code wird so präzise sein, dass du bald die Titel „Code-Zauberer“ und „Debugging-Guru“ tragen wirst.** In deiner Zukunft wird es keinen Bug geben, der nicht durch deinen magischen Zauberstab (auch bekannt als die Tastatur) verbannt werden kann.

2. **Deine Lieblingsfarbe $lieblingsfarbe wird zur Farbe deiner Programmierumgebung.** Dein Bildschirm wird in $favoriteColor erstrahlen und dir ständig ein Lächeln ins Gesicht zaubern – ein wahrer Farbrausch im IT-Alltag!

3. **Mit deiner Lieblings-Programmiersprache $Lieblingsprogrammiersprache wirst du die Welt der Softwareentwicklung revolutionieren.** Die Menschen werden nicht nur deinen Code bewundern, sondern auch anfangen, deine Sprache zu sprechen – in jeder Konferenz, in jedem Forum.

4. **Der technologische Trend, der dich begeistert – $techTrend – wird dein neuer Spielplatz sein.** Du wirst in der Lage sein, innovative Projekte zu entwickeln, die entweder das nächste große Ding in der Tech-Welt sein werden oder dir den Titel „Trendsetter“ einbringen.

5. **Egal, ob du als $traumjob arbeitest, du wirst immer ein Leben voller interessanter Herausforderungen haben.** Wenn du beispielsweise als **Datenanalyst** arbeitest, wirst du in der Lage sein, versteckte Muster zu finden, die andere übersehen. Wenn du als **Cloud Architekt** tätig bist, wirst du die Welt der virtuellen Maschinen beherrschen und immer einen Schritt voraus sein.

6. **Erwarte, dass du in der IT-Welt als die Person bekannt wirst, die immer die coolsten Tricks und Tipps auf Lager hat.** Dein zukünftiger Arbeitsplatz wird ein Ort sein, an dem du nicht nur den Code meisterst, sondern auch die Herzen deiner Kollegen mit deinem charmanten Humor gewinnst.

7. **Natürlich wirst du in deinem Alltag von epischen Fehlermeldungen und chaotischen Code-Schnipseln begleitet werden, die du mit Bravour bewältigen wirst.** Du wirst die beruhigende Stimme der „It’s not a bug, it’s a feature“-Philosophie finden, die dich durch die härtesten Zeiten begleitet.

Mach dich bereit, dein zukünftiges Abenteuer als IT-Profi zu starten – es wird eine Reise voller Lacher, Herausforderungen und unzähliger Tassen Kaffee sein!

Viel Glück und möge der Code immer mit dir sein!
"@
    } else {
        # If the dream job is not in the list of IT professions, provide a general message
        $vorhersagen = "Es scheint, dass du nicht speziell an einer IT-Ausbildung interessiert bist. Keine Sorge, auch ohne IT wirst du sicherlich eine grossartige Zukunft haben. Viel Erfolg bei deinen anderen Zielen!"
    }

    # Display the prediction message to the user
    Write-Output $vorhersagen
}

# Call the function to execute the script
Vorhersagen
    