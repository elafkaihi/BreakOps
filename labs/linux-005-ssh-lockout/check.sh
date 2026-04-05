#!/bin/bash
PASS=true

# Check 1: sshd config is valid
if sshd -t 2>/dev/null; then
  echo "✅ sshd config is valid."
else
  echo "❌ sshd config has errors:"
  sshd -t 2>&1 | sed 's/^/   /'
  PASS=false
fi

# Check 2: .ssh directory has correct permissions (700)
SSH_PERMS=$(stat -c "%a" /root/.ssh)
if [ "$SSH_PERMS" = "700" ]; then
  echo "✅ /root/.ssh permissions are correct (700)."
else
  echo "❌ /root/.ssh permissions are $SSH_PERMS (should be 700)."
  echo "   Fix: chmod 700 /root/.ssh"
  PASS=false
fi

# Check 3: authorized_keys has correct permissions (600)
AK_PERMS=$(stat -c "%a" /root/.ssh/authorized_keys)
if [ "$AK_PERMS" = "600" ]; then
  echo "✅ authorized_keys permissions are correct (600)."
else
  echo "❌ authorized_keys permissions are $AK_PERMS (should be 600)."
  echo "   Fix: chmod 600 /root/.ssh/authorized_keys"
  PASS=false
fi

$PASS
