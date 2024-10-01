#!/bin/bash

# Define the list of users to exclude
exclude_users=("casino_user" "casino_admin" "root" "rocky" "debian")

# Iterate through all users
for user in $(getent passwd | cut -d: -f1); do
  # Check if the user is not in the exclusion list
  if [[ ! ${exclude_users[@]} =~ ${user} ]]; then
    # Change the shell to /usr/sbin/nologin
    chsh -s /usr/sbin/nologin $user
    if [ $? -eq 0 ]; then
      echo "Changed shell for user $user to /usr/sbin/nologin"
    else
      echo "Failed to change shell for user $user"
    fi
  fi
done