FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
    python3 vim nano procps less 2>/dev/null && \
    rm -rf /var/lib/apt/lists/*

# The zombie factory script
RUN printf '#!/usr/bin/env python3\nimport os, time, sys\n\n# Spawn zombie children by forking and never calling wait()\nfor i in range(20):\n    pid = os.fork()\n    if pid == 0:  # child process\n        sys.exit(0)  # child exits immediately -> becomes zombie\n    # parent never calls os.wait() -> children stay as zombies\n\nprint(f"zombie_factory: spawned 20 zombies, sleeping...")\ntime.sleep(86400)  # parent stays alive, keeping zombies in existence\n' \
    > /app/zombie_factory.py && chmod +x /app/zombie_factory.py

COPY break.sh /break.sh
COPY check.sh /check.sh
RUN chmod +x /break.sh /check.sh

RUN printf '\n💥 BreakOps — linux-008: Zombie Apocalypse\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n  Dozens of zombie processes. PIDs exhausted.\n  Server is degrading. Clean it up.\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n' > /etc/motd
RUN echo 'cat /etc/motd' >> /etc/bash.bashrc

ENTRYPOINT ["/break.sh"]
CMD ["/bin/bash"]
