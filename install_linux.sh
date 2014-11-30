#!/bin/sh
DOTFILES="$HOME/.dotfiles"
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

# tmux
lnif $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
lnif $DOTFILES/tmux/tmux-linux.conf $HOME/.tmux-linux.conf
lnif $DOTFILES/tmux/tmux-osx.conf $HOME/.tmux-osx.conf

# vim
lnif $DOTFILES/vimrc $HOME/.vimrc
lnif $DOTFILES/vim $HOME/.vim

if [ ! -e $DOTFILES/vim/bundle/Vundle.vim/autoload ]; then
        echo "Installing Vundle"
        git clone https://github.com/gmarik/Vundle.vim $DOTFILES/vim/bundle/Vundle.vim
fi

echo "Update/Install plugins using vundle"
vim -u $DOTFILES/vimrc +BundleInstall! +BundleClean +qall
