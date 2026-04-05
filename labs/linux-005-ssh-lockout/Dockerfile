FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
    openssh-server vim nano procps less 2>/dev/null && \
    rm -rf /var/lib/apt/lists/*

# Setup SSH directory with a fake authorized key
RUN mkdir -p /root/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2 devops@workstation" \
    > /root/.ssh/authorized_keys

# Set correct permissions initially (break.sh will break them)
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# Ensure sshd_config has PermitRootLogin
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config || \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

COPY break.sh /break.sh
COPY check.sh /check.sh
RUN chmod +x /break.sh /check.sh

RUN printf '\n💥 BreakOps — linux-005: SSH Lockout\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n  Nobody can SSH in after last nights hardening.\n  You have console access. Fix it.\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n' > /etc/motd
RUN echo 'cat /etc/motd' >> /etc/bash.bashrc

ENTRYPOINT ["/break.sh"]
CMD ["/bin/bash"]
