autoload -U colors
colors

##
# Prompt
##
setopt PROMPT_SUBST
local prompt_dir="%{$fg_bold[cyan]%}%(6~|%-4~/…/%1~|%5~)%{$reset_color%}"

if [[ -n $SSH_CONNECTION ]]; then
  local prompt_host="%{$fg_bold[white]%}%n@%m%{$reset_color%}"
else
  local prompt_host=""
fi

local ret_status="%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)%{$reset_color%}"
PROMPT='${prompt_dir} $(git_prompt_info)
${prompt_host}${ret_status} '

GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
GIT_PROMPT_SUFFIX="%{$reset_color%} "
GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Outputs current branch info in prompt format
git_prompt_info () {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
parse_git_dirty () {
  local STATUS=''
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    echo "$GIT_PROMPT_DIRTY"
  else
    echo "$GIT_PROMPT_CLEAN"
  fi
}

##
# ls colors
##
export CLICOLOR=1
export LS_COLORS="di=1;36:ln=1;35:so=1;32:pi=1;33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LSCOLORS=GxFxCxDxbxegedabagacad

##
# Lazy loading for language runtimes
# .zshenv puts the default binaries on PATH for non-interactive use.
# These stubs and *-up functions are for interactive shells: they load the
# full version manager on first use so you get version-switching, completions, etc.
##
node_commands=(nvm node npm)

for _cmd in $node_commands; do
  if ! command -v $_cmd &>/dev/null; then
    $_cmd() {
      info "Node environment isn't setup. Just a sec..."
      js-up && $0 "$@"
    }
  fi
done
unset _cmd

js-up () {
  if [ ! -d "$HOME/.nvm" ]; then
    fail "nvm ain't installed."
  else
    for cmd in $node_commands; do unset -f $cmd 2>/dev/null; done

    export NVM_DIR="$HOME/.nvm"

    if [ -x "$(command -v brew)" ] && [ -s "$(brew --prefix nvm)/nvm.sh" ]; then
      source "$(brew --prefix nvm)/nvm.sh"
    elif [ -s "$NVM_DIR/nvm.sh" ]; then
      source "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
    else
      fail "Couldn't find nvm init script..."
      return 1
    fi

    autoload -U add-zsh-hook
    add-zsh-hook chpwd load-nvmrc
    load-nvmrc

    info "$(nvm current)"
    success "Ready to node!"
  fi
}

load-nvmrc () {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}

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

rb-up () {
  if [ ! -d "$HOME/.rbenv" ]; then
    fail "Where's your rbenv??"
  else
    export RBENV_DIR="$HOME/.rbenv"
    export PATH="$RBENV_DIR/bin:$PATH"
    eval "$(rbenv init -)"

    info "$(rbenv version)"
    success "Ready to ruby!"
  fi
}

##
# Completion
##
autoload -U compinit
compinit
zmodload -i zsh/complist
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

##
# History
##
HISTFILE=~/.zsh_history         # where to store zsh config
HISTSIZE=1024                   # big history
SAVEHIST=1024                   # big history
setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '[D' backward-word
bindkey '[C' forward-word
bindkey '^[a' beginning-of-line
bindkey '^[e' end-of-line
