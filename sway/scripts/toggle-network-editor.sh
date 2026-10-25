#!/usr/bin/env bash
set -euo pipefail

APP_ID="nm-connection-editor"

if swaymsg -t get_tree |
  jq -e --arg app_id "$APP_ID" '
    .. | objects | select(.app_id? == $app_id)
  ' >/dev/null; then
  swaymsg "[app_id=\"$APP_ID\"] scratchpad show"
  exit 0
fi

nm-connection-editor &

for _ in $(seq 1 50); do
  if swaymsg -t get_tree |
    jq -e --arg app_id "$APP_ID" '
      .. | objects | select(.app_id? == $app_id)
    ' >/dev/null; then
    swaymsg "[app_id=\"$APP_ID\"] scratchpad show"
    exit 0
  fi

  sleep 0.1
done
