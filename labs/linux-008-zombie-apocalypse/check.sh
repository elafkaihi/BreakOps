#!/bin/bash
PASS=true

# Check 1: no zombie processes remain
ZOMBIE_COUNT=$(ps aux | awk '$8 == "Z"' | grep -v grep | wc -l)
if [ "$ZOMBIE_COUNT" -eq 0 ]; then
  echo "✅ No zombie processes found."
else
  echo "❌ $ZOMBIE_COUNT zombie process(es) still running."
  echo "   Fix: pkill -f zombie_factory"
  PASS=false
fi

# Check 2: zombie_factory parent is gone
if pgrep -f zombie_factory > /dev/null 2>&1; then
  echo "❌ zombie_factory is still running — it will keep spawning zombies."
  echo "   Fix: pkill -f zombie_factory"
  PASS=false
else
  echo "✅ zombie_factory process has been terminated."
fi

$PASS
