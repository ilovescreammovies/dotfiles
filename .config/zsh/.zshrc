export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

setopt extendedglob
setopt HIST_SAVE_NO_DUPS

unsetopt autocd
bindkey -v
export KEYTIMEOUT=1

autoload -U compinit; compinit
_comp_options+=(globdots)
setopt MENU_COMPLETE
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

#
# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true
zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' keep-prefix true
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

## Example: For kubernetes
# source $DOTFILES/zsh/plugins/kubectl-completion/_kubectl
# zstyle ':completion:*:*:kubectl:*' list-grouped false

# Path variable setup
typeset -U path
path+=(
	/bin
	/usr/bin
	/usr/local/bin
	/usr/local/go/bin
	~/go/bin
)

# Source installed plugins
shared_plugins=/usr/share/zsh/plugins
source $shared_plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $shared_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $shared_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
export VISUAL=helix

# Prompt
export PS1="%F{cyan}%c%f%b %# "
export RPS1="%F{green}%n%f@%F{magenta}%m%f"
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
