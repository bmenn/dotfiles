#!/bin/sh
set -ex

# TODO Add git submodule init and update
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
# [ -f "$(which brew)" ] || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install brew packages from Brewfile
brew bundle --file homebrew/Brewfile

# Install Python3 from Anaconda
# curl -L -o ${HOME}/anaconda.sh https://repo.continuum.io/archive/Anaconda3-5.1.0-MacOSX-x86_64.sh
# [ -d "${HOME}/anaconda/bin" ] || bash ${HOME}/anaconda.sh -b -p ${HOME}/anaconda
# export PATH="${HOME}/anaconda/bin:${PATH}"

# Install universal Python packages
# Cannot install from requirements because qtpy conflicts with ansible
# conda install --yes -c conda-forge --file ${DOTFILES}/requirements.txt
# conda install -y -c conda-forge powerline-status

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
lnif ${DOTFILES}/vim/Ultisnips ${HOME}/.vim/UltiSnips

if [ ! -e ${HOME}/.vim/bundle/Vundle.vim/autoload ]; then
        echo "Installing Vundle"
        git clone https://github.com/gmarik/Vundle.vim ${HOME}/.vim/bundle/Vundle.vim
fi

echo "Update/Install plugins using vundle"
/usr/bin/vim -u ${DOTFILES}/vimrc +BundleInstall! +BundleClean +qall

# powerline
mkdir -p ${HOME}/.config
lnif ${DOTFILES}/powerline ${HOME}/.config/powerline

# jupyter
mkdir -p ${HOME}/.local/share/jupyter/
lnif ${DOTFILES}/jupyter/nbextensions ${HOME}/.local/share/jupyter/nbextensions

# git
lnif ${DOTFILES}/git/gitconfig ${HOME}/.gitconfig
lnif ${DOTFILES}/git/gitignore ${HOME}/.gitignore

# applescripts
lnif ${DOTFILES}/applescript ${HOME}/Library/Scripts

# alacritty
brew install rust
mkdir -p ${HOME}/build
git clone https://github.com/jwilm/alacritty ${HOME}/build/github.com/jwilm/alacritty
OLDPWD=$(pwd)
cd ${HOME}/build/github.com/jwilm/alacritty
make dmg
cp -r target/release/osx/Alacritty.app /Applications/Alacritty.app
cd ${OLDPWD}

# install marker
# marker needs to be updated to Python 3 for this to work
# python ${DOTFILES}/vendor/marker/install.py

echo ${NOTES}
