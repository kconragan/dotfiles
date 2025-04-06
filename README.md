# My Personal Dotfiles

These are my dotfiles for setting up my development environment on macOS and Arch Linux. The setup leverages GNU Stow for symlinking configurations and includes setup instructions for Zsh, Tmux, Neovim (LazyVim), Hyprland, and various command-line tools.

## Prerequisites

Before you begin, ensure you have the following prerequisites installed:

* **Git:** Required for cloning this repository.
* **macOS:** [Homebrew](https://brew.sh/) package manager. If not installed, run:
    ```bash
    /bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"
    ```
* **Arch Linux:** A working internet connection and the `base-devel` package group (for AUR helper and compiling some tools/plugins):
    ```bash
    sudo pacman -Syu --needed base-devel git
    ```
    An AUR helper like `yay` or `paru` is recommended for easily installing packages from the Arch User Repository. The Arch instructions below assume `yay` is installed.

## Installation

Follow these steps to set up a new machine:

1.  **Clone the Repository:**
    Clone this repository into your home directory:
    ```bash
    git clone [https://github.com/kconragan/dotfiles.git](https://github.com/kconragan/dotfiles.git) ~/dotfiles
    cd ~/dotfiles
    ```
    *(If you use Git submodules, uncomment and run the following):*
    ```bash
    # git submodule update --init --recursive
    ```

2.  **Install Dependencies:**
    Run the appropriate commands for your operating system.

    **A. macOS (using Homebrew)**
    ```bash
    # Install Xcode Command Line Tools if not present (needed for compiling some plugins)
    xcode-select --install

    # Update Homebrew and install core CLI packages
    brew update
    brew install git stow zsh neovim tmux eza fd fzf zoxide pyenv oh-my-posh thefuck zsh-autosuggestions zsh-syntax-highlighting python curl wget lazygit

    # Add other commonly used language runtimes or tools if desired
    # brew install node go github-cli

    # --- Recommended Font (Iosevka Term Nerd Font) ---
    # Required for icons in prompt, tmux theme, eza, nvim, etc.
    brew tap homebrew/cask-fonts
    brew install --cask font-iosevka-nerd-font # Provides Iosevka Term Nerd Font style

    # --- Build dependencies for pyenv (for installing Python versions) ---
    brew install openssl readline sqlite3 xz zlib tcl-tk

    # --- GUI Apps / Casks ---
    brew install --cask zed qbittorrent ghostty # Install Zed, qBittorrent, and Ghostty
    ```

    **B. Arch Linux (using pacman / yay)**
    ```bash
    # --- Core Desktop/System Utilities ---
    # Ensure base-devel is installed (should be from prerequisites)
    sudo pacman -Syu --needed base-devel
    # Install essential CLI tools, Python, clipboard/portal/Wayland tools
    sudo pacman -S --needed git stow zsh neovim tmux eza fd fzf zoxide pyenv oh-my-posh thefuck zsh-autosuggestions zsh-syntax-highlighting python curl wget wl-clipboard xdg-utils lazygit xdg-desktop-portal-hyprland qt5-wayland qt6-wayland polkit-kde-agent

    # Add other commonly used language runtimes or tools if desired
    # sudo pacman -S --needed nodejs npm go rustup

    # --- Fonts ---
    # Install Iosevka Nerd Font (provides Iosevka Term style)
    sudo pacman -S --needed ttf-iosevka-nerd
    # Waybar/Dunst might need others? Check their configs if needed.

    # --- Build dependencies for pyenv (for installing Python versions) ---
    # base-devel covers most C build tools
    sudo pacman -S --needed openssl zlib xz sqlite bzip2 readline tk llvm

    # --- Hyprland Environment Specific Packages (from hyprland.conf) ---
    sudo pacman -S --needed hyprland waybar dunst kitty firefox dolphin rofi

    # --- Install AUR Helper (yay - example) ---
    if !command -v yay &> /dev/null; then
      echo "Installing yay..."
      cd /tmp # Or another temporary directory
      git clone [https://aur.archlinux.org/yay.git](https://aur.archlinux.org/yay.git) && cd yay && makepkg -si && cd .. && rm -rf yay
      cd ~/dotfiles # Return to dotfiles directory
      echo "yay installed successfully."
    fi

    # --- Install packages from AUR (using yay) ---
    # From hyprland.conf
    yay -S --needed waypaper-git # Or 'waypaper' if preferred and available
    yay -S --needed 1password 1password-cli
    # Optional additions (uncomment to install):
    # yay -S --needed hyprlock # Screen locker
    # sudo pacman -S --needed grim slurp # Screenshot tools
    # sudo pacman -S --needed cliphist # Clipboard history

    # --- GUI Apps (Confirm Source/AUR Helper needed) ---
    yay -S --needed zed-editor # Zed Editor (if using AUR version)
    sudo pacman -S --needed qbittorrent # qBittorrent (usually from official repos)

    # --- Cleanup AUR build directories (Optional) ---
    # yay -Sc --aur
    ```

3.  **Symlink Configuration Files using Stow:**
    Navigate to the cloned repository directory (`~/dotfiles`) if you aren't already there. Then, use Stow to create symlinks in your home directory.
    ```bash
    cd ~/dotfiles

    # Stow core cross-platform configs
    stow nvim tmux zsh

    # Stow platform-specific configs
    if [[ "$(uname)" == "Linux" ]]; then
        # Stow Hyprland config on Linux
        stow hypr
        # Add any other Linux-only directories here
    elif [[ "$(uname)" == "Darwin" ]]; then
        # Add any macOS-only directories here (if you create them later)
        echo "macOS specific stow commands here (if any)"
    fi
    ```
    *Review the list (`nvim`, `tmux`, `zsh`, `hypr`) and add/remove directories as needed based on what you intend to manage with Stow.*

## Post-Installation Steps

After installing dependencies and stowing files, perform these steps:

1.  **Change Default Shell to Zsh:**
    ```bash
    chsh -s $(which zsh)
    ```
    You will need to **log out and log back in** for the change to take effect.

2.  **Configure Terminal Emulator:**
    * Set the terminal font to **Iosevka Term Nerd Font** in the terminal's settings (Ghostty, Kitty) to ensure icons render correctly. You install the `font-iosevka-nerd-font` (macOS) or `ttf-iosevka-nerd` (Arch) package, then select the specific "Iosevka Term Nerd Font" style from the font list in your terminal application.
    * Ensure your terminal supports **True Color**. (Ghostty and Kitty do).
    * **macOS:** Ghostty is installed via Homebrew Cask.
    * **Arch Linux:** `kitty` is installed via pacman as per `hyprland.conf`.

3.  **Adjust Zsh Plugin Sourcing (Important!):**
    Your `.zshrc` currently uses hardcoded Homebrew paths for plugins. Modify the sourcing lines in `~/dotfiles/zsh/.zshrc` to work cross-platform. Replace the current `source /opt/homebrew/...` lines with something like this:
    ```zsh
    # ~/.zshrc excerpt - Zsh Plugin Sourcing

    # Attempt to source plugins from common locations
    # macOS (Homebrew standard path for ARM)
    [[ -s "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    [[ -s "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

    # Arch Linux (Common package install path)
    [[ -s "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    [[ -s "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

    # Add other potential paths if needed (e.g., Homebrew on Intel Mac: /usr/local/share/...)
    ```
    *After editing `.zshrc` within your `~/dotfiles/zsh/` directory, run `source ~/.zshrc` in your terminal or open a new terminal window.*

4.  **Install Tmux Plugin Manager (TPM):**
    TPM needs to be cloned manually the first time:
    ```bash
    git clone [https://github.com/tmux-plugins/tpm](https://github.com/tmux-plugins/tpm) ~/.tmux/plugins/tpm
    ```

5.  **Install Tmux Plugins:**
    * Launch `tmux` (e.g., by typing `tmux` in your terminal).
    * Press `prefix + I` (capital 'I') to install the plugins defined in your `tmux.conf`. Your prefix key is `Ctrl+Space`.

6.  **Initialize Neovim (LazyVim):**
    * Run `nvim`.
    * LazyVim (`lazy.nvim`) should automatically start bootstrapping and installing all configured plugins. Wait for this process to complete (it might take a minute or two).
    * Restart `nvim` after the installation finishes.
    * **(Optional but Recommended):** Run `:checkhealth` inside Neovim to check for potential issues or missing dependencies for specific plugins. Use `:Mason` to view and manage Language Servers, Linters, and Formatters handled by Mason, though LazyVim often installs configured ones automatically.

7.  **Configure Git User:**
    Set your global Git name and email address:
    ```bash
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    ```

8.  **First Pyenv Use (If needed):**
    Install desired Python versions and set a global default:
    ```bash
    pyenv install 3.11.4 # Example version
    pyenv global 3.11.4
    ```

## Platform Differences

Conditional logic based on the operating system can be used within configuration files (like `.zshrc`) to apply specific settings. Your `oh-my-posh` configuration is a good example:

```zsh
# Example from your .zshrc for Oh My Posh prompt theme
if [[ "<span class="math-inline">OSTYPE" \=\= "darwin"\* \]\]; then
\# macOS specific Oh My Posh config
eval "</span>(oh-my-posh init zsh --config $HOME/dotfiles/zsh/oh-my-posh/mac-theme.omp.json)"
elif [[ "<span class="math-inline">OSTYPE" \=\= "linux\-gnu"\* \]\]; then
\# Linux specific Oh My Posh config
eval "</span>(oh-my-posh init zsh --config <span class="math-inline">HOME/dotfiles/zsh/oh\-my\-posh/linux\-theme\.omp\.json\)"
else
\# Default config \(optional fallback\)
eval "</span>(oh-my-posh init zsh --config <span class="math-inline">HOME/dotfiles/zsh/oh\-my\-posh/mac\-theme\.omp\.json\)"
fi
\# Similar 'if \[\[ "</span>(uname)" == "Darwin" ]]' or 'if [[ "$OSTYPE" == "linux-gnu"* ]]'
# blocks can be used for OS-specific aliases, environment variables,
# or sourcing platform-specific config files.
