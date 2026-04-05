#!/bin/bash

PASS=true

# Check 1: nginx config test passes
if nginx -t 2>/dev/null; then
  echo "✅ nginx config is valid."
else
  echo "❌ nginx config test fails."
  nginx -t 2>&1 | sed 's/^/   /'
  PASS=false
fi

# Check 2: nginx can start
nginx -s stop 2>/dev/null || true
sleep 1
if nginx 2>/dev/null; then
  echo "✅ nginx started successfully."
else
  echo "❌ nginx failed to start."
  nginx 2>&1 | sed 's/^/   /'
  PASS=false
fi

# Check 3: nginx is responding
if nginx -s stop 2>/dev/null; then true; fi
nginx 2>/dev/null || true
sleep 1
if curl -s http://localhost | grep -qi "welcome"; then
  echo "✅ nginx is serving content on port 80."
else
  echo "❌ nginx is not serving on port 80."
  PASS=false
fi

$PASS
