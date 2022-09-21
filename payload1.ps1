Set-Location C:\Windows\Temp

Start-Transcript -OutputDirectory c:\Windows\Temp -Verbose -ErrorAction Continue

#Download AzCopy
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile C:\Windows\Temp\AzCopy.zip -UseBasicParsing
 
#Expand Archive
Expand-Archive C:\Windows\Temp\AzCopy.zip -DestinationPath C:\Windows\Temp\AzCopy\ -Force
 
#Move AzCopy to the destination you want to store it
Get-ChildItem ./AzCopy/*/azcopy.exe | Move-Item -Destination "C:\Windows\Temp\AzCopy.exe"

#Wait for a moment
Sleep 10

#Remove download folder
Remove-Item -Path C:\Windows\Temp\AzCopy\ -Force -Recurse
 
#Wait for a moment
Sleep 15
