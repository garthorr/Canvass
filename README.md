# Canvass

This repository is containerized to run as a self-contained Docker service.

## Run with Docker

```bash
docker build -t canvass .
docker run --rm -p 8100:8100 canvass
```

Then open http://localhost:8100.

## Run with Docker Compose

```bash
docker compose up --build
```
