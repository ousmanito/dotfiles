#!/usr/bin/env bash

set -euo pipefail

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

selection="$(
  swaymsg -t get_tree |
    jq -r '
  .. | objects
  | select(.type == "workspace")
  | (if .name == "__i3_scratch" then "scratch" else .name end) as $ws
  | recurse(.nodes[]?, .floating_nodes[]?)
  | select(
      (.type == "con" or .type == "floating_con")
      and (.app_id != null or .window_properties != null)
    )
  | "\($ws)\t\(.app_id // .window_properties.class // "inconnu")\t\(.name // "Sans titre")\t\(.id)"
' |
    fuzzel --dmenu \
      --config="$FUZZEL_CONFIG" \
      --prompt='Fenêtres> ' \
      --with-nth='[{1}] {2} — {3}' \
      --accept-nth=4 \
      --only-match
)"

[ -n "$selection" ] || exit 0

swaymsg "[con_id=$selection] focus"
