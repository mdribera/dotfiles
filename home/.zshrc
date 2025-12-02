# Source all your favorite zsh files!
. $DOTFILES/scripts/common.zsh
. $DOTFILES/scripts/aliases.zsh
. $DOTFILES/scripts/config.zsh

# A bin you can call your very own
PATH=$PATH:$HOME/bin

# Inject homebrew
if [ -s "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Source antidote bundles
if [ -x "$(command -v brew)" ]; then
    source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
elif [ -s "$HOME/.antidote/antidote.zsh" ]; then
    source $HOME/.antidote/antidote.zsh
fi
# Load the antidote plugins
[ -x "$(command -v antidote)" ] && antidote load $DOTFILES/home/zsh_plugins.txt
