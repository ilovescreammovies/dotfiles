# Local installed plugins
SHARED_PLUGINS=/usr/share/zsh/plugins
source $SHARED_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $SHARED_PLUGINS/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $SHARED_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Aliases
alias hx="helix"
alias lg="lazygit"
alias ld="lazydocker"
alias lj="lazyjournal"
alias ls="ls --color=auto"
alias grep="rg --color=auto"
alias top="top -E g -e g"

# Environment variables
export PS1="%F{green}%n%f@%F{magenta}%m%f:%B%F{cyan}%c%f%b %# "
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

if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	tmux -2 new-session -A -s main
fi
