export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
export ZSH="$ZDOTDIR/ohmyzsh"

ZSH_THEME="muse"
DISABLE_AUTO_TITLE=true
zstyle ':omz:update' mode reminder

plugins=(
        zsh-vi-mode
        git
        colored-man-pages
        fast-syntax-highlighting
        zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

alias hx="helix"
alias lzg="lazygit"
alias lzd="lazydocker"

export EDITOR=helix

# NVM
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Go
GOROOT="/usr/local/go"
GOPATH="$HOME/go"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"

function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d '' cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
}
