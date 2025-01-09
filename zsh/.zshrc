export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME=~/.config
export ZSH=$ZDOTDIR/ohmyzsh

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode reminder

DISABLE_AUTO_TITLE="true"

plugins=(
    git
    docker
    docker-compose
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias dot="cd ~/.dotfiles"
alias vi=nvim
alias lg=lazygit

export EDITOR=nvim

# Go
GOPATH=/usr/local/go/bin
export PATH=$PATH:$GOPATH

# NVM
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
