#!/usr/bin/env bash
set -euo pipefail

LOG="$HOME/.cache/sway-layout-auto.log"

get_output_by_serial() {
  local serial="$1"
  swaymsg -t get_outputs | jq -r --arg serial "$serial" '
    .[] | select(.serial == $serial) | .name
  ' | head -n1
}

has_work_setup() {
  swaymsg -t get_outputs | jq -e '
    any(.[]; .model == "DELL U2419H")
  ' >/dev/null
}

{
  echo "---- $(date) ----"
  swaymsg -t get_outputs | jq -r '.[] | "\(.name) | \(.make) | \(.model) | \(.serial)"'
} >>"$LOG" 2>&1

if has_work_setup; then
  echo "profile=work" >>"$LOG"

  LEFT_MONITOR="$(get_output_by_serial "GKQDZ13")"
  RIGHT_MONITOR="HDMI-A-1"
  LAPTOP="eDP-1"

  swaymsg output "$LEFT_MONITOR" position 0 0
  swaymsg output "$RIGHT_MONITOR" position 1920 0
  swaymsg output "$LAPTOP" position 0 1080

  swaymsg "workspace dev; move workspace to output $RIGHT_MONITOR"
  swaymsg "workspace web; move workspace to output $LEFT_MONITOR"
  swaymsg "workspace notes; move workspace to output $LAPTOP"
  swaymsg "workspace tasks; move workspace to output $LAPTOP"
  swaymsg workspace com
else
  echo "profile=home" >>"$LOG"

  swaymsg output HDMI-A-1 position 0 0
  swaymsg output eDP-1 position 2560 0

  swaymsg "workspace dev; move workspace to output HDMI-A-1"
  swaymsg "workspace web; move workspace to output HDMI-A-1"
  swaymsg "workspace notes; move workspace to output eDP-1"
  swaymsg "workspace tasks; move workspace to output eDP-1"
fi
