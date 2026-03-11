# Canvass

This repository is containerized to run as a self-contained Docker service.
It now includes a default `index.html` entry page so loading the container shows an app page instead of a raw directory listing.

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
