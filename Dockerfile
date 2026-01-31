FROM browserless/chrome:latest

USER root

# Find node path at build time and create startup script
RUN NODE_PATH=$(which node) && \
    echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'set -e' >> /entrypoint.sh && \
    echo 'if [ -d "/data" ]; then' >> /entrypoint.sh && \
    echo '  chown -R blessuser:blessuser /data 2>/dev/null || true' >> /entrypoint.sh && \
    echo '  chmod -R 755 /data 2>/dev/null || true' >> /entrypoint.sh && \
    echo 'fi' >> /entrypoint.sh && \
    echo "cd /usr/src/app && exec runuser -u blessuser -- $NODE_PATH build/index.js" >> /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    echo "Node path: $NODE_PATH" && \
    cat /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
