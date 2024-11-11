# Script: initial_setup.ps1

# Define the credentials
$User = "Administrator"
$PWord = ConvertTo-SecureString -String "bankpassword2024!" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

# Install required roles and features
Install-WindowsFeature -Name AD-Domain-Services, DNS, Remote-Desktop-Services -IncludeManagementTools -IncludeAllSubFeature
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Configure DNS
New-DnsServerPrimaryZone -Name "sentinelbank.com" -ZoneFile "sentinelbank.com.dns" -DynamicUpdate None

Restart-Computer 
