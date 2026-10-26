#!/usr/bin/env bash
set -euo pipefail

export PATH="/home/obathily/.cargo/bin/:$PATH"
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/sway-theme"

# Si le fichier n'existe pas, on considère qu'on est en "dark"
# On cherche donc à basculer vers "light"
CURRENT="dark"
if [[ -f "$STATE_FILE" ]]; then
  CURRENT="$(cat "$STATE_FILE")"
fi

# Inversion logique ou gestion explicite :
# Si on est actuellement en "light", on passe en "dark". Sinon (si "dark" ou inexistant), on passe en "light".
if [[ "$CURRENT" == "light" ]]; then
  # --- PASSAGE EN MODE SOMBRE ---
  echo "dark" >"$STATE_FILE"
  echo "dark" >~/.cache/current-theme
  echo "tokyonight-night" >~/.cache/nvim-theme

  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' || true
  gsettings set org.gnome.desktop.interface icon-theme 'Yaru-dark' || true

  swaymsg 'client.focused #2563eb #2563eb #ffffff #2563eb #2563eb'
  swaymsg 'client.unfocused #cbd5e1 #cbd5e1 #334155 #cbd5e1 #cbd5e1'
  althemer switch night_owl
else
  # --- PASSAGE EN MODE CLAIR ---
  echo "light" >"$STATE_FILE"
  echo "light" >~/.cache/current-theme
  echo "tokyonight-day" >~/.cache/nvim-theme

  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light' || true
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita' || true
  gsettings set org.gnome.desktop.interface icon-theme 'Yaru' || true

  swaymsg 'client.focused #89b4fa #89b4fa #11111b #89b4fa #89b4fa'
  swaymsg 'client.unfocused #313244 #313244 #cdd6f4 #313245 #313244'
  althemer switch rose-pine-dawn
fi

~/.config/sway/scripts/reload-waybar.sh
