#!/bin/sh
set -e

DOTFILES="${HOME}/.dotfiles"
NOTES=$(cat << EOF
###########################################################################
#
# NOTES
#
###########################################################################
EOF
)

lnif() {
        if [ -f $2 ]; then
                echo "Ignoring $1, file exists ($2)"
                return
        fi
        if [ -h $2 ]; then
                rm $2
        fi
        ln -s $1 $2
}

# Install homebrew (automatically) if it's not installed already
[ -f "$(which brew)" ] || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null

# Install brew packages from Brewfile
brew tap Homebrew/bundle
brew tap caskroom/versions
brew bundle

# Install Python3 from Anaconda
 curl -L -o ${HOME}/anaconda.sh https://repo.continuum.io/archive/Anaconda3-5.1.0-MacOSX-x86_64.sh
[ -d "${HOME}/anaconda/bin" ] || bash ${HOME}/anaconda.sh -b -p ${HOME}/anaconda
export PATH="${HOME}/anaconda/bin:${PATH}"

# Install universal Python packages
# Cannot install from requirements because qtpy conflicts with ansible
# conda install --yes -c conda-forge --file ${DOTFILES}/requirements.txt
conda install -c conda-forge powerline-status

# Install Docker-CE stable
 curl -L -o ${HOME}/Docker.dmg https://download.docker.com/mac/stable/Docker.dmg
 sudo hdiutil attach ${HOME}/Downloads/Docker.dmg
 sudo cp -R /Volumes/Docker/Docker.app /Applications
 sudo hdiutil detach /Volumes/Docker

# Install iTerm2
 curl -L -o ${HOME}/iTerm2.zip https://iterm2.com/downloads/stable/latest
 unzip ${HOME}/iTerm2.zip -d /Applications

# Install Google Chrome
 curl -L -o ${HOME}/Downloads/googlechrome.dmg https://dl.google.com/chrome/mac/stable/CHFA/googlechrome.dmg
 sudo hdiutil attach ${HOME}/Downloads/googlechrome.dmg
 sudo cp -R "/Volumes/Google Chrome/Google Chrome.app" /Applications
 sudo hdiutil detach "/Volumes/Google Chrome"

# Install Slack
curl -L -o ${HOME}/Downloads/Slack.dmg https://slack.com/ssb/download-osx
sudo hdiutil attach ${HOME}/Downloads/Slack.dmg
sudo cp -R /Volumes/Slack*/Slack.app /Applications
sudo hdiutil detach /Volumes/Slack*

# tmux
lnif ${DOTFILES}/tmux/tmux.conf ${HOME}/.tmux.conf
mkdir -p ${HOME}/.tmux
lnif ${DOTFILES}/tmux/tmux-linux.conf ${HOME}/.tmux/tmux-linux.conf
lnif ${DOTFILES}/tmux/tmux-osx.conf ${HOME}/.tmux/tmux-osx.conf

# bash
lnif ${DOTFILES}/bash/bashrc ${HOME}/.bashrc
lnif ${DOTFILES}/bash/bashrc ${HOME}/.bash_profile

# zsh
lnif ${DOTFILES}/zsh/zshrc ${HOME}/.zshrc

# vim
mkdir -p ${HOME}/.vim/bundle
lnif ${DOTFILES}/vimrc ${HOME}/.vimrc
lnif ${DOTFILES}/vim/vundle.vim ${HOME}/.vim/vundle.vim
lnif ${DOTFILES}/vim/after ${HOME}/.vim/after

if [ ! -e ${HOME}/.vim/bundle/Vundle.vim/autoload ]; then
        echo "Installing Vundle"
        git clone https://github.com/gmarik/Vundle.vim ${HOME}/.vim/bundle/Vundle.vim
fi

echo "Update/Install plugins using vundle"
vim -u ${DOTFILES}/vimrc +BundleInstall! +BundleClean +qall

# powerline
mkdir -p ${HOME}/.config
lnif ${DOTFILES}/powerline ${HOME}/.config/powerline

# jupyter
mkdir -p ${HOME}/.local/share/jupyter/
lnif ${DOTFILES}/jupyter/nbextensions ${HOME}/.local/share/jupyter/nbextensions

# git
lnif ${DOTFILES}/git/gitconfig ${HOME}/.gitconfig
lnif ${DOTFILES}/git/gitignore ${HOME}/.gitignore

# install marker
# marker needs to be updated to Python 3 for this to work
# python ${DOTFILES}/vendor/marker/install.py

echo ${NOTES}
