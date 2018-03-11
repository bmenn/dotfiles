## Requirements

### Linux
* Distro: Archlinux or Debian-based
### OSX
* Xcode

### Windows
Incomplete list, WIP. Also not very well tested
* Git Bash

## Installation

### OSX
```
git clone https://github.com/bmenn/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install_osx.sh
```

You may encounter a security error blocking the installation of Virtualbox.
Opening "Security & Privacy" setting and allowing Oracle's signature for
installation should solve this when followed by re-executing the script.

## What's installed
All or part of the following are installed

* Anaconda Python 3
* Homebrew
* Docker for Mac
* iTerm2
* Google Chrome
* Slack
* pindexis/marker
* rupa/z
* Configuration for:
  * vim
  * tmux
  * powerline
  * Jupyter Notebook
  * git
* And stuff in Brewfile
* And Python package in `requirements.txt`
