#!/bin/bash

PASS=true

# Check 1: deploy.sh is executable
if [ -x /app/deploy.sh ]; then
  echo "✅ deploy.sh has execute permission."
else
  echo "❌ deploy.sh is not executable."
  echo "   Fix: chmod +x /app/deploy.sh"
  PASS=false
fi

# Check 2: deploy user can read config.yml
if su - deploy -c "cat /app/config.yml > /dev/null 2>&1"; then
  echo "✅ deploy user can read config.yml."
else
  echo "❌ deploy user cannot read config.yml."
  echo "   Fix: chown deploy:deploy /app/config.yml  or  chmod o+r /app/config.yml"
  PASS=false
fi

# Check 3: full deploy script runs as deploy user
OUTPUT=$(su - deploy -c '/app/deploy.sh 2>&1')
if echo "$OUTPUT" | grep -q "Deploy successful"; then
  echo "✅ Deploy script runs successfully as deploy user."
else
  echo "❌ Deploy script still fails as deploy user."
  echo "   Output: $OUTPUT"
  PASS=false
fi

$PASS
