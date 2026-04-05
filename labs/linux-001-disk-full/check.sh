#!/bin/bash

PASS=true

# Check 1: /app filesystem has at least 20% free
FREE_BLOCKS=$(df /app | awk 'NR==2 {print $4}')
TOTAL_BLOCKS=$(df /app | awk 'NR==2 {print $2}')
FREE_PERCENT=$(awk "BEGIN {printf \"%d\", ($FREE_BLOCKS/$TOTAL_BLOCKS)*100}")

if [ "$FREE_PERCENT" -ge 20 ]; then
  echo "✅ Disk space: /app is ${FREE_PERCENT}% free — application can write again."
else
  echo "❌ Disk space: /app is only ${FREE_PERCENT}% free. Need at least 20%."
  echo "   Tip: rm the large .log files from /app/logs/"
  PASS=false
fi

# Check 2: marker file still present (didn't wipe everything)
if [ -f /app/data/.breakops_marker ]; then
  echo "✅ Application data intact."
else
  echo "⚠️  /app/data was wiped. The app data should be preserved — only clean logs."
  PASS=false
fi

$PASS
