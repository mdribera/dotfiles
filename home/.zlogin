local node_commands=(nvm node npm)

# Lazy load your node environment
for command in $node_commands
do
  if [[ ! -x $command ]]; then
    $command() {
      info "Node environment isn't setup. Just a sec..."
      js-up && $0 "$@"
    }
  fi
done

# Call this when you want to use node
js-up () {
  if [ ! -d "$HOME/.nvm" ]; then
    fail "nvm ain't installed."
  else
    for command in $node_commands; unset -f $command

    export NVM_DIR="$HOME/.nvm"

    if [ -x "$(command -v brew)" ] && [ -s $(brew --prefix nvm) ]; then
      source $(brew --prefix nvm)/nvm.sh # This loads nvm
    elif [ -s "$NVM_DIR/nvm.sh" ]; then
      source "$NVM_DIR/nvm.sh" # This loads nvm
      source "$NVM_DIR/bash_completion" # This loads nvm bash_completion
    else
      fail "Couldn't find nvm init script..."
    fi

    # automatically `nvm use` whenever you enter a directory that
    # contains an `.nvmrc` and specifies a version of node
    autoload -U add-zsh-hook
    add-zsh-hook chpwd load-nvmrc

    info "$(nvm current)"
    success "Ready to node!"
  fi
}

load-nvmrc () {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}

# Python versioning for different pythons
py-up () {
  if [ ! -d "$HOME/.pyenv" ]; then
    fail "pyenv isn't there..."
  else
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    info "$(pyenv version)"
    success "Ready to python!"
  fi
}

# When you're going to work in Ruby do this first
rb-up () {
  if [ ! -d "$HOME/.rbenv" ]; then
    fail "Where's your rbenv??"
  else
    export RBENV_DIR="$HOME/.rbenv"

    # Add Ruby bins to PATH
    export PATH="$RBENV_DIR/bin:$PATH"
    # Initiate!
    eval "$(rbenv init -)"

    info "$(rbenv version)"
    success "Ready to ruby!"
  fi
}
