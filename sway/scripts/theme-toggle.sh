#!/usr/bin/env bash
set -euo pipefail

export PATH="/home/obathily/.cargo/bin/:$PATH"

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/sway-theme"

# Au démarrage le fichier d'état n'existe pas encore ; le thème par défaut
# étant sombre, on considère "absent" == "dark" pour que le 1er appui bascule
# bien vers le clair.
CURRENT="dark"
if [[ -f "$STATE_FILE" ]]; then
  CURRENT="$(cat "$STATE_FILE")"
fi

if [[ "$CURRENT" != "light" ]]; then
  echo "light" >"$STATE_FILE"
  echo "light" >~/.cache/current-theme
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light' || true
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita' || true
  gsettings set org.gnome.desktop.interface icon-theme 'Yaru' || true

  swaymsg 'client.focused #89b4fa #89b4fa #11111b #89b4fa #89b4fa'
  swaymsg 'client.unfocused #313244 #313244 #cdd6f4 #313245 #313244'
  althemer switch rose-pine-dawn
else
  echo "dark" >"$STATE_FILE"
  echo "dark" >~/.cache/current-theme
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true
  gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' || true
  gsettings set org.gnome.desktop.interface icon-theme 'Yaru-dark' || true

  swaymsg 'client.focused #2563eb #2563eb #ffffff #2563eb #2563eb'
  swaymsg 'client.unfocused #cbd5e1 #cbd5e1 #334155 #cbd5e1 #cbd5e1'
  althemer switch night_owl
fi

~/.config/sway/scripts/reload-waybar.sh
