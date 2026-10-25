#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="$HOME/.cache/current-theme"
THEME="dark"

if [[ -r "$STATE_FILE" ]]; then
  THEME=$(<"$STATE_FILE")
fi

if [[ "$THEME" == "light" ]]; then
  exec /usr/local/bin/waybar \
    --config "$HOME/.config/waybar/config.jsonc" \
    --style "$HOME/.config/waybar/style-light.css"
else
  exec /usr/local/bin/waybar \
    --config "$HOME/.config/waybar/config.jsonc" \
    --style "$HOME/.config/waybar/style.css"
fi
