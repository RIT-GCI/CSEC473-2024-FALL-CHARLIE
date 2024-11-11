Import-Module ActiveDirectory

# Define user details
$users = @(
    @{Username="robber"; Password="heistTime123"},
    @{Username="teller2"; Password="Client5678"}
)

# Loop through each user and create them
foreach ($user in $users) {
    $username = $user.Username
    $password = ConvertTo-SecureString -AsPlainText $user.Password -Force
    $userPrincipalName = "$username@sentinelbank2.com"  # Domain name to match the AD domain
    
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
                   -Path "CN=Users,DC=sentinelbank2,DC=com" # Adjust the OU path as needed
                   
        Write-Host "User $username created successfully."

        # Set the user account to allow login to domain computers
        Set-ADUser -Identity $username -LogonWorkstations "*"  # Allows logon to any domain-joined computer
        
        # Optionally, assign user to a specific group (like 'Domain Users' or any custom group)
        Add-ADGroupMember -Identity "Domain Users" -Members $username
        
    }
}

# Confirm completion
