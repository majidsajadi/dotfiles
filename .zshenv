# Define standard locations for user configuration and data.
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"

# Make user-installed commands available.
export PATH="${HOME}/.local/bin:${PATH}"

# Define common personal directories.
export DOTFILES_DIR="${HOME}/dotfiles"
export WORKSPACE_DIR="${HOME}/workspace"

# Use Neovim for terminal-based editing.
export EDITOR="nvim"
export VISUAL="${EDITOR}"

# Open links with Safari by default.
export BROWSER="safari"

# Trust mise configuration stored in the dotfiles repository.
export MISE_TRUSTED_CONFIG_PATHS="${DOTFILES_DIR}"