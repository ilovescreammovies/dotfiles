#!/usr/bin/env bash

ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux ~/.config/tmux
ln -sf ~/dotfiles/alacritty ~/.config/alacritty
ln -sf ~/dotfiles/zsh ~/.config/zsh

mkdir -p ~/.ssh
ln -sf ~/dotfiles/ssh/config ~/.ssh/config
