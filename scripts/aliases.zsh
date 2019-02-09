alias reload=". ~/.zshrc"

alias gst="git status"
alias gd="git diff"
alias gc="git commit -m $1"

alias l="ls -lAh"

alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias extip="curl https://ipinfo.io/ip"
alias iplz="localip && extip"

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
