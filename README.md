# My dotfiles

My system configuration.

## Requirements

1. Clone the dotfiles into the `$HOME` directory and `cd` into it.

```bash
git clone git@github.com:ilovescreammovies/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
```

2. Ensure that the following packages are installed locally:

### Pacman

1. Install packages.

```bash
sudo pacman -S --needed - < pacman.txt
```

### Yay

1. Install yay binary.

```bash
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
```

2. Generate development package DB.

```bash
yay -Y --gendb
yay -Syu --devel
yay -Y --devel --save
```

3. Install AUR packages.

```bash
yay -S --needed - < aur.txt
```

## Instructions

### Setup dotfiles

1. Run Stow in simulation mode to check for possible conflicts. If any are found, fix them before proceeding.

```bash
cd $HOME/dotfiles
stow --simulate -v .
```

2. Use GNU Stow to create the symlinks.

```bash
stow -v .
```

3. Reload or source the shell.

### Dependencies installation

#### zsh

1. Plugin manager:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### tmux

1. Plugin manager:

```bash
git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
```

#### helix

1. Language binaries:

- Go

```bash
GO_VERSION="1.24.4"
GO_SOURCE_FILENAME="go$GO_VERSION.linux-amd64.tar.gz"
GO_SOURCE="https://dl.google.com/go/$GO_SOURCE_FILENAME"
curl --output-dir /tmp -O $GO_SOURCE && \
sudo rm -rf /usr/local/go; sudo tar -C /usr/local -xzf "/tmp/$GO_SOURCE_FILENAME"
```

- NVM

```bash
NVM_VERSION=v0.40.3
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash
```

Reload the shell.

- Node

```bash
nvm install node
```

2. Language Servers and Debuggers:

```bash
go install golang.org/x/tools/gopls@latest && \
go install github.com/go-delve/delve/cmd/dlv@latest && \
go install github.com/nametake/golangci-lint-langserver@latest && \
npm install -g dockerfile-language-server-nodejs@latest \
@microsoft/compose-language-service@latest
```

3. Formatters and other tools:

```bash
npm install -g prettier && \
go install mvdan.cc/gofumpt@latest && \
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
```
