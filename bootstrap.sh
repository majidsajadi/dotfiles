#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
VSCODE_DIR="$HOME/Library/Application Support/Code/User"

NONINTERACTIVE=1 brew bundle --file="$DOTFILES_DIR/Brewfile" --no-upgrade --verbose --no-lock

links=(
  "$DOTFILES_DIR/.zshrc:$HOME/.zshrc"
  "$DOTFILES_DIR/.zprofile:$HOME/.zprofile"
  "$DOTFILES_DIR/.zshenv:$HOME/.zshenv"
  "$DOTFILES_DIR/.aliases:$HOME/.aliases"
  "$DOTFILES_DIR/.gitconfig:$HOME/.gitconfig"
  "$DOTFILES_DIR/.gitignore:$HOME/.gitignore"
  "$DOTFILES_DIR/.editorconfig:$HOME/.editorconfig"
  "$DOTFILES_DIR/.config/nvim:$HOME/.config/nvim"
  "$DOTFILES_DIR/.config/ghostty:$HOME/.config/ghostty"
  "$DOTFILES_DIR/.config/mise:$HOME/.config/mise"
  "$DOTFILES_DIR/settings.json:$VSCODE_DIR/settings.json"
)

for entry in "${links[@]}"; do
  source="${entry%%:*}"
  target="${entry##*:}"

  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "$target.bac"
  fi

  mkdir -p "$(dirname "$target")"
  ln -sfn "$source" "$target"
done

mise install --yes
