```bash
# dotfiles including configs for variuse tools such as `zsh`, `nvim`, `alacritty`, `vscode`.
# Use at your own risk.

# Clone the repository
git clone https://github.com/majidsajadi/dotfiles.git ~/dotfiles

cd ~/dotfiles

# Bundle Brewfile
brew bundle --file="./Brewfile"

# Symlink dotfiles
./bootstrap.sh
```
