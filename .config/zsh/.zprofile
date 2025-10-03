#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Display manager
#
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec sway --unsupported-gpu
fi

#
# Editors
#

if [[ -z "$EDITOR" ]]; then
	export EDITOR='helix'
fi
if [[ -z "$VISUAL" ]]; then
	export VISUAL='helix'
fi
if [[ -z "$PAGER" ]]; then
	export PAGER='less'
fi

#
# Language
#

if [[ -z "$LANG" ]]; then
	export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
	/usr/local/bin
	$HOME/.local/bin
	/usr/local/go/bin
	$HOME/go/bin
	$path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
if [[ -z "$LESS" ]]; then
	export LESS='-g -i -M -R -S -w -X -z-4'
fi

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]]; then
	export LESSOPEN="| /usr/bin/env lesspipe.sh %s"
fi
