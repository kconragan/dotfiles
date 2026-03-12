# Gemini Project Context: Kai's Dotfiles

This repository contains personal configuration files (`dotfiles`) for **macOS** and **Arch Linux**, designed for a unified and automated terminal experience.

## Project Overview

- **Purpose:** Provides a consistent, beautiful, and productive environment across different operating systems.
- **Core Philosophy:** Automation via a single idempotent script (`install.sh`) and modular configuration.
- **Primary Platforms:** macOS (Darwin) and Arch Linux.
- **Key Technologies:**
    - **Shell:** Zsh (macOS), Bash (Linux/Omarchy).
    - **Editor:** Neovim (LazyVim distribution).
    - **Terminal:** Ghostty.
    - **Multiplexer:** Tmux (with TPM).
    - **Desktop Environment:** Hyprland (Arch Linux only).
    - **Utilities:** `zoxide`, `eza`, `starship`, `oh-my-posh`, `pyenv`, `thefuck`.

## Repository Structure

- `common/`: Shared configurations for all platforms.
    - `nvim/`: LazyVim-based Neovim setup.
    - `tmux/`: Core Tmux configuration (`.tmux.conf`).
    - `zsh/`: Shared Zsh configuration (`.zshrc`).
    - `starship/`: Starship prompt configuration.
    - `.gitconfig`: Global Git settings.
- `mac/`: macOS-specific overrides and tools.
    - `ghostty/`: macOS-specific Ghostty config.
    - `tmux/`: macOS-specific Tmux overrides (`tmux.conf.local`).
    - `raycast/`: Raycast extensions and settings.
- `linux/`: Arch Linux-specific overrides (targeted for Omarchy).
    - `hypr/`: Hyprland and Wayland-related configurations.
    - `ghostty/`: Linux-specific Ghostty config.
    - `tmux/`: Linux-specific Tmux overrides.
    - `.bashrc`: Linux-specific Bash configuration.

## Installation & Setup

The `install.sh` script automates dependency installation and symlinking.

```bash
./install.sh
```

### Critical Post-Installation Steps
- **Tmux:** Start `tmux` and press `Ctrl+l` then `I` (capital I) to install plugins via Tmux Plugin Manager (TPM).

## Development Conventions

### Neovim (LazyVim)
- **Entrypoint:** `common/nvim/lua/config/lazy.lua`.
- **Customization:** Add or override plugins in `common/nvim/lua/plugins/`.
- **Options/Keymaps:** Defined in `common/nvim/lua/config/options.lua` and `common/nvim/lua/config/keymaps.lua`.
- **Theme Logic:** `common/nvim/lua/plugins/theme.lua` handles dynamic theme switching (Linux/Omarchy vs macOS).
- **Notable Plugins:**
    - `opencode.nvim`: AI assistant (keymaps under `<leader>o`).
    - `snacks.nvim`: UI enhancements (scroll animations disabled).

### Shell Configuration (macOS/Zsh)
- **Load Order:** Pyenv -> Zoxide -> Oh My Posh -> TheFuck -> Autosuggestions -> Syntax Highlighting (Must be last).
- **Aliases:** `vim` -> `nvim`, `cd` -> `z` (zoxide), `ls` variants use `eza`.

### Git Configuration
- **Automation:** `install.sh` sets `user.name` and `user.email` at runtime.
- **Authentication:** Uses `osxkeychain` on macOS and `gh auth git-credential` on Linux.
- **Behavior:** `pull.rebase` is set to `true` by default.

## Maintenance & Updates

- The `install.sh` script is idempotent; it is safe to re-run to sync changes or ensure dependencies are met.
- When adding new configuration files, ensure they are added to the appropriate `common/`, `mac/`, or `linux/` directory and updated in `install.sh` if a new symlink is required.
