#!/bin/bash

# Define backup directory
BACKUP_DIR="/var/backups"
DATE=$(date +"%Y%m%d_%H%M%S")

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# List of DNS files to back up
DNS_FILES=(
    "/etc/named.conf"
    "/var/named/*.zone"
)

# List of SSH files to back up
SSH_FILES=(
    "/etc/ssh/sshd_config"
    "/etc/ssh/ssh_config"
    "/etc/ssh/ssh_host_*_key"
    "/etc/ssh/ssh_host_*_key.pub"
)

# Function to back up files
backup_files() {
    local files=("$@")
    for file in "${files[@]}"; do
        if [ -e "$file" ]; then
            cp "$file" "$BACKUP_DIR/$(basename "$file")_$DATE.bak"
            echo "Backed up: $file to $BACKUP_DIR/$(basename "$file")_$DATE.bak"
        else
            echo "File does not exist: $file"
        fi
    done
}

# Back up DNS files
backup_files "${DNS_FILES[@]}"

# Back up SSH files
backup_files "${SSH_FILES[@]}"

echo "Backup completed."
