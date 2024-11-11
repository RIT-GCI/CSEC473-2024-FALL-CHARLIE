# Script: complete_promotion.ps1

# Define the credentials
$User = "Administrator"
$PWord = ConvertTo-SecureString -String "testpassword123!" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

# Promote to domain controller with options
Import-Module ADDSDeployment
Install-ADDSForest -DomainName "sentinelbank.com" `
    -InstallDns `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -LogPath "C:\Windows\NTDS" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true `
    -SafeModeAdministratorPassword (ConvertTo-SecureString -String "testpassword123!" -AsPlainText -Force) `
    -Verbose
