# This is the main configuration file for Zsh. It's sourced every time a new
# terminal session starts.

export TERM="xterm-256color"

# -----------------------------------------------------------------------------
# Omarchy Environment
# -----------------------------------------------------------------------------
# This line sources Omarchy's core environment, which is necessary for
# all of its custom aliases, functions, and paths to work correctly in Zsh.

source ~/.local/share/omarchy/default/bash/rc

# -----------------------------------------------------------------------------
# General Aliases and Commands
# -----------------------------------------------------------------------------

# Make nvim easier to access
alias vim='nvim'
alias n='nvim'
alias e='nvim'

# eza is a modern replacement for the 'ls' command. The flags provide a nicer
# and more informative output.
alias ls='eza --icons --group-directories-first'
alias ll='eza --icons --group-directories-first -al'
alias lh='eza -dl .*'

# z is a utility for quickly navigating to frequently used directories.
alias cd='z'

# clear is aliased to 'c' for convenience.
alias c='clear'

# -----------------------------------------------------------------------------
# Startup Commands
# -----------------------------------------------------------------------------
# fastfetch is a system information tool that runs on startup to display
# system details in the terminal.

fastfetch

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -----------------------------------------------------------------------------
# Shell Enhancements
# -----------------------------------------------------------------------------
# bash-completion is not needed in Zsh. Zsh has its own superior completion system.

# starship is a customizable prompt. The init command is changed to load for zsh.
eval "$(starship init zsh)"

# zoxide is a smarter `cd` command. The init command is changed for zsh.
eval "$(zoxide init zsh)"

