# My dotfiles

My system configuration.

## Requirements

Ensure the following packages are installed:

```bash
sudo pacman -S git \
  stow \
  alacritty \
  zsh \
  fd \
  ripgrep \
  fzf \
  helix \
  tmux \
  yazi \
  lazygit \
  wl-clipboard \
  bash-language-server \
  yaml-language-server \
  typescript-language-server \
  marksman \
  taplo-cli \
  python-sqlparse
```

## Instructions

### Setup dotfiles

1. Clone the dotfiles into `$HOME` directory.

```bash
git clone git@github.com:ilovescreammovies/dotfiles.git $HOME/dotfiles
```

2. Run Stow in simulation mode, then check and fix possible conflicts.

```bash
cd $HOME/dotfiles && stow --simulate -v .
```

3. Create the symlinks using GNU Stow.

```bash
stow -v .
```

4. Reload or source the shell.

### Dependencies installation

#### zsh

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

4. Vi mode:

```bash
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode
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
GO_VERSION="<desired_version>"
GO_SOURCE_FILENAME="go$GO_VERSION.linux-amd64.tar.gz"
GO_SOURCE="https://dl.google.com/go/$GO_SOURCE_FILENAME"
curl --output-dir /tmp -O $GO_SOURCE && \
sudo tar -C /usr/local -xzf "/tmp/$GO_SOURCE_FILENAME"
```

- NVM

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

- Node

```bash
nvm install node
```

2. Language servers and debuggers:

```bash
go install golang.org/x/tools/gopls@latest && \
go install github.com/go-delve/delve/cmd/dlv@latest && \
go install github.com/nametake/golangci-lint-langserver@latest
```

3. Formatters and other tools:

```bash
npm install -g prettier && \
go install mvdan.cc/gofumpt@latest && \
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
```
