FROM python:3.12-slim

WORKDIR /app
COPY . /app

RUN mkdir -p /opt/canvass/site \
    && cp /app/index.html /opt/canvass/site/index.html \
    && cp /app/docker-entrypoint.sh /usr/local/bin/canvass-entrypoint \
    && chmod +x /usr/local/bin/canvass-entrypoint

EXPOSE 8100

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8100', timeout=3)"

ENTRYPOINT ["/usr/local/bin/canvass-entrypoint"]
