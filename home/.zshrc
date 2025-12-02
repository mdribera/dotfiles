# Source antidote bundles
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load $DOTFILES/home/zsh_plugins.txt

# Source all your favorite zsh files!
. $DOTFILES/scripts/common.zsh
. $DOTFILES/scripts/aliases.zsh
. $DOTFILES/scripts/config.zsh

# A bin you can call your very own
PATH=$PATH:$HOME/bin
