# Set the execution policy to Unrestricted
Set-ExecutionPolicy Unrestricted -Scope Process -Force

# Define variables
$zipUrl = "https://github.com/davidprowe/BadBlood/archive/refs/heads/master.zip"
$zipFile = "CTF.zip"
$destinationPath = "C:\Users\workinman9\Downloads"

# Download the ZIP file
Invoke-WebRequest -Uri $zipUrl -OutFile "$destinationPath\$zipFile"

# Expand the ZIP file
Expand-Archive -Path "$destinationPath\$zipFile" -DestinationPath $destinationPath -Force

# Change to the extracted directory
cd "$destinationPath\BadBlood-master"

# Execute the PowerShell script
.\Invoke-BadBlood.ps1
