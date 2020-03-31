# Call this when you want to use nvm
js-up () {
  # automatically `nvm use` whenever you enter a directory that
  # contains an `.nvmrc` and specifies a version of node
  autoload -U add-zsh-hook
  add-zsh-hook chpwd load-nvmrc

  export NVM_DIR="$HOME/.nvm"

  if [ -x "$(command -v brew)" ] && [ -s $(brew --prefix nvm) ]; then
    source $(brew --prefix nvm)/nvm.sh
  elif [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
  else
    fail "Couldn't find nvm..."
  fi

  success "Ready to node!"
  info "$(nvm current)"
}

load-nvmrc () {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}

# Python versioning for different pythons
py-up () {
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  success "Ready to python!"
}

# When you're going to work in ruby do this first
rb-up () {
  export RVM_DIR="$HOME/.rvm"
  [[ -s "$RVM_DIR/scripts/rvm" ]] && source "$RVM_DIR/scripts/rvm"
  # Add RVM to PATH
  PATH=$PATH:$RVM_DIR/bin

  success "Ready to ruby!"
}
