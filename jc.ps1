[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Move to temp directory
Set-Location -Path $env:TEMP

# Download the JumpCloud install script
Invoke-RestMethod -Method Get `
  -Uri "https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1" `
  -OutFile "InstallWindowsAgent.ps1"

# OPTIONAL: Comment out any potential reboots if they exist (future-proof)
(Get-Content .\InstallWindowsAgent.ps1) -replace 'Restart-Computer', '# Restart-Computer' | Set-Content .\InstallWindowsAgent.ps1

# Run the JumpCloud installer
Write-Output ">>> Starting JumpCloud agent installation"
.\InstallWindowsAgent.ps1 -JumpCloudConnectKey "jcc_eyJwdWJsaWNLaWNrc3RhcnRVcmwiOiJodHRwczovL2tpY2tzdGFydC5qdW1wY2xvdWQuY29tIiwicHJpdmF0ZUtpY2tzdGFydFVybCI6Imh0dHBzOi8vcHJpdmF0ZS1raWNrc3RhcnQuanVtcGNsb3VkLmNvbSIsImNvbm5lY3RLZXkiOiJiMWU3ZjhhNGEwNjdhNTMxMmI1YzU5YTU0ZTE4ZjVlNmRmOTRkZjE3In0g"

# Post-install cooldown and DNS check
Write-Output "✅ JumpCloud agent installed. Waiting for network stabilization..."
Start-Sleep -Seconds 30

try {
    Resolve-DnsName raw.githubusercontent.com -ErrorAction Stop
    Write-Output "✅ DNS resolution successful."
} catch {
    Write-Output "⚠️ DNS resolution failed: $($_.Exception.Message)"
}
