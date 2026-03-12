# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository supporting both macOS and Arch Linux. Configuration files are symlinked into place by `install.sh`, which is idempotent and safe to re-run.

## Installation

```bash
./install.sh
```

After install, start tmux and press `Ctrl+l` then `I` (capital I) to install tmux plugins via TPM.

## Repository Structure

- `common/` — Shared configs for all platforms (nvim, tmux, zsh, starship, git, etc.)
- `mac/` — macOS-specific overrides (ghostty, tmux local config, raycast, etc.)
- `linux/` — Arch Linux overrides (ghostty, tmux, hyprland)

Symlink targets:
| Source | Destination |
|--------|-------------|
| `common/nvim/` | `~/.config/nvim` |
| `common/.gitconfig` | `~/.gitconfig` |
| `common/tmux/.tmux.conf` | `~/.tmux.conf` |
| `common/starship/starship.toml` | `~/.config/starship.toml` |
| `common/zsh/.zshrc` | `~/.zshrc` |
| `mac/tmux/tmux.conf` | `~/.tmux.conf.local` |
| `mac/ghostty/config` | `~/.config/ghostty/config` |

## Neovim Configuration

Built on **LazyVim** (`common/nvim/`). Key layout:

- `lua/config/lazy.lua` — Plugin spec entrypoint; imports LazyVim defaults + `lua/plugins/`
- `lua/config/keymaps.lua` — Custom keymaps
- `lua/config/options.lua` — Custom options (relative numbers off, MDX filetype)
- `lua/plugins/` — Custom plugin overrides and additions

### Theme Logic

`lua/plugins/theme.lua` dynamically picks the colorscheme: on Linux with Omarchy it reads `~/.config/omarchy/current/theme/neovim.lua`; on macOS it defaults to **Kanagawa Dragon**.

### Notable Plugins

- **opencode.nvim** — AI coding assistant, keymaps under `<leader>o`
- **snacks.nvim** — Various UI improvements; scroll animation disabled via `snacks-animated-scrolling-off.lua`
- **LazyVim extras** — `lazyvim.plugins.extras.lang.astro` enabled

## Shell (Zsh, macOS)

`common/zsh/.zshrc` load order matters:
1. pyenv init (early, for PATH)
2. zoxide init
3. oh-my-posh / thefuck evals
4. zsh-autosuggestions (before syntax highlighting)
5. zsh-syntax-highlighting (must be last)

`cd` is aliased to `z` (zoxide). `vim` is aliased to `nvim`.

## Git Config

`common/.gitconfig` sets `pull.rebase = true` and uses `gh auth git-credential` for GitHub/Gist authentication. The install script sets `user.name` and `user.email` at runtime.
