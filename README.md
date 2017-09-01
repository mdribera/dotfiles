# dotfiles

## Setup
`/bin/link-dots` will create symlinks from all the files in `/shell` to your `$HOME` directory

## Files included
- `/shell/.aliases` - helpful shortcuts for git, text editors, and osx
- `/shell/.antigenrc` - sourcing for zsh utilities and theme
- `/shell/.functions` - useful shortcuts and commands
- `/shell/.gitconfig` - global git configurations
- `/shell/.gitignore_global` - things to globally ignore
- `/shell/.zlogin` - sourced after `.zshrc` during an interactive shell login
- `/shell/.zshenv` - source first in all shell modes
- `/shell/.zshrc` - pulls in `.aliases`, `.functions`, and `.antigenrc`

## TODO
- secrets (ssh, env, etc) encryption and compression for syncing & updating across systems
- file watching for syncing & updating configurations across systems
- install script for setting up a new machine (homebrew, antigen.zsh, casks)
- hammerspoon utilities
- other system configurations
