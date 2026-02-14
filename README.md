# My dotfiles

My system configuration.

## Requirements

Clone the dotfiles into the `$HOME` directory and `cd` into it.

```bash
git clone git@github.com:ilovescreammovies/dotfiles.git $HOME/dotfiles && \
cd $HOME/dotfiles
```

## Instructions

### Setup dotfiles

Run Stow in simulation mode to check for possible conflicts. If any are found, fix them before proceeding.

```bash
cd $HOME/dotfiles
stow --simulate -v .
```

Use Stow to create the symlinks.

```bash
stow -v .
```

Reload or source the shell.

### Dependencies installation

- **zsh**

```bash
sudo pacman -Sy zsh-autosuggestions zsh-autocomplete zsh-syntax-highlighting
```

- **tmux**

Install plugin manager.

```bash
git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
```

Install TUI tools.

```bash
sudo pacman -Sy lazygit lazydocker
```

- **helix**

Download and setup Go language support.

```bash
GO_VERSION="1.25.0"
GO_SOURCE_FILENAME="go$GO_VERSION.linux-amd64.tar.gz"
GO_SOURCE="https://dl.google.com/go/$GO_SOURCE_FILENAME"
curl --output-dir /tmp -O $GO_SOURCE && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "/tmp/$GO_SOURCE_FILENAME"
```

Download and setup NVM.

```bash
NVM_VERSION=v0.40.3
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash
```

Reload the shell.

```bash
exec zsh
```

Install the latest version of node.

```bash
nvm install node
```

Install language servers, debuggers, formatters and other tools.

```bash
sudo pacman -Sy \
  yaml-language-server \
  bash-language-server \
  typescript-language-server \
  marksman \
  vscode-css-languageserver \
  vscode-html-languageserver \
  vscode-json-languageserver \
  pgformatter \
  taplo-cli
```

```bash
go install golang.org/x/tools/gopls@latest && \
go install github.com/go-delve/delve/cmd/dlv@latest && \
go install mvdan.cc/gofumpt@latest && \
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest && \
go install github.com/nametake/golangci-lint-langserver@latest && \
npm install -g \
  dockerfile-language-server-nodejs@latest \
  @microsoft/compose-language-service@latest \
  @postgrestools/postgrestools@latest \
  @biomejs/biome@latest
```
