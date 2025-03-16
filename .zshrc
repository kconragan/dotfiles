# ------------------------------
# History Configuration
# ------------------------------

# Path to the history file where Zsh will save your command history.
HISTFILE=$HOME/.zhistory

# The number of history entries to save in the history file.
SAVEHIST=1000

# The number of history entries to keep in memory during the current session.
HISTSIZE=999

# Share history between all running Zsh sessions. Commands entered in one
# session will be available in others.
setopt share_history

# When the history list is full, expire duplicate entries before older ones.
setopt hist_expire_dups_first

# Prevent consecutive duplicate commands from being entered into the history.
setopt hist_ignore_dups

# Require history substitutions to be verified before execution. This can
# help prevent accidental execution of unintended commands.
setopt hist_verify

# ------------------------------
# Command Line Editing and Completion
# ------------------------------

# Bind the Up Arrow key to search backward in the history.
bindkey '^[[A' history-search-backward

# Bind the Down Arrow key to search forward in the history.
bindkey '^[[B' history-search-forward

# Source the Zsh Autosuggestions plugin. This plugin suggests commands as you
# type based on your history and completions.
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source the Zsh Syntax Highlighting plugin. This plugin highlights commands
# in the terminal as you type, helping to identify syntax errors.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ------------------------------
# Aliases (Shortcuts for Commands)
# ------------------------------

# Alias 'vim' to 'nvim' (Neovim).
alias vim="nvim"

# Alias 'c' to 'clear' to clear the terminal screen.
alias c='clear'

# Aliases for 'eza' (a modern replacement for 'ls' with more features and better defaults)

# Basic listing with icons, one entry per line, directories grouped first, sorted by extension.
alias ls="eza --icons --oneline --group-directories-first --sort=extension"

# Long listing with extended details and icons always enabled.
alias ld="eza -lD --icons=always"

# List only files (no directories) with long format, always colored, with icons.
alias lf="eza -lf --color=always --icons=always | grep -v /"

# List hidden files and directories (starting with '.') in a detailed format,
# grouped by directory first, with icons always enabled.
alias lh="eza -dl .* --group-directories-first --icons=always"

# List all files and directories (including hidden) in a long format,
# grouped by directory first, with icons always enabled.
alias ll="eza -al --group-directories-first --icons=always"

# List all files and directories in a long format, sorted by modification time, with icons always enabled.
alias lt="eza -al --sort=modified --icons=always"

# ------------------------------
# Zoxide (Smart Directory Jumper)
# ------------------------------

# Initialize Zoxide for Zsh. This adds the necessary functions and configurations
# to enable Zoxide's smart directory jumping capabilities.
eval "$(zoxide init zsh)"

# Alias 'cd' to 'z' for quick directory jumping using Zoxide.
alias cd="z"

# Alias 'zz' to jump back to the previously visited directory using Zoxide.
alias zz="z -"

# Alias '..' to use Zoxide to go up one directory.
alias ..="z .."

# Alias '...' to use Zoxide to go up two directories.
alias ...="z ../.."

# Alias '....' to use Zoxide to go up three directories.
alias ....="z ../../.."

# ------------------------------
# Pyenv (Python Version Management)
# ------------------------------

# Set the root directory for Pyenv installations.
export PYENV_ROOT="$HOME/.pyenv"

# Check if the 'pyenv' command exists. If not, add the Pyenv 'bin' directory
# to the system's PATH. This allows you to run the 'pyenv' command.
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# Initialize Pyenv for the current Zsh shell. This enables Pyenv's shims
# and allows you to manage Python versions.
eval "$(pyenv init -)"

# ------------------------------
# Starship Prompt
# ------------------------------

# Initialize the Starship prompt for Zsh. Starship is a highly customizable
# cross-shell prompt that shows relevant information about your environment.
eval "$(starship init zsh)"
