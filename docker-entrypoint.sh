#!/usr/bin/env sh
set -eu

DOCROOT="${CANVASS_DOCROOT:-/opt/canvass/site}"
PORT="${CANVASS_PORT:-8100}"

mkdir -p "$DOCROOT"

if [ ! -f "$DOCROOT/index.html" ]; then
  echo "[canvass] WARNING: $DOCROOT/index.html not found; writing fallback landing page."
  cat > "$DOCROOT/index.html" <<'HTML'
<!doctype html>
<html lang="en">
  <head><meta charset="utf-8"><title>Canvass</title></head>
  <body>
    <h1>Canvass container is running</h1>
    <p>No <code>index.html</code> was found in the document root, so this fallback page was generated.</p>
  </body>
</html>
HTML
fi

echo "[canvass] serving $DOCROOT on 0.0.0.0:$PORT"
exec python -m http.server "$PORT" --bind 0.0.0.0 --directory "$DOCROOT"
