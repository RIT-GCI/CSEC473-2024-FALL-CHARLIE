Import-Module ActiveDirectory

# Define user details
$users = @(
    @{Username="robber"; Password="heistTime123"},
    @{Username="teller1"; Password="Client1234"},
    @{Username="teller2"; Password="Client5678"}
)

# Loop through each user and create them
foreach ($user in $users) {
    $username = $user.Username
    $password = ConvertTo-SecureString -AsPlainText $user.Password -Force
    $userPrincipalName = "$username@sentinelbank.com" # Adjust the domain name as needed

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
                   -PasswordNeverExpires $true `
                   -AccountPassword $password `
                   -Enabled $true `
                   -Path "CN=Users,DC=sentinelbank,DC=com" # Adjust the OU path as needed
        Write-Host "User $username created successfully."
    }
}
