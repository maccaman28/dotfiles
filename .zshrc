#
# ~/.zshrc
#

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt correct

PROMPT='[%n@%M %c]$ '

if [[ -z $DISPLAY ]] && [[ "$(tty)" == "/dev/tty1" ]]; then
  exec sway
fi

(cat ~/.cache/wal/sequences &)
. "$HOME/.cache/wal/colors.sh"

GDK_BACKEND='wayland'
BEMENU_BACKEND='wayland'
XDG_SESSION_TYPE='wayland'
XDG_CURRENT_DESKTOP='sway'
QT_QPA_PLATFORM='wayland'
QT_QPA_PLATFORMTHEME='qt5ct'
_JAVA_AWT_WM_NONREPARENTING='1'

autoload -Uz compinit add-zsh-hook
compinit

zshcache_time="$(date +%s%N)"

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

PATH="$PATH:~/.local/bin"

alias ls='ls --color=auto'
alias wget='wget -c'
alias dd='dd status=progress'
alias c='clear'
alias e='exit'
alias eip='curl ipinfo.io/ip'
alias lip="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
alias mem='free -mt'
alias freq="watch -t -n1 'cat /proc/cpuinfo | grep \"^[c]pu MHz\"'"
alias autoremove='sudo pacman -Rsn $(pacman -Qtdq)'
alias yay='paru'
