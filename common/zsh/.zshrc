# Only execute if we are in Zsh
if [ -n "$ZSH_VERSION" ]; then
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
if [ -d "$PYENV_ROOT" ]; then
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# ------------------------------
# Omarchy Environment
# ------------------------------
# Prevent errors when sourcing bash-style function definitions
unalias n 2>/dev/null
unalias r 2>/dev/null

# Only source compatible aliases and envs, avoid bash-specific scripts
[ -f ~/.local/share/omarchy/default/bash/aliases ] && source ~/.local/share/omarchy/default/bash/aliases
[ -f ~/.local/share/omarchy/default/bash/envs ] && source ~/.local/share/omarchy/default/bash/envs

# ------------------------------
# Aliases (Shortcuts for Commands)
# ------------------------------
alias vim="nvim"
alias g="git"
alias c='clear'
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
# Search Aliases (rg, fd, fzf)
# ------------------------------
if command -v rg >/dev/null && command -v fzf >/dev/null; then
    # rgc: Ripgrep with 2 lines of context and line numbers
    alias rgc='rg -C 2 --line-number --sort path'

    # fda: fd find all (including hidden and ignored files)
    alias fda='fd -H -I'

    # fif: Find In File - Interactive Ripgrep + FZF + Bat preview -> Neovim
    # Uses single quotes for the glob to prevent Zsh history expansion (!)
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
fi

# ------------------------------
# Zoxide (Smart Directory Jumper)
# ------------------------------
if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh)"
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
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

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
