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
  if ! command -v nvim &>/dev/null; then
    echo " - Neovim not found. Installing now..."
    brew install neovim
  fi

  # Add macOS specific git configuration here
  echo " - Configuring git credentials and user info..."
  git config --global user.name "Kai"
  git config --global user.email "kai.conragan@gmail.com"
  git config --global credential.https://github.com.helper "osxkeychain"

  if [ -f "$DOTFILES_DIR/common/.zshrc" ]; then
    echo " - Symlinking .zshrc"
    ln -sf "$DOTFILES_DIR/common/.zshrc" ~/.zshrc
  fi
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
  if ! command -v nvim &>/dev/null; then
    echo " - Neovim not found. Installing now..."
    sudo pacman -S neovim --noconfirm
  fi

  # Add Linux specific git configuration here
  echo " - Configuring git credentials and user info..."
  git config --global user.name "Kai"
  git config --global user.email "kai.conragan@gmail.com"
  git config --global credential.https://github.com.helper "/usr/bin/gh auth git-credential"

  if [ -f "$DOTFILES_DIR/linux/.vimrc" ]; then
    echo " - Symlinking platform-specific .vimrc"
    ln -sf "$DOTFILES_DIR/linux/.vimrc" ~/.vimrc
  fi
  ;;

*)
  echo "Unsupported OS. Exiting."
  exit 1
  ;;
esac

# 2. Install common and platform-specific dotfiles
echo "Installing common dotfiles..."

# Symlink Neovim configuration
echo " - Setting up Neovim..."
ln -sf "$DOTFILES_DIR/common/nvim" ~/.config/nvim

# Symlink gitconfig
echo " - Setting up git..."
ln -sf "$DOTFILES_DIR/common/.gitconfig" ~/.gitconfig

# Link tmux config
echo " - Setting up tmux..."
ln -sf "$DOTFILES_DIR/common/.tmux.conf" ~/.tmux.conf
