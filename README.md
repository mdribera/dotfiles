# dotfiles

## Getting started
Execute `/install.sh` and it'll do all of the work.

## What's included
Files and directories matching `/home/.*` will be linked in your `$HOME` directory.

### zsh scripts and configuration
- `/home/.zshenv` - sourced first in all shell modes
- `/home/.zshrc` - the main event
- `/home/.zlogin` - sourced after `.zshrc` during an interactive shell login
- `/home/zsh_plugins.txt` - a list of zsh plugins for antibody to install
- `/scripts/common.zsh` - useful shortcuts and shared functions
- `/scripts/aliases.zsh` - some aliases for git, text editors, and osx
- `/scripts/config.zsh` - command line configuration
### git
- `/home/.gitconfig` - global git configurations
- `/home/.gitignore_global` - things to globally ignore

## TODO
- automated homebrew/linuxbrew installation and brewfile
- secrets encryption and compression
- hammerspoon plugins
- bitbar plugins
