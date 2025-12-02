alias reload=". ~/.zshrc"

alias gst="git status"
alias gd="git diff"
alias gc="git commit -m $1"
alias gsh="git stash"
alias gsha="git stash apply"

if [ "$OS_TYPE" = "Darwin" ]; then
  if [ -x "$(command -v gls)" ]; then
    alias ls='gls'
  else
    info "Run `brew install coreutils` to get GNU."
  fi
fi

alias l="LC_COLLATE=C ls -lAh --color=auto --group-directories-first"

alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias extip="curl https://ipinfo.io/ip"
alias iplz="localip && extip"

alias server="python -m http.server"

alias bye="pmset displaysleepnow"

local _webstorm_path="/usr/local/bin/webstorm"
if [[ -a $_webstorm_path ]]; then
	alias ws=webstorm
fi

local _pycharm_path="/usr/local/bin/charm"
if [[ -a $_pycharm_path ]]; then
	alias pc=charm
fi

local _atom_path="/usr/local/bin/atom"
if [[ -a $_atom_path ]]; then
	alias at=atom
fi
