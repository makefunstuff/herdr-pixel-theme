#!/bin/sh
# Install the Herdr pixel theme into the Herdr app's home folder.
set -e
SRC="$(cd "$(dirname "$0")" && pwd)/herdr-app"
DST="${HERDR_APP_HOME:-$HOME/.config/herdr-app}"
[ -d "$DST" ] || { echo "No Herdr app folder at $DST (start Herdr once first)"; exit 1; }

mkdir -p "$DST/themes" "$DST/layouts" "$DST/mods" "$DST/fonts" "$DST/sounds" "$DST/pixel-icons"
cp "$SRC/themes/pixel.json" "$DST/themes/"
cp "$SRC/layouts/pixel.json" "$SRC/layouts/pixel.svg" "$DST/layouts/"
cp "$SRC/fonts/"* "$DST/fonts/"
cp "$SRC/sounds/"* "$DST/sounds/"
cp "$SRC/pixel-icons/"* "$DST/pixel-icons/"
for m in "$SRC"/mods/px-*; do rm -rf "$DST/mods/$(basename "$m")"; cp -R "$m" "$DST/mods/"; done

# Program icons (applies to every layout). Keep a backup of an existing file.
if [ -f "$DST/programs.json" ] && ! cmp -s "$SRC/programs.json" "$DST/programs.json"; then
  cp "$DST/programs.json" "$DST/programs.json.bak-$(date +%s)"
fi
cp "$SRC/programs.json" "$DST/programs.json"

# 8-bit alert sounds: merge into settings.json.
python3 - "$DST/settings.json" <<'PY'
import json, os, sys
p = sys.argv[1]
s = json.load(open(p)) if os.path.exists(p) else {}
s.setdefault("sounds", {"enabled": True})
s["sounds"].update({"done": "sounds/done-8bit.wav", "blocked": "sounds/blocked-8bit.wav"})
json.dump(s, open(p, "w"), indent=2)
PY

if command -v herdr-app >/dev/null 2>&1; then
  herdr-app do layout.switch '{"name":"pixel"}' >/dev/null 2>&1 && echo "Switched Herdr to the pixel layout." || true
fi
echo "Installed into $DST. Switch layouts with ctrl-shift-l."
