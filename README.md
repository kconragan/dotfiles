# Kai's Dotfiles ✨

These are my personal configuration files (`dotfiles`) for creating a beautiful and productive command-line experience on both **macOS** and **Arch Linux**. The goal is a unified, automated setup that can be deployed with a single script.

## Features

- **Automated Setup**: A single idempotent script (`install.sh`) handles package installation and configuration symlinking for both platforms.
- **Modern Terminal**: Uses **Ghostty** with full True Color support and **Iosevka Term Nerd Font** for rich icons and glyphs.
- **Efficient Shell**: A platform-specific shell setup.
  - **On macOS**: **Zsh** with auto-suggestions, syntax highlighting, and `zoxide` for smart directory jumping.
  - **On Arch Linux**: **Bash** as required by the Omarchy environment, keeping the setup clean and compatible.
- **Powerful Editing**: **Neovim** setup based on the **LazyVim** distribution for a great out-of-the-box IDE experience.
- **Terminal Multitasking**: **Tmux** configured with easy navigation, session saving (`tmux-resurrect`), and clipboard integration (`tmux-yank`).
- **Custom Prompt**: A helpful prompt using **Oh My Posh** to display git status, programming language versions, and more.
- **(Arch Linux Only)**: A pre-configured **Hyprland** desktop environment with Waybar, Rofi, and Dunst.

---

## Installation

The installation is designed to be as simple as possible. The `install.sh` script handles package management (via Homebrew on macOS and Pacman on Linux) and creates all necessary symbolic links.

### Step 1: Prerequisites

- **macOS**: [Homebrew](https://brew.sh/) must be installed.
- **Arch Linux**: `git` must be installed (`sudo pacman -S git`).

### Step 2: Clone the Repository

Clone this repository to a location on your machine. A common choice is `~/.dotfiles`.

```bash
git clone https://github.com/kconragan/dotfiles.git ~/.dotfiles
```

### Step 3: Run the Install Script

Navigate into the directory and execute the installation script.

```bash
cd ~/.dotfiles
./install.sh
```

The script will check for and install all required dependencies and then create symbolic links for the configuration files.

## Post-Installation

There is one manual step required after the script completes to finish the tmux setup.

1. Install Tmux Plugins
2. Start a new tmux session by running tmux in your terminal.
3. Press Ctrl+l (your prefix key), then press I (capital I).

This command tells the Tmux Plugin Manager (TPM) to fetch all the plugins listed in your configuration file. You only need to do this once.

## Repository Structure

Repository Structure

- `common/`: Contains configurations that are shared between all platforms.
- `mac/`: Contains configurations that are specific to macOS.
- `linux/`: Contains configurations that are specific to Arch Linux.
- `install.sh`: The main installation and setup script.
