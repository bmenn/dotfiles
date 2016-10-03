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
mkdir -p $HOME/.tmux
lnif $DOTFILES/tmux/tmux-linux.conf $HOME/.tmux/tmux-linux.conf
lnif $DOTFILES/tmux/tmux-osx.conf $HOME/.tmux/tmux--osx.conf

# vim
mkdir -p $HOME/.vim/bundle
lnif $DOTFILES/vimrc $HOME/.vimrc
lnif $DOTFILES/vim/vundle.vim $HOME/.vim/vundle.vim
lnif $DOTFILES/vim/after $HOME/.vim/after

# powerline
mkdir -p $HOME/.config
lnif $DOTFILES/powerline $HOME/.config/powerline

if [ ! -e $HOME/.vim/bundle/Vundle.vim/autoload ]; then
        echo "Installing Vundle"
        git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
fi

echo "Update/Install plugins using vundle"
vim -u $DOTFILES/vimrc +BundleInstall! +BundleClean +qall
