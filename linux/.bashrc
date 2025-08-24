# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# --------------------------------------------------------------
# EXPORTS
# --------------------------------------------------------------

export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T"
export EDITOR=nvim

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Check if ripgrep is installed
if command -v rg &>/dev/null; then
  # Alias grep to rg if ripgrep is installed
  alias grep='rg'
else
  # Alias grep to /usr/bin/grep with GREP_OPTIONS if ripgrep is not installed
  alias grep="/usr/bin/grep $GREP_OPTIONS"
fi
unset GREP_OPTIONS

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# --------------------------------------------------------------
# ALIASES
# --------------------------------------------------------------

# Editor commads
alias n='nvim'
alias e='nvim'
alias vim='nvim'
alias vi='nvim'

alias brc='nvim ~/.bashrc'
alias sbrc='exec bash'

# Files & Directories
alias ls='eza --icons --group-directories-first'
alias ll='eza --icons --group-directories-first -al'
alias lls='eza --icons --all --reverse --sort date -al'
alias lh='eza -dl .*'

alias cd='z' # Use Zoxide as cd

# Change directory aliases
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias c='clear && fastfetch'

alias fff='fastfetch'

alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"

alias myip="whatsmyip"

alias p='ping -c 4 1.1.1.1'

# VPN Control Aliases
alias vpn-up='sudo systemctl start wg-quick@wg-US-CA-813.service'
alias vpn-down='sudo systemctl stop wg-quick@wg-US-CA-813.service'
alias vpn-status='systemctl status wg-quick@wg-US-CA-813.service'

function whatsmyip() {
  # Use color codes for output
  local green='\033[0;32m'
  local red='\033[0;31m'
  local nc='\033[0m' # No Color

  local active_interface=""
  local lan_interface=""
  local internal_ip=""
  local is_connected=false

  # --- VPN Status Check by Handshake AGE ---
  local wg_interface=$(sudo wg show 2>/dev/null | grep 'interface:' | awk '{print $2}')
  if [[ -n "$wg_interface" ]]; then
    # Get the epoch time of the last handshake (the 2nd column)
    local handshake_epoch=$(sudo wg show "$wg_interface" latest-handshakes | awk '{print $2}') # <-- This line is fixed

    if [[ -n "$handshake_epoch" && "$handshake_epoch" =~ ^[0-9]+$ ]]; then
      local current_epoch=$(date +%s)
      local age=$((current_epoch - handshake_epoch))

      # A handshake should occur roughly every 2 minutes.
      # If it's older than 180 seconds (3 minutes), we consider it stale/disconnected.
      if [[ "$age" -lt 180 ]]; then
        is_connected=true
        active_interface=$wg_interface
      fi
    fi
  fi

  # --- Output Section ---
  if [[ "$is_connected" == true ]]; then
    echo -e "VPN Status: ${green}🟢 Connected${nc} (via ${active_interface})"
  else
    echo -e "VPN Status: ${red}🔴 Disconnected${nc}"
  fi

  lan_interface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -n1)
  if [[ -n "$lan_interface" ]]; then
    internal_ip=$(ip addr show "$lan_interface" | grep "inet " | awk '{print $2}' | cut -d/ -f1)
    echo "Internal IP ($lan_interface): $internal_ip"
  fi

  if [[ "$is_connected" == true ]]; then
    echo -n "External IP (VPN): "
  else
    echo -n "External IP (ISP): "
  fi
  curl -s -4 ifconfig.me && echo ""
}

fastfetch

source /usr/share/bash-completion/bash_completion

# Initialize the Starship prompt
eval "$(starship init bash)"

# Initialize Zoxide
eval "$(zoxide init bash)"
