# Variables
$ScriptPath = "C:\JC"
$ScriptFile = "install-jumpcloud.ps1"
$JumpCloudConnectKey = "jcc_eyJwdWJsaWNLaWNrc3RhcnRVcmwiOiJodHRwczovL2tpY2tzdGFydC5qdW1wY2xvdWQuY29tIiwicHJpdmF0ZUtpY2tzdGFydFVybCI6Imh0dHBzOi8vcHJpdmF0ZS1raWNrc3RhcnQuanVtcGNsb3VkLmNvbSIsImNvbm5lY3RLZXkiOiJiMWU3ZjhhNGEwNjdhNTMxMmI1YzU5YTU0ZTE4ZjVlNmRmOTRkZjE3In0g"

# Ensure path exists
New-Item -Path $ScriptPath -ItemType Directory -Force

# Write install script to file
@"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-Location -Path \$env:TEMP
Invoke-RestMethod -Method Get -Uri https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 -OutFile InstallWindowsAgent.ps1
.\InstallWindowsAgent.ps1 -JumpCloudConnectKey "$JumpCloudConnectKey"
"@ | Set-Content -Path "$ScriptPath\$ScriptFile" -Encoding UTF8

# Register a scheduled task to run on first boot
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File `"$ScriptPath\$ScriptFile`""
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -Hidden
Register-ScheduledTask -TaskName "InstallJumpCloudAgentFirstBoot" -Action $Action -Trigger $Trigger -Settings $Settings -RunLevel Highest -User "SYSTEM"

Write-Output "✅ First-boot JumpCloud agent installer scheduled."
