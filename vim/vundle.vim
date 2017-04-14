filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" Things required by Vundle
call vundle#begin()

" Vundle must manage Vundle!
Plugin 'gmarik/Vundle.vim'

" Add jedi-vim in the future
"
" Generic coding stuff
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'bmenn/vim-colors-solarized'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'Raimondi/delimitMate'
Plugin 'Yggdroot/indentLine'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'airblade/vim-rooter'
Plugin 'DataWraith/auto_mkdir'
Plugin 'tpope/vim-surround'

" Python stuff
"Plugin 'klen/python-mode'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'Jinja'
Plugin 'davidhalter/jedi'

" Scala
Plugin 'derekwyatt/vim-scala'
"Plugin 'ensime/ensime-vim'

" HTML/JS/CSS stuff
Plugin 'mattn/emmet-vim'
Plugin 'elzr/vim-json'
Plugin 'marijnh/tern_for_vim'

" Markdown stuff
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" SQL - Align is required by SQLUtilities
Plugin 'SQLUtilities'
Plugin 'Align'
Plugin 'dbext.vim'

" Notetaking stuff
Plugin 'freitass/todo.txt-vim'
Plugin 'LanguageTool'
Plugin 'coot/atp_vim'
" No Python 3 support
" Plugin 'neilagabriel/vim-geeknote'

" Old stuff
"Bundle 'wookiehangover/jshint.vim'

call vundle#end()
