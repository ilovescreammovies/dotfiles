# My dotfiles

My system configuration.

## Requirements

Ensure the following packages are installed

```bash
pacman -S git stow zsh alacritty helix tmux yazi
```

## Installation

Clone the dotfiles repository in the `$HOME` directory

```bash
git clone git@github.com:ilovescreammovies/dotfiles.git $HOME/dotfiles
```

Create the symlinks using GNU Stow

```bash
cd $HOME/dotfiles
stow .
```
