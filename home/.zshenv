# Deduplicate PATH entries (zsh feature - must be set early)
typeset -U path

# Where all of the dotfiles live
export DOTFILES="$HOME/.dotfiles"

# Where all the code lives
export DEV="$HOME/dev"

# To add system agnostic configuration
export OS_TYPE="$(uname)"

export HISTORY_SUBSTRING_SEARCH_FUZZY=false

# nvm: resolve default node version and put its bin on PATH without sourcing nvm
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR/versions/node" ]; then
  _nvm_default=$(cat "$NVM_DIR/alias/default" 2>/dev/null)
  if [ -n "$_nvm_default" ]; then
    _nvm_node_bin=$(ls -d "$NVM_DIR/versions/node/v${_nvm_default}"*/bin 2>/dev/null | sort -V | tail -1)
    [ -n "$_nvm_node_bin" ] && export PATH="$_nvm_node_bin:$PATH"
  fi
  unset _nvm_default _nvm_node_bin
fi

# pyenv: shims resolve to the correct python version automatically
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
fi

# rbenv: same shims approach
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
fi
