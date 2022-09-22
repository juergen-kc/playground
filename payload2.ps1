Set-Location C:\Windows\Temp

#Launch Azure Auth via Device Login
Start-Process msedge.exe https://microsoft.com/devicelogin

#Trigger AzCopy and present token
.\AzCopy.exe login

#Download Paylod from Azure Blob 
.\AzCopy.exe copy "https://blob4autopilot.blob.core.windows.net/aad-blob" "C:\Windows\Temp\autopilot" --recursive

#Launch AutoPilot-Script 
Start-Process "powershell.exe" -File C:\Windows\Temp\autopilot\aad-blob\JCAutoPilotKeypass.ps1
