 
#Download AzCopy
Invoke-WebRequest -Uri "https://aka.ms/downloadazcopy-v10-windows" -OutFile C:\WIndows\Temp\AzCopy.zip -UseBasicParsing
 
#Curl.exe option (Windows 10 Spring 2018 Update (or later))
# curl.exe -L -o "C:\Windows\Temp\AzCopy\AzCopy.zip" https://aka.ms/downloadazcopy-v10-windows
 
#Expand Archive
Expand-Archive C:\WIndows\Temp\AzCopy.zip -DestinationPath C:\Windows\Temp\AzCopy\ -Force
 
#Move AzCopy to the destination you want to store it
Get-ChildItem ./AzCopy/*/azcopy.exe | Move-Item -Destination "C:\Windows\Temp\AzCopy.exe"

#Remove download folder
Remove-Item -Path C:\Windows\Temp\AzCopy\ -Force -Recurse
 
#Add your AzCopy path to the Windows environment PATH (C:\Users\thmaure\AzCopy in this example), e.g., using PowerShell:
$userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("PATH", $userenv + ";C:\Windows\Temp\AzCopy\", "User")

Set-Location C:\Windows\Temp
Start-Process msedge.exe https://microsoft.com/devicelogin

.\AzCopy.exe login

 
.\AzCopy.exe copy "https://blob4autopilot.blob.core.windows.net/aad-blob" "C:\Windows\Temp\autopilot" --recursive
