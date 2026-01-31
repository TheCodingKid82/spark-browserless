FROM browserless/chrome:latest

USER root

# Fix permissions on /data at startup, then run browserless
RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'set -e' >> /entrypoint.sh && \
    echo 'if [ -d "/data" ]; then' >> /entrypoint.sh && \
    echo '  chown -R blessuser:blessuser /data 2>/dev/null || true' >> /entrypoint.sh && \
    echo '  chmod -R 755 /data 2>/dev/null || true' >> /entrypoint.sh && \
    echo 'fi' >> /entrypoint.sh && \
    echo 'exec runuser -u blessuser -- /usr/local/bin/node /usr/src/app/build/index.js' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]