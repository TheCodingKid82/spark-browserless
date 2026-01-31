FROM browserless/chrome:latest

USER root

# Create entrypoint script that fixes permissions before starting
RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'if [ -d "/data" ]; then' >> /entrypoint.sh && \
    echo '  chown -R blessuser:blessuser /data 2>/dev/null || true' >> /entrypoint.sh && \
    echo '  chmod -R 755 /data 2>/dev/null || true' >> /entrypoint.sh && \
    echo 'fi' >> /entrypoint.sh && \
    echo 'exec su blessuser -c "/usr/bin/dumb-init -- /usr/local/bin/start.sh \$@"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]