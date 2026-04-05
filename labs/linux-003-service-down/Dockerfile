FROM ubuntu:22.04

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
    nginx curl vim nano procps less 2>/dev/null && \
    rm -rf /var/lib/apt/lists/*

# Drop the default nginx config and use our own
RUN rm -f /etc/nginx/sites-enabled/default

# Create a custom vhost config — this will be broken
RUN mkdir -p /etc/nginx/conf.d
RUN printf 'server {\n\
    listen 80;\n\
    server_nmae localhost;  # intentional typo\n\
\n\
    access_log /var/log/nginx/app_access.log;\n\
    error_log  /var/log/nginx/app_error.log;\n\
\n\
    location / {\n\
        root /var/www/html;\n\
        index index.html;\n\
    }\n\
}\n' > /etc/nginx/conf.d/app.conf

# Provide a simple landing page
RUN mkdir -p /var/www/html && \
    echo '<h1>Welcome to BreakOps App</h1>' > /var/www/html/index.html

# Remove nginx log directory so the second error surfaces
RUN rm -rf /var/log/nginx

COPY break.sh /break.sh
COPY check.sh /check.sh
RUN chmod +x /break.sh /check.sh

RUN echo '\n\
💥 BreakOps — linux-003: Service Wont Start\n\
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\
  nginx is down. It was working yesterday.\n\
  Ops team is waiting. Fix it.\n\
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n' >> /etc/bash.bashrc

ENTRYPOINT ["/break.sh"]
CMD ["/bin/bash"]
