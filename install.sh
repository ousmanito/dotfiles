#!/usr/bin/env bash

set -Eeuo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link_path() {
  local source="$1"
  local target="$2"

  if [[ ! -e "$source" && ! -L "$source" ]]; then
    echo "Missing source, skipping: $source"
    return
  fi

  mkdir -p "$(dirname "$target")"

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    echo "Already linked: $target"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/"
    echo "Backed up: $target"
  fi

  ln -s "$source" "$target"
  echo "Linked: $target -> $source"
}

echo "Installing dotfiles from:"
echo "  $DOTFILES_DIR"
echo

# XDG configuration directories
link_path \
  "$DOTFILES_DIR/alacritty" \
  "$HOME/.config/alacritty"

link_path \
  "$DOTFILES_DIR/mako" \
  "$HOME/.config/mako"

link_path \
  "$DOTFILES_DIR/neovim" \
  "$HOME/.config/nvim"

link_path \
  "$DOTFILES_DIR/sway" \
  "$HOME/.config/sway"

link_path \
  "$DOTFILES_DIR/waybar" \
  "$HOME/.config/waybar"

link_path \
  "$DOTFILES_DIR/fuzzel" \
  "$HOME/.config/fuzzel"

# Shell and terminal configuration
link_path \
  "$DOTFILES_DIR/tmux/.tmux.conf" \
  "$HOME/.tmux.conf"

link_path \
  "$DOTFILES_DIR/zsh/.zshrc" \
  "$HOME/.zshrc"

# Tmuxinator projects
link_path \
  "$DOTFILES_DIR/tmuxinator" \
  "$HOME/.config/tmuxinator"

# Claude CLAUDE.md file
link_path \
  "$DOTFILES_DIR/llm/AGENTS.md" \
  "$HOME/.claude/CLAUDE.md"

# Codex AGENTS.md file
link_path \
  "$DOTFILES_DIR/llm/AGENTS.md" \
  "$HOME/.codex/AGENTS.md"

# LLM prompts for nvim CodeCompanion
link_path \
  "$DOTFILES_DIR/llm/prompts" \
  "$HOME/dev/prompts"

# Oh My Zsh custom content
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  link_path \
    "$DOTFILES_DIR/oh-my-zsh/custom" \
    "$HOME/.oh-my-zsh/custom"

  link_path \
    "$DOTFILES_DIR/oh-my-zsh/themes" \
    "$HOME/.oh-my-zsh/themes"

  link_path \
    "$DOTFILES_DIR/oh-my-zsh/completions" \
    "$HOME/.oh-my-zsh/completions"
else
  echo "Oh My Zsh is not installed; skipping Oh My Zsh links"
fi

# Fonts
link_path \
  "$DOTFILES_DIR/fonts" \
  "$HOME/.local/share/fonts/dotfiles"

# Refresh the font cache
if command -v fc-cache >/dev/null 2>&1; then
  fc-cache -f "$HOME/.local/share/fonts/dotfiles"
  echo "Font cache refreshed"
fi

echo

if [[ -d "$BACKUP_DIR" ]]; then
  echo "Existing files were backed up to:"
  echo "  $BACKUP_DIR"
fi

echo "Dotfiles installation complete."
