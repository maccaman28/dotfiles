#
# ~/.zshrc
#

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt correct

autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure

if [[ $TERM == "alacritty" ]]; then
  PURE_PROMPT_SYMBOL='❯'
else
  PURE_PROMPT_SYMBOL='->'
fi

if [[ -z $DISPLAY ]] && [[ "$(tty)" == "/dev/tty1" ]]; then
  exec sway
fi

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

PATH="$PATH:$HOME/.local/bin"

alias ls='ls --color=auto'
alias wget='wget -c'
alias dd='dd status=progress'
alias c='clear'
alias e='exit 0'
alias eip='curl ipinfo.io/ip'
alias lip="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
alias mem='free -mt'
alias freq="watch -t -n1 'cat /proc/cpuinfo | grep \"^[c]pu MHz\"'"
alias autoremove='doas pacman -Rsn $(pacman -Qtdq)'
alias yay='paru'
alias sudo='doas'

flood() {
  while true; do tr -dc 'A-Za-z0-9!"$%^&*()-=_+,.<>/?;:@#~[]{}\|'"'" </dev/urandom | head -c $(tput cols)  ; echo; done | lolcat
}

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
