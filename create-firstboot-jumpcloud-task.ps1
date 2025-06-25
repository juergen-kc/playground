# Create install script for JumpCloud Agent
$jcScript = @"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-Location -Path `$env:TEMP
Invoke-RestMethod -Method Get -Uri https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 -OutFile InstallWindowsAgent.ps1
.\InstallWindowsAgent.ps1 -JumpCloudConnectKey "jcc_eyJwdWJsaWNLaWNrc3RhcnRVcmwiOiJodHRwczovL2tpY2tzdGFydC5qdW1wY2xvdWQuY29tIiwicHJpdmF0ZUtpY2tzdGFydFVybCI6Imh0dHBzOi8vcHJpdmF0ZS1raWNrc3RhcnQuanVtcGNsb3VkLmNvbSIsImNvbm5lY3RLZXkiOiJiMWU3ZjhhNGEwNjdhNTMxMmI1YzU5YTU0ZTE4ZjVlNmRmOTRkZjE3In0g"
"@

$jcScriptPath = "C:\JC\install-jumpcloud.ps1"
New-Item -Path "C:\JC" -ItemType Directory -Force | Out-Null
$jcScript | Set-Content -Path $jcScriptPath -Encoding UTF8

# Add RunOnce registry key to execute script on first boot
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce" `
  -Name "InstallJumpCloudAgent" `
  -Value "powershell -ExecutionPolicy Bypass -File `"$jcScriptPath`""
