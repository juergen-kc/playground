# Download PPKG to Windows\Temp
Invoke-WebRequest -Uri https://github.com/juergen-kc/playground/blob/9cf1df8a5b97e8e3c801a557d0ed7b517a5dd3c0/MDM-APDU.ppkg -OutFile C:\Windows\Temp\MDM-APDU.ppkg

# Install PPKG
provtool.exe C:\Windows\Temp\MDM-APDU.ppkg /quiet