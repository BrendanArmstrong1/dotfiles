#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
autoload -Uz vcs_info
precmd() { vcs_info }
# zstyle ':vcs_info:*+*:*' debug true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' ↑'
zstyle ':vcs_info:*' unstagedstr ' ❌'
zstyle ':vcs_info:git*' formats '%F{011} %b %u%c%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='T'
    fi
}

#PS1='[\u@\h \W]\$ '
#PS1='\e[0;31m[\e[m\e[0;36m\u\e[0;31m@\e[m\e[0;36m\h\e[m \e[1;34m\W\e[m\e[0;31m]\e[m\e[0;36m\$\e[m '
setopt PROMPT_SUBST
autoload -U colors && colors
#PS1="%B%{$fg[red]%}[%{$fg[cyan]%}%n%{$fg[red]%}@%{$fg[cyan]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
PROMPT='%F{009}[%f%F{051}%n%f%F{009}@%f%F{051}%M%f %F{013}${PWD/#$HOME/~}%f ${vcs_info_msg_0_}%F{009}]%f$ '


# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt appendhistory

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
       [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} = '' ]] ||
         [[ $1 = 'beam' ]]; then
         echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[2 q' ;} # Use beam shape cursor for each new prompt

# # Use lf to switch directories and bind it to ctrl-o
# jocd () {
#     tmp="$(mktemp)"
#     jo --last-dir "$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp" >/dev/null
#         [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#     fi
# }
# bindkey -s '^y' 'neomutt\n'
function yazd() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

bindkey -s '^p' 'yazd\n'
bindkey -s '^a' 'bc -lq\n'

bindkey -s '^F' 'de\n'

# Edit line in vim with ctrl-n:
autoload edit-command-line; zle -N edit-command-line
bindkey '^n' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# Configuring fuzzy completion
# https://github.com/junegunn/fzf#settings
_fzf_compgen_path () {
  [[ ! -d "$1"/.git ]] && fd_flags="-I"
  fd --hidden --type f --follow --exclude ".git" "$fd_flags" . "$1"
}

_fzf_compgen_dir () {
  [[ ! -d "$1"/.git ]] && fd_flags="-I"
  fd --hidden --type d --follow --exclude ".git" "$fd_flags" . "$1"
}

# # Options for path completion (e.g. vim **<TAB>)
# export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
#
# # Options for directory completion (e.g. cd **<TAB>)
# export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

# fzf options for each command
_fzf_comprun () {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}
