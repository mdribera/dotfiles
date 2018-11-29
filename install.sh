#!/usr/bin/env bash
#
# Links all the dot things and installs all the antibody things.
set -e

DOTFILES=$HOME/.dotfiles
CUR_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
. $CUR_DIR/scripts/common.zsh

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

get_antibody () {
  info "Getting antibody..."

  if ! [ -x "$(command -v antibody)" ]; then
    if [ -x "$(command -v brew)" ]; then
      brew install getantibody/tap/antibody || brew upgrade antibody
    else
      curl -sL https://git.io/antibody | sh -s
    fi
  fi

  success "Got antibody!"
}

get_bundles () {
  info "Installing and updating zsh bundles..."

  antibody bundle < $DOTFILES/home/zsh_plugins.txt > $HOME/.zsh_plugins.sh
  antibody update

  success "Installed and updated zsh bundles!"
}

link_dotdir
link_dotfiles
get_antibody
get_bundles
