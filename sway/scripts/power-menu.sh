#!/usr/bin/env bash

get_fuzzel_config() {
  local theme_file="$HOME/.cache/current-theme"
  local generated_config="$XDG_RUNTIME_DIR/fuzzel-current.ini"
  local theme="dark"

  if [[ -r "$theme_file" ]]; then
    theme=$(<"$theme_file")
  fi

  {
    printf '[main]\n'
    printf 'include=%s\n' "$HOME/.config/fuzzel/fuzzel.ini"

    if [[ "$theme" == "light" ]]; then
      printf 'include=%s\n' "$HOME/.config/fuzzel/theme-light.ini"
    else
      printf 'include=%s\n' "$HOME/.config/fuzzel/theme-dark.ini"
    fi
  } >"$generated_config"

  printf '%s\n' "$generated_config"
}

FUZZEL_CONFIG=$(get_fuzzel_config)
export FUZZEL_CONFIG

choice=$(
  printf '%s\n' \
    'Lock' \
    'Suspend' \
    'Reboot' \
    'Shutdown' |
    fuzzel --config="$FUZZEL_CONFIG" --dmenu --prompt='Power > '
)

case "$choice" in
Lock)
  swaylock -f
  ;;
Suspend)
  swaylock -f && systemctl suspend
  ;;
Reboot)
  systemctl reboot
  ;;
Shutdown)
  systemctl poweroff
  ;;
esac
