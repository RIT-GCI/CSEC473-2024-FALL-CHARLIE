#!/bin/bash

# Detect the operating system
OS="$(uname -s)"

# Function to harden firewall on Windows Server 2019
harden_windows_firewall() {
    echo "Applying Windows Server 2019 firewall rules..."

    # Allow traffic on specified networks
    netsh advfirewall firewall add rule name="Allow Network 10.21.13.0/24" dir=in action=allow remoteip=10.21.13.0/24
    netsh advfirewall firewall add rule name="Allow Network 10.21.1.0/24" dir=in action=allow remoteip=10.21.1.0/24
    netsh advfirewall firewall add rule name="Allow Network 10.21.2.0/24" dir=in action=allow remoteip=10.21.2.0/24
    netsh advfirewall firewall add rule name="Allow Network 10.21.17.0/24" dir=in action=allow remoteip=10.21.17.0/24

    # Deny all other traffic
    netsh advfirewall firewall add rule name="Deny all other traffic" dir=in action=block

    # Allow DNS, SSH, WordPress/MySQL, IRC/GitLab, and Mail/Samba traffic
    netsh advfirewall firewall add rule name="Allow DNS" protocol=UDP dir=in action=allow localport=53
    netsh advfirewall firewall add rule name="Allow SSH" protocol=TCP dir=in action=allow localport=22
    netsh advfirewall firewall add rule name="Allow WordPress/MySQL" protocol=TCP dir=in action=allow localport=80,443,3306
    netsh advfirewall firewall add rule name="Allow IRC/GitLab" protocol=TCP dir=in action=allow localport=6667,80,443,22
    netsh advfirewall firewall add rule name="Allow Mail/Samba" protocol=TCP dir=in action=allow localport=25,465,587,110,445
	netsh advfirewall firewall add rule name="Block ICMP" protocol=icmpv4 dir=in action=block

	
    # Enable basic firewall hardening
    netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound
    netsh advfirewall set allprofiles state on

    echo "Windows Server 2019 firewall hardening complete."
}

# Function to harden firewall on Linux
harden_linux_firewall() {
    echo "Applying Linux firewall rules using firewalld..."

    # Check if firewalld is installed
    if ! command -v firewall-cmd &> /dev/null
    then
        echo "firewalld is not installed. Please install it first."
        exit 1
    fi

    # Start and enable firewalld
    systemctl start firewalld
    systemctl enable firewalld

    # Check if firewall is active
    if ! firewall-cmd --state &> /dev/null
    then
        echo "firewalld is not running. Please check the firewall service."
        exit 1
    fi

    # Allow traffic on specified networks
    firewall-cmd --permanent --zone=public --add-source=10.21.13.0/24
    firewall-cmd --permanent --zone=public --add-source=10.21.1.0/24
    firewall-cmd --permanent --zone=public --add-source=10.21.2.0/24
    firewall-cmd --permanent --zone=public --add-source=10.21.17.0/24

    # Deny all other traffic
    firewall-cmd --permanent --zone=drop --add-service=all

    # Allow DNS, SSH, WordPress/MySQL, IRC/GitLab, and Mail/Samba traffic
    firewall-cmd --permanent --add-service=dns
    firewall-cmd --permanent --add-service=ssh
    firewall-cmd --permanent --add-service=http
    firewall-cmd --permanent --add-service=https
    firewall-cmd --permanent --add-service=mysql
    firewall-cmd --permanent --add-service=git
    firewall-cmd --permanent --add-port=6667/tcp
    firewall-cmd --permanent --add-service=smtp
    firewall-cmd --permanent --add-service=smb
	firewall-cmd --permanent --add-icmp-block=echo-request


    # Reload firewall to apply changes
    firewall-cmd --reload

    echo "Linux firewall hardening complete."
}

# Function for Rocky Linux-specific actions
handle_rocky_linux() {
    if grep -q "Rocky" /etc/os-release; then
        echo "This is Rocky Linux (x86_64)."

        # Download the script from Pastebin
        # curl -o pastebin.sh https://pastebin.com/raw/wM0ncMEj
        
        # Make the script executable
        chmod +x pastebin.sh
        
        # Fix line endings
        sed -i 's/\r//' pastebin.sh

        echo "Script downloaded and prepared."
    fi
}

# Apply firewall rules based on the OS
case "$OS" in
    *Linux*)
        # If it's Rocky Linux, handle it
        handle_rocky_linux
        harden_linux_firewall
        ;;
    *CYGWIN*|*MINGW*|*MSYS*|*Windows_NT*)
        harden_windows_firewall
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac
