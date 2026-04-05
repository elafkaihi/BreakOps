#!/bin/bash
PASS=true

# Check 1: nginx is running
if pgrep nginx > /dev/null 2>&1; then
  echo "✅ nginx is running."
else
  echo "❌ nginx is not running."
  echo "   Fix: nginx"
  PASS=false
fi

# Check 2: no DROP rule on port 80
if iptables -L INPUT -n 2>/dev/null | grep -q "dpt:80.*DROP\|DROP.*dpt:80"; then
  echo "❌ iptables DROP rule for port 80 is still present."
  echo "   Fix: iptables -D INPUT -p tcp --dport 80 -j DROP"
  PASS=false
else
  echo "✅ No iptables DROP rule on port 80."
fi

# Check 3: curl localhost works
if curl -s --max-time 3 http://localhost | grep -qi "BreakOps\|nginx\|html"; then
  echo "✅ Port 80 is reachable — app is serving traffic."
else
  echo "❌ Port 80 is still not reachable."
  PASS=false
fi

$PASS
