Set-Location C:\Windows\Temp

#Launch Azure Auth via Device Login
Start-Process msedge.exe https://microsoft.com/devicelogin
Write-Host "Launching Microsoft's DeviceLogin page" -BackgroundColor Black -ForegroundColor Cyan

#Trigger AzCopy and present token
.\AzCopy.exe login
Write-Host "Trigger AzCopy to login" -BackgroundColor Black -ForegroundColor Cyan

#Download Paylod from Azure Blob 
.\AzCopy.exe copy "https://blob4autopilot.blob.core.windows.net/aad-blob" "C:\Windows\Temp\autopilot" --recursive
Write-Host "Copying required files to this device" -BackgroundColor Black -ForegroundColor Cyan

#Launch AutoPilot-Script 
powershell.exe C:\Windows\Temp\autopilot\aad-blob\220928-JCAutoPilotKeypass-working.ps1
Write-Host "Launching the AutoPilot-Script" -BackgroundColor Black -ForegroundColor Cyan

#Close session of AzCopy
.\AzCopy.exe logout
