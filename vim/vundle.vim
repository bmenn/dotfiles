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

" Python stuff
Plugin 'klen/python-mode'
Plugin 'Jinja'

" Scala
Plugin 'derekwyatt/vim-scala'

" HTML/JS/CSS stuff
Plugin 'mattn/emmet-vim'
Plugin 'elzr/vim-json'

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

" Old stuff
"Bundle 'wookiehangover/jshint.vim'
"Bundle 'tpope/vim-surround'

call vundle#end()
