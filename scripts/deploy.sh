#!/bin/bash

APP_DIR="$HOME/apps/hello-service"
SERVICE="hello-service"
LOGFILE="$HOME/logs/deploy.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "[$TIMESTAMP] Starting deployment..." | tee -a "$LOGFILE"

cd "$APP_DIR" || {
    echo "[$TIMESTAMP] FAILED: app directory not found" | tee -a "$LOGFILE"
    exit 1
}

echo "[$TIMESTAMP] Pulling latest code..." | tee -a "$LOGFILE"

git pull --ff-only origin main >> "$LOGFILE" 2>&1

if [ $? -ne 0 ]; then
    echo "[$TIMESTAMP] FAILED: git pull failed" | tee -a "$LOGFILE"
    exit 1
fi

echo "[$TIMESTAMP] Installing/updating dependencies..." | tee -a "$LOGFILE"

source venv/bin/activate

if ! pip install -r requirements.txt >> "$LOGFILE" 2>&1; then
    echo "[$TIMESTAMP] FAILED: dependency installation failed" | tee -a "$LOGFILE"
    deactivate
    exit 1
fi

deactivate

echo "[$TIMESTAMP] Restarting service..." | tee -a "$LOGFILE"

if ! sudo systemctl restart "$SERVICE"; then
    echo "[$TIMESTAMP] FAILED: service restart failed" | tee -a "$LOGFILE"
    exit 1
fi

sleep 3

echo "[$TIMESTAMP] Running health check..." | tee -a "$LOGFILE"

HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:5000)

if [ "$HTTP_CODE" = "200" ]; then
    echo "[$TIMESTAMP] Deployment SUCCESSFUL - service healthy (HTTP $HTTP_CODE)" | tee -a "$LOGFILE"
else
    echo "[$TIMESTAMP] Deployment WARNING - health check returned HTTP $HTTP_CODE" | tee -a "$LOGFILE"
    exit 1
fi
