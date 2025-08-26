# History setup
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=5000
SAVEHIST=5000

setopt extendedglob nomatch notify
unsetopt autocd
bindkey -v

# Completion system setup
zstyle :compinstall filename '/home/goofytux/.config/zsh/.zshrc'
autoload -Uz compinit
compinit

# Path variable setup
typeset -U path
path=(
	/bin
	/usr/bin
	/usr/local/bin
	~/go/bin
)

# Source installed plugins
shared_plugins=/usr/share/zsh/plugins
source $shared_plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $shared_plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $shared_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Aliases
alias hx="helix"
alias lg="lazygit"
alias ld="lazydocker"
alias lj="lazyjournal"
alias ls="ls --color=auto"
alias grep="rg --color=auto"
alias top="top -E g -e g"
alias mkdir="mkdir -p"

# Variables
export EDITOR=helix

# Prompt
export PS1="%F{green}%n%f@%F{magenta}%m%f %# "
export RPS1="%F{cyan}%c%f%b"
export PS2="%_ > "

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

# Automatically open a tmux session or attach to the main one
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	tmux -2 new-session -A -s main
fi
