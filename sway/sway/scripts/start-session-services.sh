#!/usr/bin/env bash
set -u

LOG="$HOME/.cache/sway-session-services.log"

exec >>"$LOG" 2>&1

echo
echo "===== $(date --iso-8601=seconds) ====="

# Exporte l’environnement réel de la session Sway.
dbus-update-activation-environment --systemd \
  DISPLAY \
  WAYLAND_DISPLAY \
  SWAYSOCK \
  XDG_CURRENT_DESKTOP \
  XDG_SESSION_TYPE

systemctl --user import-environment \
  DISPLAY \
  WAYLAND_DISPLAY \
  SWAYSOCK \
  XDG_CURRENT_DESKTOP \
  XDG_SESSION_TYPE

# Redémarrage propre après l’ancienne session GNOME.
systemctl --user restart \
  xdg-desktop-portal-wlr.service \
  xdg-desktop-portal-gtk.service \
  xdg-desktop-portal.service

# Attend que le portail principal réponde réellement.
for _ in $(seq 1 50); do
  if gdbus introspect \
    --session \
    --dest org.freedesktop.portal.Desktop \
    --object-path /org/freedesktop/portal/desktop \
    >/dev/null 2>&1; then
    echo "Portal ready"
    break
  fi

  sleep 0.1
done

# Empêche une ancienne instance résiduelle.
pkill -x waybar 2>/dev/null || true

echo "Starting Waybar"
"$HOME/.config/sway/scripts/start-waybar.sh"
