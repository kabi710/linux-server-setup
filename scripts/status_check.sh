#!/bin/bash

LOGFILE="$HOME/logs/status.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
MEM_USAGE=$(free -m | awk 'NR==2 {printf "%.1f%%", $3*100/$2}')
SERVICE_STATUS=$(systemctl is-active hello-service)

echo "[$TIMESTAMP] Disk: $DISK_USAGE | Memory: $MEM_USAGE | hello-service: $SERVICE_STATUS" >> "$LOGFILE"

