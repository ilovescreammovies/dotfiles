# My dotfiles

My system configuration.

## Requirements

Ensure the following packages are installed:

```bash
sudo pacman -S git stow alacritty zsh fd ripgrep fzf helix tmux yazi
```

## Installation

1. Clone the dotfiles into `$HOME` directory.

```bash
git clone git@github.com:ilovescreammovies/dotfiles.git $HOME/dotfiles
```

2. Create the symlinks using GNU Stow.

```bash
cd $HOME/dotfiles && stow .
```

3. Reload or source the shell.

4. Install dependencies:

- **zsh**
  1. Plugin manager:
  ```bash
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```
  2. Syntax highlighting:
  ```bash
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
    $ZSH_CUSTOM/plugins/fast-syntax-highlighting
  ```
  3. Autocompletion:
  ```bash
  git clone https://github.com/marlonrichert/zsh-autocomplete.git \
    $ZSH_CUSTOM/plugins/zsh-autocomplete
  ```
- **tmux**
  1. Plugin manager:
  ```bash
  git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
  ```
