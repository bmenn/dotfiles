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

echo "Update/Install plugins using vundle"
vim -u $DOTFILES/vimrc +BundleInstall! +BundleClean +qall
