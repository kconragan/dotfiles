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
    # History Configuration
    # ------------------------------
    # Note: Omarchy might set these, but we ensure our preferences here
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
    # Prevent errors when sourcing bash-style function definitions
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
        # Use color codes for output
        local green='\033[0;32m'
        local red='\033[0;31m'
        local nc='\033[0m' # No Color

        local active_interface=""
        local lan_interface=""
        local internal_ip=""
        local is_connected=false

        # --- VPN Status Check by Handshake AGE ---
        if command -v wg >/dev/null; then
            local wg_interface
            wg_interface=$(sudo wg show 2>/dev/null | grep 'interface:' | awk '{print $2}')
            if [[ -n "$wg_interface" ]]; then
                local handshake_epoch
                handshake_epoch=$(sudo wg show "$wg_interface" latest-handshakes | awk '{print $2}')
                if [[ -n "$handshake_epoch" && "$handshake_epoch" =~ ^[0-9]+$ ]]; then
                    local current_epoch=$(date +%s)
                    local age=$((current_epoch - handshake_epoch))
                    if [[ "$age" -lt 180 ]]; then
                        is_connected=true
                        active_interface=$wg_interface
                    fi
                fi
            fi
        fi

        # --- Output Section ---
        if [[ "$is_connected" == true ]]; then
            echo -e "VPN Status: ${green}🟢 Connected${nc} (via ${active_interface})"
        else
            echo -e "VPN Status: ${red}🔴 Disconnected${nc}"
        fi

        if command -v ip >/dev/null; then
            lan_interface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -n1)
            if [[ -n "$lan_interface" ]]; then
                internal_ip=$(ip addr show "$lan_interface" | grep "inet " | awk '{print $2}' | cut -d/ -f1)
                echo "Internal IP ($lan_interface): $internal_ip"
            fi
        fi

        if [[ "$is_connected" == true ]]; then
            echo -n "External IP (VPN): "
        else
            echo -n "External IP (ISP): "
        fi
        curl -s -4 ifconfig.me && echo ""
    }

    # ------------------------------
    # Search Aliases (rg, fd, fzf)
    # ------------------------------
    if command -v rg >/dev/null && command -v fzf >/dev/null; then
        # rgc: Ripgrep with 2 lines of context and line numbers
        alias rgc='rg -C 2 --line-number --sort path'

        # fda: fd find all (including hidden and ignored files)
        alias fda='fd -H -I'

        # fif: Find In File - Interactive Ripgrep + FZF + Bat preview -> Neovim
        fif() {
            local file_info
            file_info=$(rg --line-number --column --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob '!.git/*' "" | \
                fzf --ansi --delimiter : \
                    --preview "bat --style=numbers --color=always --highlight-line {2} {1}" \
                    --preview-window +{2}-/2)
            
            if [[ -n "$file_info" ]]; then
                local file=$(echo "$file_info" | awk -F: '{print $1}')
                local line=$(echo "$file_info" | awk -F: '{print $2}')
                nvim "+$line" "$file"
            fi
        }

        # fzp: Fuzzy Jump to directory with eza tree preview
        fzp() {
            local dir
            dir=$(fd -t d | fzf --preview "eza -T --color=always --icons {} | head -20")
            if [[ -n "$dir" ]]; then
                cd "$dir"
            fi
        }

        # rgt: Filter ripgrep by file type (interactive selection)
        rgt() {
            local type
            type=$(rg --type-list | awk -F: '{print $1}' | fzf --header "Select File Type")
            if [[ -n "$type" ]]; then
                echo "Searching in $type files..."
                rg -t "$type" "$@"
            fi
        }

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

        # yayf: Fuzzy find and install Arch packages using yay
        if command -v yay >/dev/null; then
            alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
        fi
    fi

    # ------------------------------
    # Zoxide (Smart Directory Jumper)
    # ------------------------------
    if command -v zoxide >/dev/null; then
        eval "$(zoxide init zsh)" 2>/dev/null
        alias cd="z"
        alias zz="z -"
        alias ..="z .."
        alias ...="z ../.."
        alias ....="z ../../.."
    fi

    # ------------------------------
    # Starship Prompt
    # ------------------------------
    if command -v starship >/dev/null; then
        eval "$(starship init zsh)"
    fi

    # ------------------------------
    # Oh My Posh Prompt (Fallback)
    # ------------------------------
    if command -v oh-my-posh >/dev/null; then
        eval "$(oh-my-posh init zsh)"
    fi

    # ------------------------------
    # TheFuck Prompt
    # ------------------------------
    if command -v thefuck >/dev/null; then
        eval $(thefuck --alias)
    fi

    # ------------------------------
    # Command Line Editing and Completion
    # ------------------------------
    # Plugins must be sourced at the end of the file.
    bindkey '^[[A' history-search-backward 2>/dev/null
    bindkey '^[[B' history-search-forward 2>/dev/null

    # Source Zsh plugins if they exist (Linux/macOS paths)
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

    # bun completions
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

    # bun
    export BUN_INSTALL="$HOME/.bun"
    [ -d "$BUN_INSTALL" ] && export PATH="$BUN_INSTALL/bin:$PATH"

    # Added by Antigravity
    [ -d "$HOME/.antigravity/antigravity/bin" ] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

    [ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
fi
