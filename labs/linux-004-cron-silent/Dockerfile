FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
    cron vim nano procps less 2>/dev/null && \
    rm -rf /var/lib/apt/lists/*

# Create backup script
RUN mkdir -p /app/backups && \
    printf '#!/bin/bash\nDATESTAMP=$(date +%%Y%%m%%d_%%H%%M%%S)\ncp -r /app/data /app/backups/backup_$DATESTAMP 2>/dev/null || true\necho "[$(date)] Backup completed successfully" >> /var/log/backup.log\necho "Backup completed successfully"\n' \
    > /app/backup.sh

# Create some fake data to back up
RUN mkdir -p /app/data && echo "important data" > /app/data/db.dump

# Install the crontab
RUN echo "* * * * * root /app/backup.sh >> /var/log/backup.log 2>&1" \
    > /etc/cron.d/backup && chmod 644 /etc/cron.d/backup

COPY break.sh /break.sh
COPY check.sh /check.sh
RUN chmod +x /break.sh /check.sh

RUN printf '\n💥 BreakOps — linux-004: Cron Gone Silent\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n  The nightly backup has not run in 3 days.\n  No errors, no alerts. Just silence.\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n' > /etc/motd
RUN echo 'cat /etc/motd' >> /etc/bash.bashrc

ENTRYPOINT ["/break.sh"]
CMD ["/bin/bash"]
