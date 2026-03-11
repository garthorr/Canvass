# Canvass

This repository is containerized to run as a self-contained Docker service.
It includes a default `index.html` entry page so loading the container shows an app page instead of a raw directory listing.

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

## Troubleshooting directory listing at `/`

If you still see a file listing instead of the app page, the most common causes are:

1. **Old image is still running**
   ```bash
   docker ps
   docker compose down
   docker build --no-cache -t canvass .
   docker run --rm -p 8100:8100 canvass
   ```
2. **A bind mount overwrote `/app` inside the container**
   - If you run with `-v ...:/app`, make sure the mounted folder contains `index.html`.
3. **Wrong URL/port**
   - Use `http://localhost:8100/`.

The container entrypoint now logs the exact document root it serves and creates a fallback `index.html` if one is missing, so you should no longer get a bare directory listing.


## Resolving GitHub PR conflicts (Dockerfile/README/docker-compose)

If GitHub shows **"This branch has conflicts that must be resolved"**, resolve them locally and push the updated branch:

```bash
# on your machine (repo with origin configured)
git checkout work
git fetch origin
git rebase origin/main

# if conflicts appear, keep the conflict markers visible files open and resolve them,
# then continue:
git add Dockerfile README.md docker-compose.yml
git rebase --continue

# update the PR branch after rebase
git push --force-with-lease origin work
```

Quick conflict strategy for this project:
- Keep `8100` as the exposed/mapped port.
- Keep `ENTRYPOINT ["/app/docker-entrypoint.sh"]` in `Dockerfile`.
- Keep the README troubleshooting section for directory listing issues.

After push, GitHub will recompute the PR and the conflict warning should clear.
