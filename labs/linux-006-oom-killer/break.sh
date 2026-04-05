#!/bin/bash
# Start the memory hog in the background
mkdir -p /app
/app/memhog.sh &
echo $! > /var/run/memhog.pid

exec "$@"
