#!/bin/bash
PASS=true

# Check 1: cron daemon is running
if pgrep -x cron > /dev/null 2>&1 || pgrep -x crond > /dev/null 2>&1; then
  echo "✅ cron daemon is running."
else
  echo "❌ cron daemon is not running."
  echo "   Fix: service cron start"
  PASS=false
fi

# Check 2: backup.sh is executable
if [ -x /app/backup.sh ]; then
  echo "✅ backup.sh is executable."
else
  echo "❌ backup.sh is not executable."
  echo "   Fix: chmod +x /app/backup.sh"
  PASS=false
fi

# Check 3: backup script actually runs
if /app/backup.sh > /dev/null 2>&1; then
  echo "✅ backup.sh runs successfully."
else
  echo "❌ backup.sh failed to execute."
  PASS=false
fi

$PASS
