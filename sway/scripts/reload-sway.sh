#!/usr/bin/env bash
set -euo pipefail

# Récupère l’index actif du premier vrai clavier configuré.
layout_index="$(
  swaymsg -t get_inputs |
    jq -r '
      [
        .[]
        | select(.type == "keyboard")
        | select(.xkb_active_layout_index != null)
      ][0].xkb_active_layout_index // 0
    '
)"

# Recharge Sway.
swaymsg reload

# Laisse Sway réappliquer la configuration XKB.
sleep 0.2

# Restaure le layout précédent sur tous les claviers.
swaymsg input type:keyboard xkb_switch_layout "$layout_index"

# Recharge les composants associés.
"$HOME/.config/sway/scripts/reload-waybar.sh"
