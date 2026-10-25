#!/usr/bin/env bash
# Démarre awww-daemon de façon fiable puis applique le wallpaper.
# Attend l'apparition du socket (au lieu d'un sleep fixe) pour éviter la
# course au démarrage à froid qui laissait la Waybar transparente sur du noir.
set -uo pipefail

export PATH="$HOME/.local/bin:$PATH"

WALLPAPER="${1:-/home/obathily/Images/snow-mountains-3840x2160-25476.jpg}"
RUNTIME="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
SOCKET="$RUNTIME/${WAYLAND_DISPLAY:-wayland-1}-awww-daemon.sock"
LOG="$RUNTIME/awww-daemon.log"

# (Re)démarre le daemon proprement
pkill -x awww-daemon || true
sleep 0.3
awww-daemon >"$LOG" 2>&1 &

# Attend que le socket soit prêt (max ~6 s)
for _ in $(seq 1 60); do
  [ -S "$SOCKET" ] && break
  sleep 0.1
done

# Applique l'image, avec quelques tentatives si le daemon n'est pas tout à fait prêt
for _ in 1 2 3 4 5; do
  if awww img "$WALLPAPER" --resize crop; then
    exit 0
  fi
  sleep 0.4
done

exit 1
