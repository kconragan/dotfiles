# My Personal Dotfiles

These are my dotfiles for setting up my development environment on macOS and Arch Linux. The setup leverages GNU Stow for symlinking configurations and includes setup instructions for Zsh, Tmux, Neovim (LazyVim), Hyprland, and various command-line tools.

Okay, here is the complete, restructured README.md file content again:

Markdown

# My Personal Dotfiles: A Modern Terminal Setup ✨

Welcome to my personal configuration files (`dotfiles`)! This setup aims to create a beautiful and productive command-line experience on both **macOS** and **Arch Linux**.

**What you get:**

* **Modern Look & Feel:** Uses modern terminals like Ghostty (macOS) or Kitty (Linux) with full True Color support.
* **Rich Icons & Glyphs:** Powered by the Iosevka Term Nerd Font.
* **Helpful Prompt:** Customized Zsh prompt using Oh My Posh for relevant git status, Python version, etc.
* **Efficient Shell:** Zsh with auto-suggestions, syntax highlighting, and smart directory jumping (`zoxide`).
* **Powerful Editing:** Neovim setup based on LazyVim for a great out-of-the-box experience.
* **Terminal Multitasking:** Tmux configured with easy navigation, session saving, and useful plugins.
* **(Arch Linux):** A configured Hyprland desktop environment with Waybar, Rofi, Dunst, and more.

---

## Installation Guide

1.  **Prepare Your System:** Install basic tools and package managers.
2.  **Get the Look:** Install the terminal emulator and the special font needed for icons.
3.  **Install Everything Else:** Install all the core command-line tools and applications.
4.  **Link Your Configs:** Clone this repository and use Stow to link the configuration files.
5.  **Final Touches:** Set up your shell, plugins, and other settings.

---

### Step 1: Prepare Your System

First, we need the basic tools to download and manage software.

**On macOS:**

1.  **Install Xcode Command Line Tools:** If you haven't already, these are needed for many development tools. Open `Terminal.app` and run:
    ```bash
    xcode-select --install
    ```
    *(Follow the prompts to install)*
2.  **Install Homebrew:** This is the main package manager for macOS. Paste this in your terminal:
    ```bash
    /bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"
    ```
    *(Follow the instructions it gives you, including potentially adding brew to your PATH)*
3.  **Install Git:** Homebrew might install this, but let's ensure it's there:
    ```bash
    brew install git
    ```

**On Arch Linux:**

1.  **Update System & Install Basics:** Make sure your system is up-to-date and install `git` and tools needed for building software (`base-devel`, essential for AUR packages later).
    ```bash
    sudo pacman -Syu --needed git base-devel
    ```
2.  **Install an AUR Helper (yay):** The Arch User Repository (AUR) has many useful packages. `yay` is a popular helper to install them easily.
    ```bash
    # Only run this if you don't have yay installed
    if !command -v yay &> /dev/null; then
      echo "Installing yay..."
      cd /tmp # Or another temporary directory
      git clone [https://aur.archlinux.org/yay.git](https://aur.archlinux.org/yay.git) && cd yay && makepkg -si && cd .. && rm -rf yay
      echo "yay installed successfully."
    fi
    ```

---

### Step 2: Get the Look (Terminal & Font) 👀

This setup relies on a modern terminal and a "Nerd Font" for icons.

**On macOS:**

1.  **Install Ghostty Terminal:**
    ```bash
    brew install --cask ghostty
    ```
2.  **Install Iosevka Nerd Font:**
    ```bash
    brew tap homebrew/cask-fonts
    brew install --cask font-iosevka-nerd-font
    ```
3.  **Configure Ghostty:**
    * **Quit** the default `Terminal.app`.
    * **Open Ghostty.**
    * Go into Ghostty's settings/preferences (check its menus).
    * Find the Font settings and select **"Iosevka Term Nerd Font"** (or similar Nerd Font variant name) as the main terminal font. Set the font size as desired.

**On Arch Linux:**

1.  **Install Kitty Terminal:** (This is the terminal specified in the Hyprland config)
    ```bash
    sudo pacman -S --needed kitty
    ```
2.  **Install Iosevka Nerd Font:**
    ```bash
    sudo pacman -S --needed ttf-iosevka-nerd
    ```
3.  **Configure Kitty:**
    * **Open Kitty.**
    * You'll configure Kitty's font properly later when we link the dotfiles (which includes a `kitty.conf`), but you can temporarily set the font if needed by editing `~/.config/kitty/kitty.conf` or using its command palette (`Ctrl+Shift+P` -> `Set Font`). Select **"Iosevka Term Nerd Font"**.

*From now on, use Ghostty (macOS) or Kitty (Arch) for the rest of the setup steps!*

---

### Step 3: Install Everything Else 🛠️

Now, let's install the rest of the command-line tools and applications.

**On macOS:**

```bash
# Update Homebrew definitions
brew update

# Core CLI Tools & Utilities
brew install stow zsh neovim tmux eza fd fzf zoxide pyenv oh-my-posh thefuck zsh-autosuggestions zsh-syntax-highlighting python curl wget lazygit

# Build dependencies for pyenv (needed to install different Python versions)
brew install openssl readline sqlite3 xz zlib tcl-tk

# Other development tools (Optional)
brew install node go github-cli
