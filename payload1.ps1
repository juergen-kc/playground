#Download AzCopy
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile C:\WIndows\Temp\AzCopy.zip -UseBasicParsing
 
#Expand Archive
Expand-Archive C:\WIndows\Temp\AzCopy.zip -DestinationPath C:\Windows\Temp\AzCopy\ -Force
 
#Move AzCopy to the destination you want to store it
Get-ChildItem ./AzCopy/*/azcopy.exe | Move-Item -Destination "C:\Windows\Temp\AzCopy.exe"

#Remove download folder
Remove-Item -Path C:\Windows\Temp\AzCopy\ -Force -Recurse
 
#Wait for a moment
Sleep 15
