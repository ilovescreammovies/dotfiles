export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME=~/.config
export ZSH="$ZDOTDIR/ohmyzsh"

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

alias dot="cd ~/dotfiles"
alias wor="cd ~/Work"
alias vi=nvim
alias lg=lazygit

export EDITOR=nvim

# Go
export PATH=$PATH:/usr/local/go/bin

# NVM
export NVM_DIR=$XDG_CONFIG_HOME/nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# SSH configuration
function check_ssh_agent() {
    if [[ -z $SSH_AGENT_PID ]]; then
        return 2
    fi
    ssh-add -l &>/dev/null
    return $?
}

case $(check_ssh_agent; echo $?) in
    0)
        echo "SSH keys are already loaded."
        ;;
    1)
        echo "No keys present, adding keys..."
        ssh-add ~/.ssh/{personal,company}
        ;;
    2)
        echo "Starting ssh-agent and adding keys..."
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/{personal,company}
        ;;
esac
