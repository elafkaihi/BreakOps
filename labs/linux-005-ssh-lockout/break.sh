#!/bin/bash
# Break 1: invalid sshd_config directive
sed -i 's/PermitRootLogin yes/PermitRootLogin yes please/' /etc/ssh/sshd_config

# Break 2: wrong permissions on .ssh directory and authorized_keys
chmod 755 /root/.ssh
chmod 644 /root/.ssh/authorized_keys

exec "$@"
