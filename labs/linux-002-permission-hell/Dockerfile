FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
    vim nano procps less tree sudo 2>/dev/null && \
    rm -rf /var/lib/apt/lists/*

# Create the deploy user
RUN useradd -m -s /bin/bash deploy

# Create app structure
RUN mkdir -p /app

# Fake config file
RUN echo 'db_host: "postgres.internal"\ndb_port: 5432\napp_env: "production"\nsecret_key: "s3cr3t"' \
    > /app/config.yml

# Deploy script that reads config and "deploys"
RUN printf '#!/bin/bash\nset -e\nCONFIG=$(cat /app/config.yml)\necho "Reading config..."\necho "$CONFIG" | grep app_env\necho "Deploy successful ✅"\n' \
    > /app/deploy.sh

COPY break.sh /break.sh
COPY check.sh /check.sh
RUN chmod +x /break.sh /check.sh

RUN echo '\n\
💥 BreakOps — linux-002: Permission Hell\n\
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\
  The CI/CD pipeline failed at deploy step.\n\
  The deploy user cant run the script or read config.\n\
  You are logged in as root. Fix the permissions.\n\
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n' >> /etc/bash.bashrc

ENTRYPOINT ["/break.sh"]
CMD ["/bin/bash"]
