# Where all of the dotfiles live
export DOTFILES="$HOME/.dotfiles"

# Where all the code lives
export DEV="$HOME/dev"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='atom'
fi
