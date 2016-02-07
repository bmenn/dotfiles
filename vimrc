set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
set laststatus=2
set encoding=utf8

" Load Powerline
if !has('nvim')
if isdirectory(expand("$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim"))
        set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim
elseif isdirectory(expand("$HOME/.local/lib/python3.4/site-packages/powerline/bindings/vim"))
        set rtp+=~/.local/lib/python3.4/site-packages/powerline/bindings/vim
elseif isdirectory(expand("/usr/lib/python3.5/site-packages/powerline/bindings/vim"))
        set rtp+=/usr/lib/python3.5/site-packages/powerline/bindings/vim
elseif isdirectory(expand("$HOME/Library/Python/3.4/lib/python/site-packages/powerline/bindings/vim"))
	set rtp+=~/Library/Python/3.4/lib/python/site-packages/powerline/bindings/vim
endif
endif

if filereadable(expand("~/.vim/vundle.vim"))
        source ~/.vim/vundle.vim
endif

" Strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

filetype plugin indent on

" ctrlp
let g:ctrlp_match_window = 'top,order:ttb'
let g:ctrlp_extensions = ['tag', 'mixed']
let g:ctrlp_max_files = 0
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_root_markers = ['pom.xml']
" May need to add a fallback
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']
let g:ctrlp_working_path_mode = 'wr'
set wildignore+=*/tmp/*,*/data/*,*.so,*.swp,*.zip,*.csv,*.pyc,tags,*.class

" syntastic
let g:syntastic_python_checkers=['pylint', 'pep8', 'python']
let g:syntastic_python_pylint_post_args = '--msg-template="{path}:{line}:{column}:{C}: {msg_id} [{symbol}] {msg}"'

" tagbar
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
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
"
" ctags
set tags=../tags,./tags,tags
let g:easytags_auto_update = 0
let g:easytags_auto_highlight = 0

" ultisnips
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" eclim
let g:EclimCompletionMethod = 'omnifunc'

" dbext
let g:dbext_default_profile_mysql_prod1 = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/prod1-reader'
let g:dbext_default_profile_mysql_prod1_master = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/prod1-writer'
let g:dbext_default_profile_mysql_prod2 = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/prod2-reader'
let g:dbext_default_profile_mysql_prod2_master = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/prod2-writer'
let g:dbext_default_profile_mysql_prod3 = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/prod3-reader'
let g:dbext_default_profile_mysql_prod3_master = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/prod3-writer'
let g:dbext_default_profile_mysql_prod6 = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/prod6-reader'
let g:dbext_default_profile_mysql_prod6_master = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/prod6-writer'
let g:dbext_default_profile_mysql_iprod1 = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/iprod1-reader'
let g:dbext_default_profile_mysql_iprod1_master = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/iprod1-writer'
let g:dbext_default_profile_mysql_iprod2 = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/iprod2-reader'
let g:dbext_default_profile_mysql_iprod2_master = 'type=MYSQL:extra=--defaults-file=~/mysql/connections/iprod2-writer'

" vim-rooter
" let g:rooter_patterns = ['pom.xml', '.git', '.git/']

" Change configuration type files to correct syntax
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Clipboard support (for OS X only?)
" Empty equals is intentional
set clipboard=

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

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

command! -nargs=1 Filter call Filter(<f-args>)
