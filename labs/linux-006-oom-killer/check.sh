#!/bin/bash
PASS=true

# Check 1: memhog process is not running
if pgrep -f memhog > /dev/null 2>&1; then
  echo "❌ Memory hog process is still running."
  echo "   Fix: pkill -f memhog"
  PASS=false
else
  echo "✅ Memory hog process has been stopped."
fi

# Check 2: cron entry is removed
if [ -f /etc/cron.d/memhog ]; then
  echo "❌ Cron entry still exists — memhog will restart every minute."
  echo "   Fix: rm /etc/cron.d/memhog"
  PASS=false
else
  echo "✅ Cron entry removed — memhog won't restart."
fi

# Check 3: memory is somewhat free
FREE_MB=$(free -m | awk 'NR==2 {print $4}')
if [ "$FREE_MB" -gt 30 ]; then
  echo "✅ Memory is available: ${FREE_MB}MB free."
else
  echo "❌ Memory still critically low: ${FREE_MB}MB free."
  PASS=false
fi

$PASS
