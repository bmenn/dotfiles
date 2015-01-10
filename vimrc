set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
set laststatus=2

" Load Powerline
if isdirectory(expand("$HOME/.local/lib/python3.4/site-packages/powerline/bindings/vim"))
        set rtp+=~/.local/lib/python3.4/site-packages/powerline/bindings/vim
elseif isdirectory(expand("$HOME/.local/lib/python2.6/site-packages/powerline/bindings/vim"))
        set rtp+=~/.local/lib/python2.6/site-packages/powerline/bindings/vim
endif

if filereadable(expand("~/.vim/vundle.vim"))
        source ~/.vim/vundle.vim
endif

filetype plugin indent on

" ctrlp
let g:ctrlp_match_window = 'top,order:ttb'
set wildignore+=*/tmp/*,*/data/*,*.so,*.swp,*.zip,*.csv

" pymode
let g:pymode_rope = 1
let g:pymode_rope_autoimport = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_doc = 0

" globsearch otions
set wildignore+=*.pdf,*.epub,*.gnucash

" tagbar
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.local/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
" ctags
set tags=./.tags,.tags

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Clipboard support (for OS X only?)
set clipboard=unnamed

set writebackup	" keep a write backup file
set ruler       " show the cursor position all the time

"
" Interface Settings
"

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Solarized settings
syntax enable
set background=dark
colorscheme solarized

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set t_Co=256
  syntax on
  set hlsearch
endif

set number
set ignorecase
set cursorline 
set colorcolumn=76
set textwidth=76
set expandtab
set autoindent

" Set *.md as markdown extension
au BufRead,BufNewFile *.md set filetype=markdown

"
" Custom keybindings
"

" Set indent/unindent for visual
nnoremap <silent> <S-T> :TagbarToggle<CR>
vmap <Tab> >gv
vmap <S-Tab> <gv

function Filter(pattern)
let @a = ''
        execute 'g/'. a:pattern . '/y A'
        new
        setlocal bt=nofile
        setlocal filetype=todo
        put! a
        g/^$/d
        sort
endfunction

command! -nargs=1 Filter call Filter(<f-args>)
