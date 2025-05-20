#!/bin/bash

BACKUP_DIR="/opt/mysql_backup"
DATE=$(date +%Y%m%d_%H%M%S)

mysqldump --defaults-file=/root/.my.cnf --all-databases > "$BACKUP_DIR/full_backup_$DATE.sql" || {
    echo "MySQL dump failed!"
    exit 1
}


find "$BACKUP_DIR" -name "*.sql" -type f -mtime +1 -delete

sudo -u server9 rsync -avz --delete -e "ssh -i /home/server9/.ssh/id_ed25519" \
    "$BACKUP_DIR/" store9@192.168.122.36:/opt/store/mysql || {
    echo "Rsync failed!"
    exit 1
}
