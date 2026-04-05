#!/bin/bash
# The breaks are already baked into the Dockerfile:
# 1. Typo in /etc/nginx/conf.d/app.conf (server_nmae)
# 2. /var/log/nginx/ directory is missing

# Make sure nginx is stopped
nginx -s stop 2>/dev/null || true

exec "$@"
