
export PATH="$PATH:$HOME/.local/bin/"
export PATH="$PATH:$HOME/.cargo/bin/"
clear
echo ""
echo ""
random_colors

# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Keybinds
bindkey '^R' fzf-history-widget              # Ctrl+R to search history via fzf
bindkey '^f' autosuggest-accept              # Ctrl+F to accept autosuggestion
bindkey '^p' history-search-backward         # Ctrl+P to search backward in history
bindkey '^n' history-search-forward          # Ctrl+N to search forward in history
bindkey '^P' fzf-history-widget              # Ctrl+Shift+P also maps to fzf history search
# Note: You can unify '^P' and '^p' if you like or keep both for redundancy

# FZF configuration

# Default FZF options for file searching
export FZF_DEFAULT_OPTS="
  --layout=reverse
  --border=rounded
  --height=60%
  --margin=1
  --padding=1
  --color=bg:#000000,bg+:#1e1e2e
  --color=fg:#cdd6f4,fg+:#f5e0dc
  --color=hl:#f38ba8,hl+:#f5c2e7
  --color=info:#89b4fa,prompt:#cba6f7
  --color=pointer:#f5e0dc,marker:#a6e3a1
  --color=spinner:#f9e2af,header:#89dceb
  --color=border:#6c7086,separator:#45475a
  --preview 'bat --style=numbers --color=always --theme=base16 {} 2>/dev/null || cat {}'
  --preview-window=right:50%:wrap
  --bind='ctrl-j:down,ctrl-k:up'
  --bind='ctrl-u:preview-page-up,ctrl-d:preview-page-down'
  --bind='ctrl-/:toggle-preview'
  --prompt='❯ '
  --pointer='▶'
  --marker='✓'
"

# FZF options specifically for history search (no preview)
export FZF_CTRL_R_OPTS="
  --layout=reverse
  --border=rounded
  --height=40%
  --margin=1
  --padding=1
  --color=bg:#000000,bg+:#1e1e2e
  --color=fg:#cdd6f4,fg+:#f5e0dc
  --color=hl:#f38ba8,hl+:#f5c2e7
  --color=info:#89b4fa,prompt:#cba6f7
  --color=pointer:#f5e0dc,marker:#a6e3a1
  --color=spinner:#f9e2af,header:#89dceb
  --color=border:#6c7086,separator:#45475a
  --bind='ctrl-j:down,ctrl-k:up'
  --prompt='⏱ '
  --pointer='▶'
  --no-preview
"

fopen() {
  local file
  file=$(fzf)
  [[ -n "$file" ]] && $EDITOR "$file"
}

export MANPAGER="nvim +Man!"


# Source alias file
. $HOME/.startup-files/.alias.txt

# Zinit plugin manager setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins section
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting 
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
autoload -Uz compinit && compinit
zinit cdreplay -q

# History setup
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Load Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh-autosuggestions settings
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=true  
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20  

# fzf and zoxide configuration
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
zstyle ':completion:*' menu no
KEYTIMEOUT=1

# Load Powerlevel10k from dotfiles if exists
[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh
