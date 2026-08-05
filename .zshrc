# Store command history across shell sessions.
HISTFILE="${HOME}/.zsh_history"

# Keep up to 10,000 commands in memory and on disk.
HISTSIZE=10000
SAVEHIST=10000

# Remove older entries when a duplicate command is added.
setopt HIST_IGNORE_ALL_DUPS

# Remove unnecessary whitespace before saving commands.
setopt HIST_REDUCE_BLANKS

# Skip duplicate results during history search.
setopt HIST_FIND_NO_DUPS

# Avoid writing duplicate commands to the history file.
setopt HIST_SAVE_NO_DUPS

# Enable command and argument completion.
autoload -Uz compinit
compinit -C

# Match completion candidates without case sensitivity.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Select completion candidates from an interactive menu.
zstyle ':completion:*' menu select

# Select mise-managed tools for the current directory.
eval "$(mise activate zsh)"

# Show Git information in the shell prompt.
source "${XDG_CONFIG_HOME}/zsh/prompt.zsh"

# Search history using the current command prefix.
source "${HOMEBREW_PREFIX}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"

# Suggest commands from shell history.
source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Highlight valid and invalid shell syntax.
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Search backward for commands matching the current prefix.
bindkey '^[[A' history-substring-search-up

# Search forward for commands matching the current prefix.
bindkey '^[[B' history-substring-search-down

# Search backward through command history interactively.
bindkey '^R' history-incremental-search-backward

# Load personal command aliases when available.
[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"