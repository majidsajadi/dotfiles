#!/usr/bin/env bash

# Exit on errors, undefined variables, and failed pipelines.
set -euo pipefail

# Define the source directory for managed configuration.
DOTFILES_DIR="${HOME}/dotfiles"

# Define the VS Code user configuration directory.
VSCODE_DIR="${HOME}/Library/Application Support/Code/User"

# Install missing Homebrew packages without upgrading installed packages.
brew bundle \
  --file="${DOTFILES_DIR}/Brewfile" \
  --no-upgrade

# Map managed files to their expected locations.
links=(
  "${DOTFILES_DIR}/.zshrc:${HOME}/.zshrc"
  "${DOTFILES_DIR}/.zprofile:${HOME}/.zprofile"
  "${DOTFILES_DIR}/.zshenv:${HOME}/.zshenv"
  "${DOTFILES_DIR}/.aliases:${HOME}/.aliases"
  "${DOTFILES_DIR}/.gitconfig:${HOME}/.gitconfig"
  "${DOTFILES_DIR}/.config/git/ignore:${HOME}/.config/git/ignore"
  "${DOTFILES_DIR}/.tmux.conf:${HOME}/.tmux.conf"
  "${DOTFILES_DIR}/.editorconfig:${HOME}/.editorconfig"
  "${DOTFILES_DIR}/.config/nvim:${HOME}/.config/nvim"
  "${DOTFILES_DIR}/.config/ghostty:${HOME}/.config/ghostty"
  "${DOTFILES_DIR}/.config/mise:${HOME}/.config/mise"
)

for entry in "${links[@]}"; do
  source_path="${entry%%:*}"
  target_path="${entry##*:}"

  # Reject missing sources instead of creating broken links.
  if [[ ! -e "${source_path}" ]]; then
    printf 'Missing source: %s\n' "${source_path}" >&2
    exit 1
  fi

  # Replace the previous backup before moving an existing target.
  if [[ -e "${target_path}" || -L "${target_path}" ]]; then
    rm -rf "${target_path}.bak"
    mv "${target_path}" "${target_path}.bak"
  fi

  # Create the target directory before linking the source.
  mkdir -p "$(dirname "${target_path}")"

  # Link the managed configuration into its expected location.
  ln -s "${source_path}" "${target_path}"
done

# Install the development tools declared in the mise configuration.
mise install --yes

# Suppress the macOS login message in new terminal sessions.
touch "${HOME}/.hushlogin"