FROM python:3.12-slim

WORKDIR /app
COPY . /app

EXPOSE 8100

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8100', timeout=3)"

CMD ["python", "-m", "http.server", "8100", "--bind", "0.0.0.0"]
