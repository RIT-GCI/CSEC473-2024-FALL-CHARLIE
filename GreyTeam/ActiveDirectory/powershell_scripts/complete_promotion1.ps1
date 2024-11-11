# Script: complete_promotion.ps1

# Define the credentials
$User = "Administrator"
$PWord = ConvertTo-SecureString -String "bankpassword2024!" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

# Promote to domain controller with options
Import-Module ADDSDeployment
Install-ADDSForest -DomainName "sentinelbank1.com" `
    -InstallDns `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -LogPath "C:\Windows\NTDS" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true `
<<<<<<< HEAD:GreyTeam/ActiveDirectory/powershell_scripts/complete_promotion1.ps1
    -SafeModeAdministratorPassword (ConvertTo-SecureString -String "bankpassword2024!!" -AsPlainText -Force) `
=======
    -SafeModeAdministratorPassword (ConvertTo-SecureString -String "bankpassword2024!" -AsPlainText -Force) `
>>>>>>> 47ad3bb6ea203041cc5e76931d7db76c19e5d3ac:GreyTeam/ActiveDirectory/powershell_scripts/complete_promotion.ps1
    -Verbose
