#!/bin/bash

# Define the list of users to exclude
exclude_users=("casino_user" "casino_admin" "root" "rocky" "debian" "nobody" "daemon" "bin" "sys" "adm" "lp" "mail" "operator" "games" "ftp" "sshd" "dbus" "rpc" "rpcuser" "systemd-journal" "systemd-timesync")

# Iterate through all users
while IFS=: read -r user _ uid _; do
  # Initialize a flag to check if user is excluded
  excluded=false
  
  # Skip system users (UID < 1000)
  if [ "$uid" -lt 1000 ]; then
    continue
  fi
  
  # Check if the user is in the exclusion list
  for exclude in "${exclude_users[@]}"; do
    if [[ "$user" == "$exclude" ]]; then
      excluded=true
      break
    fi
  done
  
  # If the user is not excluded, change their shell
  if [ "$excluded" = false ]; then
    # Use usermod to change the shell
    sudo usermod -s /usr/sbin/nologin "$user"
    if [ $? -eq 0 ]; then
      echo "Changed shell for user $user to /usr/sbin/nologin"
    else
      echo "Failed to change shell for user $user"
    fi
  fi
done < <(getent passwd)
