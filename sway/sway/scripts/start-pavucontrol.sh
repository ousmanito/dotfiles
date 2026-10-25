#!/usr/bin/env bash
set -euo pipefail

LOG="$HOME/.cache/start-pavucontrol.log"

for _ in $(seq 1 50); do
  if timeout 1s pactl info >/dev/null 2>&1 &&
    timeout 1s wpctl status >/dev/null 2>&1; then
    exec pavucontrol
  fi

  sleep 0.2
done

printf '%s PipeWire/PulseAudio ne répond pas\n' "$(date --iso-8601=seconds)" >>"$LOG"
exit 1
