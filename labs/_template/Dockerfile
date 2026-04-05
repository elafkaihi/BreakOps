FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
    vim nano procps curl 2>/dev/null && \
    rm -rf /var/lib/apt/lists/*

# Setup: create users, files, services needed for the scenario
# RUN useradd -m appuser

COPY break.sh /break.sh
COPY check.sh /check.sh
RUN chmod +x /break.sh /check.sh

# MOTD shown when the user enters the shell
RUN echo '\n💥 BreakOps — Your Lab Title\n━━━━━━━━━━━━━━━━━━━━━━━━━\n  Describe what is broken in one line.\n━━━━━━━━━━━━━━━━━━━━━━━━━\n' \
    >> /etc/bash.bashrc

# break.sh runs at container start via ENTRYPOINT
ENTRYPOINT ["/break.sh"]
CMD ["/bin/bash"]
