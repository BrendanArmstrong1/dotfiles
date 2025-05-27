#
# ~/.zprofile
#

[[ -f ~/.config/zsh/.zshrc ]] && . ~/.config/zsh/.zshrc

export PATH=$PATH:$HOME/.config/scripts:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/.local/share/cargo/bin
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=kitty
export BROWSER=google-chrome-stable

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND="$FZF_CTRL_T_COMMAND"
# export FZF_CTRL_T_COMMAND='fd -t d --hidden -follow --exclude ".git" . $HOME'
export FZF_CTRL_T_OPTS="--reverse --height=30 --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b --preview='bat --color=always --style=numbers {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export READER="zathura"
export GOPATH="$HOME/ssd/Go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# export GNUPGHOME="$XDG_DATA_HOME/gnupg"
# export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# export npm_config_prefix="$HOME/.local"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export EXA_COLORS="da=35"

# This is the list for lf icons:
export LF_ICONS="di=:\
fi=:\
tw=:\
ow=:\
ln=:\
or=❌:\
ex=:\
*.rs=:\
*.c=:\
*.cpp=:\
*.py=:\
*.vim=:\
*.sh=:\
*.js=:\
*.html=:\
*.css=:\
*.xml=📰:\
*.txt=:\
*.json=:\
*.mom=:\
*.me=:\
*.ms=:\
*.png=:\
*.webp=:\
*.ico=:\
*.jpg=:\
*.jpe=:\
*.jpeg=:\
*.gif=:\
*.svg=:\
*.tif=:\
*.tiff=:\
*.xcf=:\
*.gpg=🔒:\
*.pdf=:\
*.djvu=:\
*.epub=:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.wav=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.mov=🎥:\
*.mpg=🎥:\
*.wmv=🎥:\
*.m4b=🎥:\
*.flv=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=:\
*.img=:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"


[[ $(fgconsole 2>/dev/null) == 1 ]] && exec ssh-agent startx "$XDG_CONFIG_HOME/X11/xinitrc" --vt1
