#!/bin/bash

# IRC Service
service="ircd"

if systemctl is-active --quiet $service; then
    echo "$service is running"
else
    echo "$service is not running, attempting to restart..."
    systemctl restart $service
    if systemctl is-active --quiet $service; then
        echo "$service successfully restarted"
    else
        echo "Failed to restart $service"
    fi
fi
