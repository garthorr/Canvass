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

## One-time Git setup so `git pull` always gets `main`

Run this once in your local clone on your Mac:

```bash
cd /path/to/Canvass
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/garthorr/Canvass.git
git fetch origin
git checkout -B main origin/main
git branch --set-upstream-to=origin/main main
git config pull.rebase true
```

After that, your normal update command is just:

```bash
git checkout main
git pull
```

And to publish your own edits:

```bash
git add .
git commit -m "your message"
git push
```

## Troubleshooting directory listing at `/`

If you still see a file listing instead of the app page, use this exact reset flow:

```bash
docker compose down --remove-orphans
docker compose build --no-cache
docker compose up -d --force-recreate
docker compose logs --tail=50
```

Then open `http://localhost:8100/`.

### Why this is more reliable now

The image serves from `/opt/canvass/site` (not `/app`). So even if you bind-mount your repo into `/app`, it will still serve the image's landing page.
The entrypoint also logs the active document root and creates a fallback `index.html` when missing.

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
- Keep `ENTRYPOINT ["/usr/local/bin/canvass-entrypoint"]` in `Dockerfile`.
- Keep the README troubleshooting section for directory listing issues.

After push, GitHub will recompute the PR and the conflict warning should clear.
