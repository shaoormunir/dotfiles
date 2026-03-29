# Path
export PATH="$HOME/.local/bin:/opt/homebrew/share/google-cloud-sdk/bin:$PATH"

# Editor
export EDITOR="code --wait"
export VISUAL="code --wait"

# ── History ──────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY          # write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST    # expire duplicates first when trimming
setopt HIST_IGNORE_DUPS          # don't record an entry that was just recorded
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_SPACE         # don't record entries starting with a space
setopt HIST_FIND_NO_DUPS         # don't display duplicates when searching
setopt HIST_SAVE_NO_DUPS         # don't write duplicates to the history file
setopt SHARE_HISTORY             # share history between all sessions

# ── Zsh Options ──────────────────────────────────────────
setopt AUTO_CD                   # cd by typing directory name
setopt AUTO_PUSHD                # make cd push the old directory onto the stack
setopt PUSHD_IGNORE_DUPS         # no duplicates in dir stack
setopt PUSHD_SILENT              # don't print dir stack after pushd/popd
setopt CORRECT                   # command auto-correction
setopt INTERACTIVE_COMMENTS      # allow comments in interactive shell
setopt EXTENDED_GLOB             # extended globbing (#, ~, ^)
setopt NO_BEEP                   # no beeping

# ── Completion ───────────────────────────────────────────
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Completion styling (like omz)
zstyle ':completion:*' menu select                       # arrow-key menu
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}    # colored completions
zstyle ':completion:*' group-name ''                     # group by category
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches --%f'
zstyle ':completion:*' squeeze-slashes true               # //dir → /dir
zstyle ':completion:*' completer _complete _approximate   # fuzzy completion

# ── Key Bindings ─────────────────────────────────────────
bindkey -e                                # emacs mode (like omz default)
bindkey '^[[1;3D' backward-word           # Option + Left
bindkey '^[[1;3C' forward-word            # Option + Right
bindkey '^[[1;9D' backward-word           # Alt + Left (iTerm2)
bindkey '^[[1;9C' forward-word            # Alt + Right (iTerm2)
bindkey '^[b' backward-word               # Esc + b
bindkey '^[f' forward-word                # Esc + f
bindkey '^[[3~' delete-char               # Delete key
bindkey '^[[H' beginning-of-line          # Home
bindkey '^[[F' end-of-line                # End
# Up/Down arrow history search is handled by zsh-history-substring-search plugin

# ── Aliases ──────────────────────────────────────────────
alias ls="eza --icons"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias lt="eza -l --icons --git --sort=modified"
alias tree="eza --tree --icons"
alias cat="bat --paging=never"
alias d='dirs -v'                         # directory stack
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'  # colorized --help
for index ({1..9}) alias "$index"="cd +${index}"; unset index  # cd to dir stack entry

# ── fzf ──────────────────────────────────────────────────
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --color=fg:#f8f8f2,bg:-1,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# ── Zsh plugins ──────────────────────────────────────────
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ── Zoxide (smarter cd) ─────────────────────────────────
eval "$(zoxide init zsh)"


# ── Starship prompt (must be last) ──────────────────────
eval "$(starship init zsh)"
