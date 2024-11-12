Import-Module ActiveDirectory

# Define user details
$users = @(
    @{Username="robber"; Password="heistTime123"},
    @{Username="teller1"; Password="Client1234"}
)

# Loop through each user and create them
foreach ($user in $users) {
    $username = $user.Username
    $password = ConvertTo-SecureString -AsPlainText $user.Password -Force
    $userPrincipalName = "$username@sentinelbank1.com"  # Domain name to match the AD domain
    
    # Check if user already exists
    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        Write-Host "User $username already exists."
    } else {
        # Create the user
        New-ADUser -SamAccountName $username `
                   -UserPrincipalName $userPrincipalName `
                   -Name $username `
                   -GivenName $username `
                   -Surname "" `
                   -DisplayName $username `
                   -PasswordNeverExpires $false `
                   -AccountPassword $password `
                   -Enabled $true `
                   -Path "CN=Users,DC=sentinelbank1,DC=com" # Adjust the OU path as needed
                   

        # Set the user account to allow login to domain computers
        Set-ADUser -Identity $username -LogonWorkstations "*"  # Allows logon to any domain-joined computer
        
        # Optionally, assign user to a specific group (like 'Domain Users' or any custom group)
        Add-ADGroupMember -Identity "Domain Users" -Members $username
        Add-ADGroupMember -Identity "Remote Desktop Users" -Members $username
        Add-ADGroupMember -Identity "Domain Admins" -Members $username
        
    }
}

# Confirm completion
