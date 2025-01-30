### ** Automated System Cleanup Script**  

---

## **🛠️ About This Script**  
This PowerShell script **automatically cleans temporary files, clears caches, empties the recycle bin, and optimizes system performance**.  
It runs **silently in the background as a scheduled task with admin privileges** at system startup.

---

## **📌 Features**
✅ **Deletes temporary files** (Windows Temp, User Temp, and Local Temp)  
✅ **Clears Prefetch and Windows Update Cache** (Improves system performance)  
✅ **Empties Recycle Bin** (Frees up disk space)  
✅ **Clears Windows Event Logs** (Reduces clutter)  
✅ **Runs Disk Cleanup silently**  
✅ **Restarts Explorer** (Ensures system refresh)  
✅ **Automatically runs at system startup** via a scheduled task  
✅ **Creates a log file** (`CleanupLog.txt`) to track cleanup actions  

---

## **📂 File Structure**
```
📁 C:\Scripts
    ├── 📝 CleanupTask.ps1    # The main PowerShell script
    ├── 📄 README.md          # This documentation file
```

---

## **🔧 Installation & Setup**
### **1️⃣ Save the Script**  
1. **Download or copy** the `CleanupTask.ps1` file.
2. **Place it in**:  
   ```
   C:\Scripts\CleanupTask.ps1
   ```
   *(You can choose another directory, but update the paths accordingly in the scheduled task command.)*

### **2️⃣ Create a Scheduled Task (Run as Admin)**
1. **Open PowerShell as Administrator**  
   - Press `Win + X` → Select **PowerShell (Admin)**
2. **Run the following command:**
   ```powershell
   $TaskName = "AutoSystemCleanup"
   $TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File C:\Scripts\CleanupTask.ps1"
   $TaskTrigger = New-ScheduledTaskTrigger -AtStartup
   $TaskPrincipal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
   $TaskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

   # Check if task exists, update or create it
   $TaskExists = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
   if ($TaskExists) {
       Set-ScheduledTask -TaskName $TaskName -Action $TaskAction -Trigger $TaskTrigger -Principal $TaskPrincipal -Settings $TaskSettings
       Write-Host "Scheduled task '$TaskName' updated successfully!"
   } else {
       Register-ScheduledTask -TaskName $TaskName -Action $TaskAction -Trigger $TaskTrigger -Principal $TaskPrincipal -Settings $TaskSettings -Description "Automatically cleans temp files and optimizes system at startup"
       Write-Host "Scheduled task '$TaskName' created successfully!"
   }
   ```

### **3️⃣ Verify the Scheduled Task**
- Open **Task Scheduler** (`taskschd.msc` from Run or Start Menu).  
- Look for **"AutoSystemCleanup"** under **Task Scheduler Library**.  
- Right-click → **Run** to test it.

---

## **📜 How to View Cleanup Logs**
All cleanup actions are logged in:

```
C:\Users\YourUsername\AppData\Local\Temp\CleanupLog.txt
C:\Windows\Temp
```
To open the log file directly:
```powershell
notepad "$env:TEMP\CleanupLog.txt"
```

---

## **🛑 How to Remove the Task**
If you want to stop the script from running at startup:
1. Open **PowerShell as Admin**.
2. Run the following command:
   ```powershell
   Unregister-ScheduledTask -TaskName "AutoSystemCleanup" -Confirm:$false
   ```
3. (Optional) **Delete the script file**:
   ```powershell
   Remove-Item "C:\Scripts\CleanupTask.ps1" -Force
   ```

---

## **🔄 Customization**
### **Run the Script Every X Hours Instead of Startup**
Modify this line in the scheduled task creation script:
```powershell
$TaskTrigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date.AddHours(1) -RepetitionInterval (New-TimeSpan -Hours 6)
```
🔹 This will run the script **every 6 hours** instead of at startup.

---

## **❓ Troubleshooting**
**Problem:** *The script does not run at startup.*  
✅ **Solution:**  
- Ensure the scheduled task is correctly created under **Task Scheduler**.
- Run this command in PowerShell to manually start the task:
  ```powershell
  Start-ScheduledTask -TaskName "AutoSystemCleanup"
  ```
- Make sure you have **admin privileges** when setting up the task.

---

## **📌 Summary**
- **This script cleans up unnecessary files, optimizes performance, and runs automatically at startup.**  
- **It logs cleanup actions to a file (`CleanupLog.txt`).**  
- **Runs with full administrator privileges via Task Scheduler.**  
- **You can modify or remove it easily using PowerShell commands.**  

🚀 **Enjoy a cleaner and optimized system!** 🚀

---

### **📢 Contributions & Feedback**
Feel free to modify the script to suit your needs! If you have improvements or issues, share them! 😊
