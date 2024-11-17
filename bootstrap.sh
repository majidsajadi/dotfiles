#!/usr/bin/env bash
set -e

# Configuration
DOTFILES_DIR=~/dotfiles
VSCODE_DIR="$HOME/Library/Application Support/Code/User"

# Ensure Homebrew is installed
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Run BrewFile (commented out as in original)
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

# Function to create symlink with backup
create_symlink() {
  local source=$1
  local target=$2

  # Create target directory if it doesn't exist
  target_dir=$(dirname "$target")
  if [ ! -d "$target_dir" ]; then
    echo "Creating directory: $target_dir"
    mkdir -p "$target_dir"
  fi

  # Check if source file exists
  if [ ! -e "$source" ]; then
    echo "SKIP: $source"
    return
  fi

  # Handle existing files/symlinks
  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
      echo "SKIP: $target"
      return
    else
      echo "REPLACE: $target to $target.backup"
      mv "$target" "$target.backup"
    fi
  fi

  # Create symlink
  echo "CREATE: $source -> $target"
  ln -sf "$source" "$target"
}

create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/.alacritty.toml" "$HOME/.alacritty.toml"
create_symlink "$DOTFILES_DIR/.editorconfig" "$HOME/.editorconfig"
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/.gitignore" "$HOME/.gitignore"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
create_symlink "$DOTFILES_DIR/settings.json" "$VSCODE_DIR/settings.json"
