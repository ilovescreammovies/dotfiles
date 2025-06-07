# Oh My Zsh
export ZSH=$ZDOTDIR/ohmyzsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE=true
zstyle ':omz:update' mode reminder
source $ZSH/oh-my-zsh.sh

# Local installed plugins
SHARED_PLUGINS=/usr/share/zsh/plugins
source $SHARED_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $SHARED_PLUGINS/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $SHARED_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Aliases
alias hx="helix"
alias lg="lazygit"
alias ld="lazydocker"
alias ls="ls --color=auto"
alias grep="rg --color=auto"

# User environment variables
export PATH=$HOME/go/bin:$PATH
export EDITOR=helix

# NVM
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Exit to the current working directory after closing Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd <"$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd" || return
	rm -f -- "$tmp"
}
