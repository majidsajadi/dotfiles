# ===============================
# General Configuration
# ===============================

# Paths to key directories
DOTFILES_DIR="${HOME}/dotfiles"
WORKSPACE_DIR="${HOME}/workspace"

# Enable colored output for tools like `ls`
export CLICOLOR=1

# Set default editor and browser
export BROWSER=safari
export VISUAL=nvim
export EDITOR=$VISUAL

# ===============================
# Prompt and VCS Configuration
# ===============================

# Enable VCS (Version Control System) information in the prompt
autoload -Uz vcs_info

# Allow prompt commands to be evaluated dynamically
setopt prompt_subst

# Hook to update VCS info before each prompt
precmd() { vcs_info }

# Enable only Git support for VCS info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats ' %b%c%u'
zstyle ':vcs_info:git*' actionformats ' %b(%a)%c%u'
zstyle ':vcs_info:git*' stagedstr '%F{blue}A'
zstyle ':vcs_info:git*' unstagedstr '%F{yellow}M'

# Add a hook to display untracked files
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -q '^?? ' 2> /dev/null; then
        hook_com[staged]+='%F{red}U'
    fi
}

# Check changes in subdirectories under DOTFILES_DIR and WORKSPACE_DIR
zstyle -e ':vcs_info:git:*' \
    check-for-changes 'estyle-cfc && reply=( true ) || reply=( false )'

function estyle-cfc() {
    local d
    local -a cfc_dirs
    cfc_dirs=(
        ${WORKSPACE_DIR}/*(/)  # All subdirectories in workspace
        ${DOTFILES_DIR}(/)     # Dotfiles directory
    )

    for d in ${cfc_dirs}; do
        d=${d%/##}
        [[ $PWD == $d(|/*) ]] && return 0
    done
    return 1
}

# Configure the shell prompt
PROMPT='%F{cyan}%3~%F{yellow}${vcs_info_msg_0_} %F{default}%(#:#:$) '

# ===============================
# History Configuration
# ===============================

# File and size limits for history
HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096

# History behavior settings
setopt HIST_IGNORE_ALL_DUPS  # Remove earlier duplicates of a command
setopt HIST_REDUCE_BLANKS    # Remove extra blanks from commands
setopt HIST_FIND_NO_DUPS     # Avoid duplicates in history search
setopt HIST_SAVE_NO_DUPS     # Do not save duplicate entries to the history file

# ===============================
# Zsh Completion Configuration
# ===============================

# Enable the Zsh completion system
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Enable menu-based completion
zstyle ':completion:*' menu select

# ===============================
# Plugins and Key Bindings
# ===============================

# Load Zsh plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Configure key bindings for history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^R' history-incremental-search-backward

# Load color definitions
autoload -U colors
colors

# Set Vim-like keybindings in Zsh
# bindkey -v

# ===============================
# Aliases
# ===============================

# Aliases for Neovim
alias vi="nvim"
alias vim="nvim"

