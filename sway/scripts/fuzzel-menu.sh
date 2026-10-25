#!/usr/bin/env bash

set -u

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

menu() {
  fuzzel \
    --config="$FUZZEL_CONFIG" \
    --dmenu \
    --prompt="$1"
}

applications_menu() {
  # Le mode launcher natif de Fuzzel ne permet pas de revenir
  # au menu parent après sa fermeture.
  fuzzel --config="$FUZZEL_CONFIG"
}

files_menu() {
  local file

  file=$(
    /home/obathily/.local/bin/fd \
      --type f \
      --absolute-path \
      . "$HOME" |
      fuzzel \
        --config="$FUZZEL_CONFIG" \
        --dmenu \
        --prompt="Fichiers > "
  ) || return 1

  [[ -n "$file" ]] || return 1

  xdg-open "$file" >/dev/null 2>&1 &
  return 0
}

tmuxinator_menu() {
  local project

  project=$(
    tmuxinator list |
      tail -n +2 |
      tr -s ' ' '\n' |
      sed '/^$/d' |
      fuzzel \
        --config="$FUZZEL_CONFIG" \
        --dmenu \
        --prompt="Tmuxinator > "
  ) || return 1

  [[ -n "$project" ]] || return 1

  alacritty -e tmuxinator start "$project" &
  return 0
}

tmux_menu() {
  local session

  session=$(
    tmux list-sessions -F '#{session_name}' 2>/dev/null |
      fuzzel \
        --config="$FUZZEL_CONFIG" \
        --dmenu \
        --prompt="Tmux > "
  ) || return 1

  [[ -n "$session" ]] || return 1

  alacritty -e tmux attach-session -t "$session" &
  return 0
}

while true; do
  choice=$(
    printf '%s\n' \
      " Apps" \
      " Fichiers" \
      " tmuxinator" \
      " tmux" \
      "󰐥 Alimentation" |
      menu ""
  ) || exit 0

  case "$choice" in
  " Apps")
    fuzzel --config="$FUZZEL_CONFIG"
    exit 0
    ;;

  " Fichiers")
    if files_menu; then
      exit 0
    fi
    ;;

  " tmuxinator")
    if tmuxinator_menu; then
      exit 0
    fi
    ;;

  " tmux")
    if tmux_menu; then
      exit 0
    fi
    ;;

  "󰐥 Alimentation")
    "$HOME/.config/sway/scripts/power-menu.sh"
    exit 0
    ;;

  "")
    exit 0
    ;;
  esac
done
