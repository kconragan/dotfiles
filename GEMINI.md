# Gemini Project Context: Kai's Dotfiles

This repository contains personal configuration files (`dotfiles`) for **macOS** and **Arch Linux**, designed for a unified and automated terminal experience.

## Project Overview

- **Purpose:** Provides a consistent, beautiful, and productive environment across different operating systems.
- **Core Philosophy:** Automation via a single idempotent script (`install.sh`) and modular configuration.
- **Primary Platforms:** macOS (Darwin) and Arch Linux (Omarchy).
- **Key Technologies:**
    - **Shell:** Zsh (Primary for both), Bash (Omarchy core).
    - **Editor:** Neovim (LazyVim distribution).
    - **Terminal:** Ghostty.
    - **Multiplexer:** Tmux (with TPM).
    - **Desktop Environment:** Hyprland (Arch Linux only).
    - **Dictation:** Voxtype (Whisper-based, Linux only).
    - **Utilities:** `ripgrep`, `fd`, `fzf`, `zoxide`, `eza`, `starship`.

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
    - `voxtype/`: Voxtype dictation settings.
    - `.bashrc`: Linux-specific Bash configuration.

## Key Bindings & Shortcuts (Corne Optimized)

### Tmux (Common)
- **Prefix:** `C-Space` (Ctrl + Space).
- **Tabs (Windows):**
    - `Prefix + t`: New Tab.
    - `Prefix + r`: Rename Tab.
    - `Alt + 1-9`: Switch to Tab directly.
    - `Prefix + X`: Kill Tab.
- **Splits (Panes):**
    - `Prefix + |`: Vertical Split.
    - `Prefix + =`: Horizontal Split.
    - `Prefix + x`: Kill Split.
    - `Prefix + Shift + H/J/K/L`: Resize Split (5 units).
- **Navigation:** `C-h/j/k/l` to move between splits (including Neovim).

### Hyprland (Linux)
- **Navigation:**
    - `SUPER + H/J/K/L`: Move window focus (Vim-style).
    - `SUPER + SHIFT + H/L`: Switch workspace (Cycle).
    - `SUPER + CTRL + H/L`: Move window to workspace (Cycle).
- **Tools:**
    - `SUPER + SHIFT + S`: Screenshot to clipboard (smart select).
    - `SUPER + SHIFT + N`: Toggle Night Shift (Omarchy).
    - `SUPER + SHIFT + M`: Omarchy Menu.
- **Dictation:** `Thumb Key (F13)`: Push-to-Talk (Voxtype).

### Shell (Zsh - Common)
- **Search QoL:**
    - `rgc <query>`: Ripgrep with 2 lines of context.
    - `fif`: Interactive "Find In File" (rg -> fzf -> nvim).
    - `fda <name>`: Find all (including hidden/ignored).
    - `fzp`: Fuzzy Jump to directory (with eza tree preview).
    - `rgt`: Interactive ripgrep filter by file type.

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
