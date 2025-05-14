export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export ZSH="$ZDOTDIR/ohmyzsh"

ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE=true
zstyle ':omz:update' mode reminder

plugins=(
        git
        zsh-autosuggestions
        fast-syntax-highlighting
        zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

alias dot="cd ~/dotfiles"
alias hx="helix"
alias zshconfig="hx ~/dotfiles/zsh/.zshrc"
alias alacrittyconfig="hx ~/dotfiles/alacritty/alacritty.toml"
alias tmuxconfig="hx ~/dotfiles/tmux/tmux.conf"
alias lzg="lazygit"
alias lzd="lazydocker"

export EDITOR=helix

export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
GOROOT="/usr/local/go"
GOPATH="$HOME/go"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
