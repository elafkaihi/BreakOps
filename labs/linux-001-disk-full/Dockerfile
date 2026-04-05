FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
    curl wget vim nano procps less tree 2>/dev/null && \
    rm -rf /var/lib/apt/lists/*

# Create app structure
RUN mkdir -p /app/logs /app/data

# Simulate a real app binary
RUN echo '#!/bin/bash\necho "myapp running..."\nwhile true; do echo "$(date) INFO processing" >> /app/logs/app.log; sleep 1; done' \
    > /usr/local/bin/myapp && chmod +x /usr/local/bin/myapp

COPY break.sh /break.sh
COPY check.sh /check.sh
RUN chmod +x /break.sh /check.sh

# MOTD shown on shell entry
RUN printf '\n💥 BreakOps — linux-001: Disk Full\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n  The application stopped writing logs.\n  On-call just pinged you. Fix it.\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n' > /etc/motd
RUN echo 'cat /etc/motd' >> /etc/bash.bashrc

ENTRYPOINT ["/break.sh"]
CMD ["/bin/bash"]
