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

# Source and load antidote bundles
if [ -s "$HOME/.antidote/antidote.zsh" ]; then
    source $HOME/.antidote/antidote.zsh
    antidote load "$DOTFILES/home/zsh_plugins.txt"
fi
