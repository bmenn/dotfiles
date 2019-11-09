set nocompatible
set modelines=5
set rtp+=~/.vim/bundle/Vundle.vim
set laststatus=2
set encoding=utf8

set lazyredraw
set ttyfast

" Load Powerline
if !has('nvim')
        set rtp+=$PYTHON3_USER_LIB/powerline/bindings/vim
" if isdirectory(expand("$HOME/anaconda/lib/python3.6/site-packages/powerline/bindings/vim"))
" 	set rtp+=~/anaconda/lib/python3.6/site-packages/powerline/bindings/vim
" elseif isdirectory(expand("$HOME/.local/lib/python3.6/site-packages/powerline/bindings/vim"))
"         set rtp+=~/.local/lib/python3.6/site-packages/powerline/bindings/vim
" endif
endif

if filereadable(expand("~/.vim/vundle.vim"))
        source ~/.vim/vundle.vim
endif

" Strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

filetype plugin indent on

" ale
let g:ale_sign_error = "!"
let g:ale_sign_warning = "*"

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_server_keep_logfiles = 1
if has('macunix')
    let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'
endif

" ack.vim
let g:ackprg = "rg --vimgrep"

" ctrlp
let g:ctrlp_match_window = 'top,order:ttb'
let g:ctrlp_extensions = []
let g:ctrlp_max_files = 0
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_root_markers = ['.git', 'pom.xml']

" May need to add a fallback
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard --recurse-submodules']
let g:ctrlp_working_path_mode = 'wr'
set wildignore+=*/tmp/*,*/data/*,*.so,*.swp,*.zip,*.csv,*.pyc,tags,*.class

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

" NERDTree
let NERDTreeIgnore=['.pyc$', '^__pycache__$']

" ctags
set tags=./tags,../tags,../../tags
let g:easytags_dynamic_files = 1
let g:easytags_auto_update = 0
let g:easytags_auto_highlight = 0

" ultisnips
let g:UltiSnipsSnippetDirectories=["bundle/vim-snippets/UltiSnips", $HOME."/.vim/UltiSnips"]
let g:UltiSnipsSnippetDir=$HOME."/.vim/UltiSnips"
let g:ultisnips_python_quoting_style="single"
let g:ultisnips_python_triple_quoting_style="double"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" eclim
let g:EclimCompletionMethod = 'omnifunc'


" vimtex
set conceallevel=1
let g:tex_conceal = "abdmg"
let g:vimtex_compiler_latexrun_engines = {
    \ '_': '-xelatex',
    \ 'pdflatex': '-pdflatex',
    \ 'lualatex': '-lualatex',
    \ 'xelatex': '-xelatex',
    \}

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
colorscheme solarized
" let &background = $TERMCOLOR
let &background = join(readfile($DOTFILES_COLORSCHEME_FILE), "\n")

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set t_Co=256
  syntax on
  set hlsearch
endif

set number
set ignorecase
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
vmap <Tab> >gv
vmap <S-Tab> <gv
nnoremap <silent> <S-T> :TagbarToggle<CR>

function! Filter(pattern)
let @a = ''
        execute 'g/'. a:pattern . '/y A'
        new
        setlocal bt=nofile
        setlocal filetype=todo
        put! a
        g/^$/d
        sort
endfunction

map <C-p> :FZF<CR>

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Toggle background color
map <leader>bg :let &background= ( &background == "dark" ? "light" : "dark" )<CR>

command! -nargs=1 Filter call Filter(<f-args>)
