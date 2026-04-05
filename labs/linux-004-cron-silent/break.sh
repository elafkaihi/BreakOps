#!/bin/bash
# Break 1: cron daemon not running (just don't start it)
# Break 2: backup script not executable
chmod 644 /app/backup.sh

exec "$@"
