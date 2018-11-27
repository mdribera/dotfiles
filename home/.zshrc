# Source antigen for bundle loading
. $HOME/antigen.zsh
antigen init $HOME/.antigenrc

# Source all your favorite aliases and functions
. $HOME/.aliases
. $HOME/.functions

# automatically `nvm use` whenever you enter a directory that
# contains an `.nvmrc` and specifies a version of node
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin
# A bin you can call your very own
PATH=$PATH:$HOME/bin
