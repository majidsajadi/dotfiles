# Add Homebrew commands and directories to the shell environment.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Make PostgreSQL 17 commands available.
export PATH="${HOMEBREW_PREFIX}/opt/postgresql@17/bin:${PATH}"

# Hide Homebrew environment hints.
export HOMEBREW_NO_ENV_HINTS=1