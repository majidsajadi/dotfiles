DOTFILES_DIR="${HOME}/dotfiles"
WORKSPACE_DIR="${HOME}/workspace"

export EDITOR=nvim
export VISUAL="$EDITOR"
export BROWSER=safari

HISTFILE="${HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

autoload -Uz vcs_info
setopt prompt_subst

precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats ' %b%c%u'
zstyle ':vcs_info:git*' actionformats ' %b(%a)%c%u'
zstyle ':vcs_info:git*' stagedstr   ' A'
zstyle ':vcs_info:git*' unstagedstr ' M'

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
    hook_com[unstaged]+=' U'
  fi
}

PROMPT='%F{cyan}%3~%f%F{yellow}${vcs_info_msg_0_}%f %(!.#.$) '

autoload -Uz compinit
compinit -C

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^R'   history-incremental-search-backward

eval "$(mise activate zsh)"

[ -f "${HOME}/.aliases" ] && source "${HOME}/.aliases"

[ -z "$ZSH_NOLOGIN" ] && touch ~/.hushlogin
