filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" Things required by Vundle
call vundle#begin()

" Vundle must manage Vundle!
Plugin 'gmarik/Vundle.vim'

" Add jedi-vim in the future
"
" Generic coding stuff
" Plugin 'scrooloose/syntastic'
Plugin 'w0rp/ale'
Plugin 'tomtom/tcomment_vim'
Plugin 'majutsushi/tagbar'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'bmenn/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'universal-ctags/ctags'
Plugin 'scrooloose/nerdtree'
Plugin 'Raimondi/delimitMate'
Plugin 'Yggdroot/indentLine'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'airblade/vim-rooter'
Plugin 'DataWraith/auto_mkdir'
Plugin 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'

" Python stuff
"Plugin 'klen/python-mode'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'Jinja'
Plugin 'davidhalter/jedi'

" HTML/JS/CSS stuff
Plugin 'mattn/emmet-vim'
Plugin 'elzr/vim-json'
Plugin 'marijnh/tern_for_vim'

" Markdown stuff
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

Plugin 'lervag/vimtex'

" Notetaking stuff
Plugin 'junegunn/goyo.vim'

call vundle#end()
