FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
    cron python3 vim nano procps less 2>/dev/null && \
    rm -rf /var/lib/apt/lists/*

# The memory hog script — allocates RAM indefinitely
RUN printf '#!/usr/bin/env python3\nimport time\ndata = []\nwhile True:\n    data.append("x" * 1024 * 1024)  # allocate 1MB per iteration\n    time.sleep(0.5)\n' \
    > /app/memhog.sh && chmod +x /app/memhog.sh

# Cron entry that keeps restarting the hog
RUN echo "* * * * * root /app/memhog.sh &" \
    > /etc/cron.d/memhog && chmod 644 /etc/cron.d/memhog

# Fake OOM evidence in kernel log
RUN mkdir -p /var/log && \
    printf '[123456.789] python3 invoked oom-killer: gfp_mask=0x100dca, order=0\n[123456.790] Out of memory: Kill process 1234 (python3) score 987 or sacrifice child\n[123456.791] Killed process 1234 (python3) total-vm:204800kB, anon-rss:198400kB\n' \
    > /var/log/kern.log

COPY break.sh /break.sh
COPY check.sh /check.sh
RUN chmod +x /break.sh /check.sh

RUN printf '\n💥 BreakOps — linux-006: OOM Killer Strikes\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n  The app keeps dying. Ops suspects memory.\n  Find the culprit and stop it.\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n' > /etc/motd
RUN echo 'cat /etc/motd' >> /etc/bash.bashrc

ENTRYPOINT ["/break.sh"]
CMD ["/bin/bash"]
