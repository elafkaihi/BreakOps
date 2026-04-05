#!/bin/bash
# Break permissions on the deploy script and config

# deploy.sh: owned by root, not executable by others
chown root:root /app/deploy.sh
chmod 644 /app/deploy.sh   # no execute bit

# config.yml: owned by root, only root can read
chown root:root /app/config.yml
chmod 600 /app/config.yml   # deploy user can't read

exec "$@"
