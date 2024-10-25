#!/bin/bash

# Ask for IP address and interface for iptables rule
read -p "Enter the IP address you want blue to see: " ip_address
read -p "Enter the network interface to use (public interface): " network_interface

# Check if /etc/sysctl.conf exists
if [ ! -f /etc/sysctl.conf ]; then
    echo "/etc/sysctl.conf does not exist, creating it"
    sudo touch /etc/sysctl.conf
fi

# Add rule to /etc/sysctl.conf
echo "Updating /etc/sysctl.conf to enable IP forwarding"
sudo sed -i '/^net.ipv4.ip_forward/d' /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf

# Reload sysctl
echo "Reloading sysctl settings"
sudo sysctl -p

# Flush other rules
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F

# Add iptables rule
echo "Adding iptables rule for NAT..."
sudo iptables -t nat -A POSTROUTING -o $network_interface -j SNAT --to-source $ip_address

echo "Configuration completed successfully."
