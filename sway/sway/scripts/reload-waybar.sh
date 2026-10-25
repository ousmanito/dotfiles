#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/sway-theme"

pkill -x waybar || true
sleep 0.2

if [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "light" ]]; then
  waybar -c "$HOME/.config/waybar/config.jsonc" -s "$HOME/.config/waybar/style-light.css" &
else
  waybar -c "$HOME/.config/waybar/config.jsonc" -s "$HOME/.config/waybar/style.css" &
fi

#!/usr/bin/env bash
set -euo pipefail

if pgrep -x waybar >/dev/null; then
  pkill -USR2 -x waybar
else
  "$HOME/.config/sway/scripts/start-waybar.sh"
fi
