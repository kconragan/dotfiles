# ------------------------------
# History Configuration
# ------------------------------
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify

# ------------------------------
# Pyenv (Python Version Management)
# ------------------------------
# Must be initialized early to manage PATH correctly.
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ------------------------------
# Aliases (Shortcuts for Commands)
# ------------------------------
alias vim="nvim"
alias g="git"
alias c='clear'
alias ls="eza --icons --oneline --group-directories-first --sort=extension"
alias ld="eza -lD --icons=always"
alias lf="eza -lf --color=always --icons=always | grep -v /"
alias lh="eza -dl .* --group-directories-first --icons=always"
alias ll="eza -al --group-directories-first --icons=always"
alias lt="eza -al --sort=modified --icons=always"

# ------------------------------
# Zoxide (Smart Directory Jumper)
# ------------------------------
eval "$(zoxide init zsh)"
alias cd="z"
alias zz="z -"
alias ..="z .."
alias ...="z ../.."
alias ....="z ../../.."

# ------------------------------
# Oh My Posh Prompt
# ------------------------------
eval "$(oh-my-posh init zsh)"

# ------------------------------
# TheFuck Prompt
# ------------------------------
eval $(thefuck --alias)

# ------------------------------
# Command Line Editing and Completion
# ------------------------------
# Plugins must be sourced at the end of the file.
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Zsh Autosuggestions should be loaded before syntax highlighting.
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Zsh Syntax Highlighting MUST BE THE LAST THING SOURCED.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
