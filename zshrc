source "$XDG_CONFIG_HOME/misc/aliases"
source "$XDG_DATA_HOME/nvim/plugged/gruvbox/gruvbox_256palette.sh"
if [ -x "$(command -v dircolors)" ]; then
    eval "$(dircolors -b ${XDG_CONFIG_HOME}/misc/dir-colors)"
fi

## menu-style
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit
zstyle ':completion:*' special-dirs true
# case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Tab completion colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# add new installed packages into completions
zstyle ':completion:*' rehash true
# Use better completion for the kill command
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;34'
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# use completion cache
zstyle ':completion::complete:*' use-cache true

bindkey '^[[Z' reverse-menu-complete
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

setopt PROMPT_PERCENT
setopt PROMPT_SUBST
# history config
HISTSIZE=1000
SAVEHIST=1000
export HISTFILE="$XDG_DATA_HOME"/zsh/history
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
# Correction when you misstype
#setopt CORRECT
#setopt CORRECT_ALL
# use emacs bindings
set -o emacs

PROMPT='%b%F{#0b98de}%~ %f
%? %F{#fd9014}%(!.#.>) %f'
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:git:*' formats '[%F{green}%b%f%c%u]'
zstyle ':vcs_info:git:*' actionformats '[%F{cyan}%b (%a)%f%c%u]'

RPROMPT='$vcs_info_msg_0_'

#auto suggestions
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
set ZSH_AUTOSUGGEST_USE_ASYNC=true
#fast syntax highlighting
source ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
