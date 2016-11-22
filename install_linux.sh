#!/bin/sh
DOTFILES="$HOME/.dotfiles"
DISTRO=$(cat /etc/issue | cut -f 1 -d ' ')
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

install_package() {
        echo "Installing package: ${1}"
	case $DISTRO in
	Ubuntu)
		sudo apt-get install -y "$1"
		;;
	*)
		echo "Unrecognized distro, cowardly giving up"
		exit 1
		;;
	esac
}

# tmux
which tmux || install_package tmux
lnif $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
mkdir -p $HOME/.tmux
lnif $DOTFILES/tmux/tmux-linux.conf $HOME/.tmux/tmux-linux.conf
lnif $DOTFILES/tmux/tmux-osx.conf $HOME/.tmux/tmux--osx.conf

# zsh
which zsh || install_package zsh
lnif $DOTFILES/zsh/zshrc $HOME/.zshrc
chsh $USER --shell $(which zsh)

# vim
which vim || install_package vim
which ctags || install_package exuberant-ctags
mkdir -p $HOME/.vim/bundle
lnif $DOTFILES/vimrc $HOME/.vimrc
lnif $DOTFILES/vim/vundle.vim $HOME/.vim/vundle.vim
lnif $DOTFILES/vim/after $HOME/.vim/after

# powerline
which pip3 || install_package python3-pip
mkdir -p $HOME/.config
lnif $DOTFILES/powerline $HOME/.config/powerline
pip3 install --user powerline-status

if [ ! -e $HOME/.vim/bundle/Vundle.vim/autoload ]; then
        echo "Installing Vundle"
        git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
fi

echo "Update/Install plugins using vundle"
vim -u $DOTFILES/vimrc +BundleInstall! +BundleClean +qall

# xmodmap
# Remap Cap-Locks to control
NOTES=$(cat << EOF
${NOTES}

xmodmap: Remember to add XModMap to start up:
        Ubuntu: System->Preferences->Session
        Generic: Added `xmodmap ~/.Xmodmap` to ~/.xinitrc

EOF
)
lnif $DOTFILES/Xmodmap $HOME/.Xmodmap

# gitconfig
lnif $DOTFILES/gitconfig $HOME/.gitconfig

# install z
git clone https://github.com/rupa/z $DOTFILES/external/z
lnif $DOTFILES/external/z/z.sh $HOME/.local/bin/z

echo ${NOTES}
