# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

alias vim='nvim'
alias n='nvim'
alias e='nvim'

alias ls='eza --icons --group-directories-first'
alias ll='eza --icons --group-directories-first -al'
alias lh='eza -dl .*'

alias cd='z'

alias c='clear'

alias fff='fastfetch'

fastfetch

source /usr/share/bash-completion/bash_completion

# Initialize the Starship prompt
eval "$(starship init bash)"

# Initialize Zoxide
eval "$(zoxide init bash)"
