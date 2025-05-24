export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
export ZSH="$ZDOTDIR/ohmyzsh"
export EDITOR=helix

ZSH_THEME="muse"
DISABLE_AUTO_TITLE=true
zstyle ':omz:update' mode reminder

plugins=(
        git
        colored-man-pages
        fast-syntax-highlighting
        zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

alias lzg="lazygit"
alias lzd="lazydocker"

# NVM
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Go
GOROOT="/usr/local/go"
GOPATH="$HOME/go"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
