#!/bin/bash
# Fills /app (tmpfs 150MB) with fake log files, leaving ~5MB free.
# /app is mounted as tmpfs by the CLI (--tmpfs /app:size=150m)

mkdir -p /app/logs /app/data

# Simulate several days of unrotated logs
for i in $(seq 1 6); do
  dd if=/dev/zero of="/app/logs/app-2024-01-0${i}.log" bs=1M count=20 2>/dev/null
done

dd if=/dev/zero of="/app/logs/error-2024-01-07.log" bs=1M count=8 2>/dev/null

# Current log the app is trying to write to — nearly full, last write fails
dd if=/dev/zero of="/app/logs/app.log" bs=1M count=2 2>/dev/null

echo "[$(date)] ERROR: No space left on device — logging stopped" >> /app/logs/app.log 2>/dev/null || true

# Keep a small marker file
echo "breakops:disk-full" > /app/data/.breakops_marker

exec "$@"
