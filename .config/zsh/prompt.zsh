# Allow prompt variables to be expanded when the prompt is displayed.
setopt prompt_subst

# Collect version-control information for the current directory.
autoload -Uz vcs_info

# Refresh version-control information before displaying each prompt.
precmd() {
  vcs_info
}

# Limit version-control detection to Git repositories.
zstyle ':vcs_info:*' enable git

# Detect staged and unstaged Git changes.
zstyle ':vcs_info:*' check-for-changes true

# Show the branch and working-tree state in Git repositories.
zstyle ':vcs_info:git*' formats ' %b%c%u'

# Show the active Git operation alongside the branch.
zstyle ':vcs_info:git*' actionformats ' %b:%a%c%u'

# Mark repositories with staged changes.
zstyle ':vcs_info:git*' stagedstr ' +'

# Mark repositories with unstaged changes.
zstyle ':vcs_info:git*' unstagedstr ' !'

# Extend Git status detection to untracked files.
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
    hook_com[unstaged]+=' ?'
  fi
}

# Show the directory, Git state, and privilege-aware prompt character.
PROMPT='%F{cyan}%3~%f%F{yellow}${vcs_info_msg_0_}%f %(!.#.$) '