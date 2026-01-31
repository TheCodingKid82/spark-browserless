FROM browserless/chrome:latest

USER root

# Create startup script that fixes perms then runs original browserless
RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'set -e' >> /entrypoint.sh && \
    echo 'if [ -d "/data" ]; then' >> /entrypoint.sh && \
    echo '  chown -R blessuser:blessuser /data 2>/dev/null || true' >> /entrypoint.sh && \
    echo '  chmod -R 755 /data 2>/dev/null || true' >> /entrypoint.sh && \
    echo 'fi' >> /entrypoint.sh && \
    echo 'cd /usr/src/app' >> /entrypoint.sh && \
    echo 'exec runuser -u blessuser -- which node build/index.js' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]