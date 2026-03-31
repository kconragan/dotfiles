# Only execute if we are in Zsh
if [ -n "$ZSH_VERSION" ]; then
    # If not running interactively, don't do anything
    [[ $- != *i* ]] && return

    # -------------------------------------------------------------------------
    # Omarchy Zsh Integration (Official - Linux Only)
    # -------------------------------------------------------------------------
    # Load zsh options, keybindings, and completion
    [[ -f /usr/share/omarchy-zsh/shell/zoptions ]] && source /usr/share/omarchy-zsh/shell/zoptions

    # Load shared shell configuration (aliases, functions, environment, tool init)
    [[ -f /usr/share/omarchy-zsh/shell/all ]] && source /usr/share/omarchy-zsh/shell/all

    # -------------------------------------------------------------------------
    # User Customizations
    # -------------------------------------------------------------------------

    # ------------------------------
    # Default Editor
    # ------------------------------
    export EDITOR="nvim"
    export VISUAL="nvim"

    # ------------------------------
    # History Configuration
    # ------------------------------
    HISTFILE=$HOME/.zhistory
    SAVEHIST=1000
    HISTSIZE=999
    setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify 2>/dev/null

    # ------------------------------
    # Pyenv (Python Version Management)
    # ------------------------------
    export PYENV_ROOT="$HOME/.pyenv"
    if [ -d "$PYENV_ROOT" ]; then
        command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)" 2>/dev/null
    fi

    # ------------------------------
    # Omarchy Environment Overrides
    # ------------------------------
    unalias n 2>/dev/null
    unalias r 2>/dev/null

    # ------------------------------
    # Aliases (Shortcuts for Commands)
    # ------------------------------
    alias vim="nvim"
    alias g="git"
    alias c='clear'
    
    # VPN Control Aliases
    alias vpn-up='sudo systemctl start wg-quick@wg-US-CA-813.service'
    alias vpn-down='sudo systemctl stop wg-quick@wg-US-CA-813.service'
    alias vpn-status='systemctl status wg-quick@wg-US-CA-813.service'

    # Use standard eza aliases if available, otherwise fallback to ls
    if command -v eza >/dev/null; then
        alias ls="eza --icons --oneline --group-directories-first --sort=extension"
        alias ld="eza -lD --icons=always"
        alias lf="eza -lf --color=always --icons=always | grep -v /"
        alias lh="eza -dl .* --group-directories-first --icons=always"
        alias ll="eza -al --group-directories-first --icons=always"
        alias lt="eza -al --sort=modified --icons=always"
    fi

    # ------------------------------
    # Functions
    # ------------------------------
    whatsmyip() {
        local green='\033[0;32m'
        local red='\033[0;31m'
        local nc='\033[0m'
        local is_connected=false
        local active_interface=""

        if command -v wg >/dev/null; then
            local wg_interface=$(sudo wg show 2>/dev/null | grep 'interface:' | awk '{print $2}')
            if [[ -n "$wg_interface" ]]; then
                local handshake_epoch=$(sudo wg show "$wg_interface" latest-handshakes | awk '{print $2}')
                if [[ -n "$handshake_epoch" && "$handshake_epoch" =~ ^[0-9]+$ ]]; then
                    local current_epoch=$(date +%s)
                    if [[ $((current_epoch - handshake_epoch)) -lt 180 ]]; then
                        is_connected=true
                        active_interface=$wg_interface
                    fi
                fi
            fi
        fi

        if [[ "$is_connected" == true ]]; then
            echo -e "VPN Status: ${green}🟢 Connected${nc} (via ${active_interface})"
        else
            echo -e "VPN Status: ${red}🔴 Disconnected${nc}"
        fi

        if command -v ip >/dev/null; then
            local lan_interface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -n1)
            [[ -n "$lan_interface" ]] && echo "Internal IP ($lan_interface): $(ip addr show "$lan_interface" | grep "inet " | awk '{print $2}' | cut -d/ -f1)"
        fi

        echo -n "External IP ($( [[ "$is_connected" == true ]] && echo "VPN" || echo "ISP" )): "
        curl -s -4 ifconfig.me && echo ""
    }

    # ------------------------------
    # Search Aliases (rg, fd, fzf)
    # ------------------------------
    if command -v rg >/dev/null && command -v fzf >/dev/null; then
        alias rgc='rg -C 2 --line-number --sort path'
        alias fda='fd -H -I'

        fif() {
            local file_info=$(rg --line-number --column --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob '!.git/*' "" | \
                fzf --ansi --delimiter : --preview "bat --style=numbers --color=always --highlight-line {2} {1}" --preview-window +{2}-/2)
            if [[ -n "$file_info" ]]; then
                nvim "+$(echo "$file_info" | awk -F: '{print $2}')" "$(echo "$file_info" | awk -F: '{print $1}')"
            fi
        }

        fzp() {
            local dir=$(fd -t d | fzf --preview "eza -T --color=always --icons {} | head -20")
            [[ -n "$dir" ]] && cd "$dir"
        }

        rgt() {
            local type=$(rg --type-list | awk -F: '{print $1}' | fzf --header "Select File Type")
            [[ -n "$type" ]] && echo "Searching in $type files..." && rg -t "$type" "$@"
        }

        # yayf: Fuzzy find and install Arch packages using yay
        if command -v yay >/dev/null; then
            alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
        fi
    fi

    # rr: Ranger-cd (syncs shell directory on exit)
    rr() {
        local temp_file="$(mktemp -t "ranger_cd.XXXXXX")"
        ranger --choosedir="$temp_file" -- "${@:-$PWD}"
        if [ -f "$temp_file" ]; then
            local chosen_dir="$(cat "$temp_file")"
            [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ] && cd "$chosen_dir"
        fi
        rm -f "$temp_file"
    }

    # ------------------------------
    # Tool Initializations
    # ------------------------------
    if command -v zoxide >/dev/null; then
        eval "$(zoxide init zsh)" 2>/dev/null
        alias cd="z"
        alias ..="z .."
        alias ...="z ../.."
    fi

    # Initialize mise (Modern replacement for asdf/nvm/pyenv)
    command -v mise >/dev/null && eval "$(mise activate zsh)" 2>/dev/null

    command -v starship >/dev/null && eval "$(starship init zsh)"

    command -v oh-my-posh >/dev/null && eval "$(oh-my-posh init zsh)"
    command -v thefuck >/dev/null && eval $(thefuck --alias)

    # ------------------------------
    # Completion & Plugins
    # ------------------------------
    bindkey '^[[A' history-search-backward 2>/dev/null
    bindkey '^[[B' history-search-forward 2>/dev/null

    for plugin in \
        /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh \
        /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
        /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
        /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
        /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
        /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    do
        [ -f "$plugin" ] && source "$plugin"
    done

    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
    export BUN_INSTALL="$HOME/.bun"
    [ -d "$BUN_INSTALL" ] && export PATH="$BUN_INSTALL/bin:$PATH"
    [ -d "$HOME/.antigravity/antigravity/bin" ] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
    [ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
fi

# Display system splash screen
if [[ $- == *i* ]] && command -v fastfetch >/dev/null; then
    fastfetch
fi
