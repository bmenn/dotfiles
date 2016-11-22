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
install_package tmux
lnif $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
mkdir -p $HOME/.tmux
lnif $DOTFILES/tmux/tmux-linux.conf $HOME/.tmux/tmux-linux.conf
lnif $DOTFILES/tmux/tmux-osx.conf $HOME/.tmux/tmux--osx.conf

# zsh
install_package zsh
lnif $DOTFILES/zsh/zshrc $HOME/.zshrc
chsh $USER --shell $(which zsh)

# vim
install_package vim
install_package exuberant-ctags
mkdir -p $HOME/.vim/bundle
lnif $DOTFILES/vimrc $HOME/.vimrc
lnif $DOTFILES/vim/vundle.vim $HOME/.vim/vundle.vim
lnif $DOTFILES/vim/after $HOME/.vim/after

# powerline
install_package python3-pip
mkdir -p $HOME/.config
lnif $DOTFILES/powerline $HOME/.config/powerline
pip3 install --user powerline-status

if [ ! -e $HOME/.vim/bundle/Vundle.vim/autoload ]; then
        echo "Installing Vundle"
        git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
fi

echo "Update/Install plugins using vundle"
vim -u $DOTFILES/vimrc +BundleInstall! +BundleClean +qall

# xbindkeys
# Remap Cap-Locks to control
NOTES=$(cat << EOF
${NOTES}

xbindkeys: Remember to add xbindkeys to start up:
        Ubuntu: System->Preferences->Session
        Generic: Added xbindkeys to ~/.xinitrc

EOF
)
install_package xbindkeys
lnif $DOTFILES/xbindkeysrc $HOME/.xbindkeysrc
lnif $DOTFILES/Xmodmap $HOME/.Xmodmap

# gitconfig
lnif $DOTFILES/gitconfig $HOME/.gitconfig

echo ${NOTES}
