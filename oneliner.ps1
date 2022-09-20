 #Download AzCopy
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile C:\WIndows\Temp\AzCopy.zip -UseBasicParsing
 
#Expand Archive
Expand-Archive C:\WIndows\Temp\AzCopy.zip -DestinationPath C:\Windows\Temp\AzCopy\ -Force
 
#Move AzCopy to the destination you want to store it
Get-ChildItem ./AzCopy/*/azcopy.exe | Move-Item -Destination "C:\Windows\Temp\AzCopy.exe"

#Remove download folder
Remove-Item -Path C:\Windows\Temp\AzCopy\ -Force -Recurse
 
Set-Location C:\Windows\Temp

#Launch Azure Auth via Device Login
Start-Process msedge.exe https://microsoft.com/devicelogin

#Trigger AzCopy and present token
.\AzCopy.exe login

#Download Paylod from Azure Blob 
.\AzCopy.exe copy "https://blob4autopilot.blob.core.windows.net/aad-blob" "C:\Windows\Temp\autopilot" --recursive
