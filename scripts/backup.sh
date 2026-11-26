#!/bin/bash

BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
KEEP=5

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_FILE" \
    --exclude="apps/hello-service/venv" \
    -C "$HOME" apps/hello-service \
    /etc/nginx/sites-available/hello-service 2>> "$BACKUP_DIR/backup_errors.log"

if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] Backup created: $BACKUP_FILE ($(du -h "$BACKUP_FILE" | cut -f1))"
else
    echo "[$TIMESTAMP] Backup FAILED — check $BACKUP_DIR/backup_errors.log"
    exit 1
fi

BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | wc -l)
if [ "$BACKUP_COUNT" -gt "$KEEP" ]; then
    ls -1t "$BACKUP_DIR"/backup_*.tar.gz | tail -n +$((KEEP + 1)) | xargs rm -f
    echo "[$TIMESTAMP] Old backups pruned, keeping most recent $KEEP"
fi


