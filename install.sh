#!/usr/bin/env bash

# 1. Variable and OS detection
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
case "$(uname -s)" in
Darwin)
  # This is macOS
  echo "Setting up platform-specific dotfiles for macOS..."

  # Check for and install essential dependencies
  echo " - Checking for dependencies..."
  if ! command -v git &>/dev/null; then
    echo " - Git not found. Installing now..."
    brew install git
  fi
  if ! command -v reattach-to-user-namespace &>/dev/null; then
    echo " - reattach-to-user-namespace not found. Installing now..."
    brew install reattach-to-user-namespace
  fi
  if ! command -v eza &>/dev/null; then
    echo " - Eza not found. Installing now..."
    brew install eza
  fi
  if ! command -v zoxide &>/dev/null; then
    echo " - Zoxide not found. Installing now..."
    brew install zoxide
  fi
  if ! command -v fastfetch &>/dev/null; then
    echo " - Fastfetch not found. Installing now..."
    brew install fastfetch
  fi
  if ! command -v zsh-syntax-highlighting &>/dev/null; then
    echo " - ZSH Syntax Highlighting not found. Installing now..."
    brew install zsh-syntax-highlighting
  fi
  if ! command -v starship &>/dev/null; then
    echo " - Starship not found. Installing now..."
    brew install starship
  fi

  # Add macOS specific git configuration here
  echo " - Configuring git credentials and user info..."

  git config --global user.name "Kai"
  git config --global user.email "kai.conragan@gmail.com"

  # Conditionally set the credential helper for GitHub only if not already set
  if ! git config --global --get credential.https://github.com.helper >/dev/null; then
    git config --global credential.https://github.com.helper "osxkeychain"
  fi

  if [ -f "$DOTFILES_DIR/common/zsh/.zshrc" ]; then
    echo " - Symlinking .zshrc"
    ln -sf "$DOTFILES_DIR/common/zsh/.zshrc" ~/.zshrc
  fi

  # Symlink platform-specific tmux override
  echo " - Symlinking platform-specific tmux override config"
  ln -sf "$DOTFILES_DIR/mac/tmux/tmux.conf" ~/.tmux.conf.local

  # Symlink platform-specific Ghostty config
  echo " - Symlinking platform-specific Ghostty config"
  mkdir -p ~/.config/ghostty
  ln -sf "$DOTFILES_DIR/mac/ghostty/config" ~/.config/ghostty/config
  ;;

Linux)
  # This is Linux
  echo "Setting up platform-specific dotfiles for Linux..."

  # Check for and install essential dependencies
  echo " - Checking for dependencies..."
  if ! command -v git &>/dev/null; then
    echo " - Git not found. Installing now..."
    sudo pacman -S git --noconfirm
  fi
  if ! command -v starship &>/dev/null; then
    echo " - Starship not found. Installing now..."
    sudo pacman -S starship --noconfirm
  fi

  # Add Linux specific git configuration here
  echo " - Configuring git credentials and user info..."

  git config --global user.name "Kai"
  git config --global user.email "kai.conragan@gmail.com"

  # Conditionally set the credential helper for GitHub only if not already set
  if ! git config --global --get credential.https://github.com.helper >/dev/null; then
    git config --global credential.https://github.com.helper "/usr/bin/gh auth git-credential"
  fi

  if [ -f "$DOTFILES_DIR/linux/.bashrc" ]; then
    echo " - Symlinking platform-specific .bashrc"
    ln -sf "$DOTFILES_DIR/linux/.bashrc" ~/.bashrc
  fi

  # Symlink platform-specific tmux override
  echo " - Symlinking platform-specific tmux override config"
  ln -sf "$DOTFILES_DIR/linux/tmux/tmux.conf" ~/.tmux.conf.local

  # Symlink platform-specific Ghostty config
  echo " - Symlinking platform-specific Ghostty config"
  mkdir -p ~/.config/ghostty
  ln -sf "$DOTFILES_DIR/linux/ghostty/config" ~/.config/ghostty/config
  ;;

*)
  echo "Unsupported OS. Exiting."
  exit 1
  ;;
esac

# 2. Install common and platform-specific dotfiles
echo "Installing common dotfiles..."

# Symlink gitconfig
echo " - Setting up git..."
ln -sf "$DOTFILES_DIR/common/.gitconfig" ~/.gitconfig

# Symlink main tmux config
echo " - Setting up tmux..."
ln -sf "$DOTFILES_DIR/common/tmux/.tmux.conf" ~/.tmux.conf

# Symlink Starship configuration
echo " - Setting up Starship..."
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/common/starship/starship.toml" ~/.config/starship.toml

# Install Tmux Plugin Manager if it doesn't exist
if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo " - Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
