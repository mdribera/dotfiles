#!/usr/bin/env bash
#
# Links all the dot things and installs all the antidote things.
set -e

DOTFILES=$HOME/.dotfiles
CUR_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
. $CUR_DIR/scripts/common.zsh

link_file () {
  local src=$1 dst=$2
  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

link_dotdir () {
  info "Linking dotdir..."

  local overwrite_all=false backup_all=false skip_all=false
  link_file "$CUR_DIR" "$DOTFILES"

  success "Linked dotdir!"
}

link_dotfiles () {
  info "Linking dotfiles..."

  local overwrite_all=false backup_all=false skip_all=false
  for src in $(find "$DOTFILES/home" -name '.*')
  do
    dst="$HOME/$(basename "${src}")"
    link_file "$src" "$dst"
  done

  success "Linked dotfiles!"
}

install_zsh () {
  info "Installing zsh..."

  if ! [ -x "$(command -v zsh)" ]; then
    if [ -x "$(command -v brew)" ]; then
      brew install zsh
    else
      sudo apt install -y zsh
    fi
  fi

  local zsh_path="$(which zsh)"
  info $zsh_path

  if [ $zsh_path != $SHELL ]; then
    sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)
  fi

  if [ $? -eq 0 ]; then
    success "Installed zsh!"
  else
    fail "Zsh install failed :("
  fi
}

get_antidote () {
  info "Getting antidote..."

  if ! [ -x "$(command -v antidote)" ]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
  fi

  success "Got antidote!"
}

link_dotdir
link_dotfiles
install_zsh
get_antidote
