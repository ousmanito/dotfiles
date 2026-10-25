#!/usr/bin/env bash
set -euo pipefail

APP_ID="blueman-manager"

window_exists() {
  swaymsg -t get_tree |
    jq -e --arg app_id "$APP_ID" '
      .. | objects
      | select(.app_id? == $app_id)
    ' >/dev/null
}

if window_exists; then
  swaymsg "[app_id=\"$APP_ID\"] scratchpad show"
  exit 0
fi

blueman-manager >/dev/null 2>&1 &

for _ in $(seq 1 50); do
  if window_exists; then
    swaymsg \
      "[app_id=\"$APP_ID\"] scratchpad show, resize set width 65 ppt height 70 ppt, move position center"
    exit 0
  fi

  sleep 0.1
done

exit 1
