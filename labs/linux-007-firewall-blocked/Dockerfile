FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
    nginx iptables curl vim nano procps iproute2 net-tools less 2>/dev/null && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html && \
    echo '<h1>BreakOps App — Running Fine!</h1>' > /var/www/html/index.html

COPY break.sh /break.sh
COPY check.sh /check.sh
RUN chmod +x /break.sh /check.sh

RUN printf '\n💥 BreakOps — linux-007: Firewall Blocked\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n  App is deployed and running. Users get nothing.\n  Something is blocking traffic. Find it.\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n' > /etc/motd
RUN echo 'cat /etc/motd' >> /etc/bash.bashrc

ENTRYPOINT ["/break.sh"]
CMD ["/bin/bash"]
