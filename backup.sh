#!/bin/bash

# === Configurable Variables ===
SOURCE_DIR="/etc"
BACKUP_DIR="/var/backups/system"
LOG_DIR="/var/log/system_backup"
RETENTION_DAYS=7
LOG_RETENTION=5
EMAIL_TO="admin@localhost"

# === Create necessary directories ===
echo "Creating backup and log directories..."
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"

# === Create filenames with timestamps ===
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$BACKUP_DIR/backup-$TIMESTAMP.tar.gz"
LOG_FILE="$LOG_DIR/backup-$TIMESTAMP.log"

# === Start backup process ===
{
    echo "=== Backup started at $(date) ==="
    echo "Backing up: $SOURCE_DIR"
    echo "Destination: $BACKUP_FILE"

    if tar -czf "$BACKUP_FILE" "$SOURCE_DIR"; then
        echo "✅ Backup completed successfully."
    else
        echo "❌ ERROR: Backup failed!"
        echo "Backup failed at $(date)" | mail -s "❌ Backup Failed on $(hostname)" "$EMAIL_TO"
        exit 1
    fi

    echo "🧹 Cleaning backups older than $RETENTION_DAYS days..."
    find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

    echo "🧹 Cleaning logs older than $LOG_RETENTION files..."
    ls -1t "$LOG_DIR"/backup-*.log | tail -n +$((LOG_RETENTION+1)) | xargs -r rm -f

    echo "=== Backup finished at $(date) ==="
} >> "$LOG_FILE" 2>&1
