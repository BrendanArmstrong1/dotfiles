#
# ~/.zprofile
#

[[ -f ~/.config/zsh/.zshrc ]] && . ~/.config/zsh/.zshrc

export PATH=$PATH:$HOME/.config/scripts:$HOME/.config/scripts/blocks:$HOME/.config/scripts/utils:$HOME/.config/scripts/programs:$HOME/.config/scripts/system:$HOME/.config/emacs/bin:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/.local/share/cargo/bin
export EDITOR=vim
export TERMINAL=st
export BROWSER=google-chrome-stable

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export EXA_COLORS="da=35"


[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx "$XDG_CONFIG_HOME/X11/xinitrc" --vt1
