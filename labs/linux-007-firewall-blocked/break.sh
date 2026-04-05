#!/bin/bash
# Start nginx
nginx 2>/dev/null || true

# Add iptables rule to drop port 80 traffic
iptables -A INPUT -p tcp --dport 80 -j DROP 2>/dev/null || true

exec "$@"
