#!/usr/bin/bash
set -e

SRC_PATH=/home/ubuntu/world
BACKUP_PATH_FULL=/home/ubuntu/backup/full
BACKUP_PATH_INC=/home/ubuntu/backup/incremental
rsync -a --delete \
    ${SRC_PATH} \
    ${BACKUP_PATH_FULL} \
    --backup \
    --backup-dir=${BACKUP_PATH_INC}/`date +%Y-%m-%dT%H-%M-%S`

# remove backup older than 30 days
find ${BACKUP_PATH_INC} -mindepth 1 -maxdepth 2 -type d -mtime +30 -exec rm -rf {} \;
