$scriptPath = "C:\Windows\Temp\InstallJumpCloudAgent.ps1"
$jcScript = @"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-RestMethod -Method Get -Uri https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 -OutFile InstallWindowsAgent.ps1
.\InstallWindowsAgent.ps1 -JumpCloudConnectKey 'jcc_eyJwdWJsaWNLaWNrc3RhcnRVcmwiOiJodHRwczovL2tpY2tzdGFydC5qdW1wY2xvdWQuY29tIiwicHJpdmF0ZUtpY2tzdGFydFVybCI6Imh0dHBzOi8vcHJpdmF0ZS1raWNrc3RhcnQuanVtcGNsb3VkLmNvbSIsImNvbm5lY3RLZXkiOiJiMWU3ZjhhNGEwNjdhNTMxMmI1YzU5YTU0ZTE4ZjVlNmRmOTRkZjE3In0g'
"@
Set-Content -Path $scriptPath -Value $jcScript -Encoding UTF8

schtasks.exe /Create /TN "InstallJumpCloudAgent" /TR "powershell.exe -ExecutionPolicy Bypass -File `"$scriptPath`"" /SC ONSTART /RL HIGHEST /RU "SYSTEM"
