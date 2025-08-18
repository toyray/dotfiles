set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

"" Vim appearance plugins
Plugin 'gcmt/taboo.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tomasr/molokai'

"" Editing plugins
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'sjl/gundo.vim'

"" Navigation and search plugins
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'

"" Coding plugins
Plugin 'tpope/vim-endwise'
Plugin 'scrooloose/nerdcommenter.git'

" Git plugins
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" Go plugins
Plugin 'fatih/vim-go'

" YARA
Plugin 's3rvac/vim-syntax-yara'

" Language server
Plugin 'dense-analysis/ale'

call vundle#end()

syntax enable
set encoding=utf-8
set showcmd
set relativenumber "Use relative line numbers for easier motions
set hidden
set wildmenu
set history=200 "Remember last 200 commands
set ttimeout
set ttimeoutlen=100
filetype plugin indent on
set noswapfile
set shell=bash\ -l

"" Whitespace
set nowrap
set tabstop=2 shiftwidth=2
set expandtab
set backspace=indent,eol,start
set nofixeol

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
"Global replace in line by default. Turn off by supplying g in substitute command
set gdefault

"" Display
set splitright
set splitbelow
set laststatus=2
set scrolloff=3
set sidescrolloff=5
set textwidth=88
set colorcolumn=93
set lazyredraw
set cursorline

"" Command window
" Truncate all messages to reduce prompting
set shortmess+=T
set cmdheight=2
set visualbell t_vb=

"" Colors
set t_Co=256
silent! colorscheme molokai
" Fix wonky matching parentheses
hi MatchParen ctermfg=233 ctermbg=208 cterm=bold,reverse

"" *** PLUGIN SETTINGS ***
"" ack
let g:ackhighlight = 1
let g:ack_default_options = " -s -H --nocolor --nogroup --column --smart-case --follow --ignore-file=ext:a"

"" ctrlp
let g:ctrlp_cmd = 'CtrlP'
" Allow search by line as well
let g:ctrlp_extensions = ['line']
let g:ctrlp_max_files = 10000
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = "ra"

"" gitgutter
let g:gitgutter_map_keys = 0

"" gundo
let g:gundo_prefer_python3 = 1

"" netrw
let g:netrw_liststyle = 2
let g:netrw_banner = 0
let g:netrw_winsize = 15
let g:netrw_browse_split = 2

"" taboo
let g:taboo_tabline = 0

"" vim-airline
let g:airline_powerline_fonts = 0
let g:airline_theme="dark"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#ale#enabled = 1

"" Linter
let g:ale_linters = { "python": ["mypy", "ruff"] }
"" Formatter
let g:ale_fixers = { "python": ["ruff_format", "isort"] }
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1

"" vim-go
let g:go_auto_sameids = 0
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
" linter isn't always reliable
let g:go_metalinter_autosave = 0
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'deadcode']
" gopls works for module renaming
let g:go_rename_command = "gopls"
let g:go_template_use_pkg = 1
let g:go_test_show_name = 1

"" *** KEYMAPS ***

" Leader is now comma
let mapleader=","
" Toggle line numbers
noremap <Leader>n :set invnumber<CR>
" Disable cursor keys
"noremap <Left>  <NOP>
"noremap <Right> <NOP>
"noremap <Up>    <NOP>
"noremap <Down>  <NOP>
"inoremap <Left>  <NOP>
"inoremap <Right> <NOP>
"inoremap <Up>    <NOP>
"inoremap <Down>  <NOP>
" Navigate quickfix list
noremap <silent> <Leader>; :cp<CR>
noremap <silent> <Leader>' :cn<CR>
noremap <silent> <Leader>l :cclose<CR>
" Move right window to left
nnoremap <Leader>ww <C-w>H<C-w>=
" Hide search highlights
nnoremap <silent> <Space> :noh<CR>
" Temporarily open an shell, type exit to return to vim
nnoremap <Leader>s :sh<CR>
" Close all windows except current
nnoremap <Leader>qw :only<CR>
" Close all tabs except current
nnoremap <Leader>qt :tabonly<CR>
" Edit ~/.vimrc in new tab
nnoremap <silent> <Leader>vimrc :tabe $MYVIMRC<CR>
" Switch to previously edited buffer
nnoremap <Leader>b :b#<CR>
" (TODO) Use PCRE for regex
nnoremap / /\v
" Change working directory to directory of current file
nnoremap <Leader>lcd :lcd %:h<CR>:pw<CR>
" Change working directory back to original working directory
nnoremap <Leader>cd :cd<CR>:pw<CR>
" Open netrw as visual split
nmap <Leader>x :Vexplore<CR>
" Disable macro recording
noremap q <NOP>
" Navigate windows
noremap <silent> [h <C-w>h
noremap <silent> ]j <C-w>j
noremap <silent> ]k <C-w>k
noremap <silent> ]l <C-w>l

"" *** PROGRAMMING KEYMAPS AND CONFIGS ***
""Bash
au FileType sh setlocal nowrap formatoptions-=t

"" Dockerfile
au FileType dockerfile setlocal nowrap formatoptions-=t

""Go

" Show go test results (clear only works on Linux)
au FileType go nnoremap <Leader>tt :!clear && go test ./...<CR>
au FileType go setlocal autoread


"" YARA
au BufNewFile,BufRead *.yar,*.yara setlocal filetype=yara

"" *** PLUGIN KEYMAPS ***

"" ack
nnoremap <C-f> :Ack!<space>
noremap <Leader>fw :Ack! "<cword>"<CR>
noremap <Leader>todo :Ack! todo<CR>

"" CtrlP
nnoremap <Leader>pg :let g:ctrlp_working_path_mode = 'ra'<CR>:CtrlP<CR>
nnoremap <Leader>pd :let g:ctrlp_working_path_mode = 'a'<CR>:CtrlP<CR>

"" gundo
nnoremap <F5> :GundoToggle<CR>

"" nerdcommenter

" Toggle line comment
map <Leader>/ <Plug>NERDCommenterToggle
" (TODO) Other less-used NERDCommenter functionality
map <Leader>// <Plug>NERDCommenterYank

"" vim-go
augroup auto_go
  au!
  au BufWritePost *.go  :exe "FixWhitespace" | :GoBuild!
  au BufWritePost *_test.go  :exe "GoTestCompile!"
augroup end

" gd for go-def
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap gf <Plug>(go-referrers)
au FileType go nmap <Leader>t :wa<CR><Plug>(go-test)
au FileType go nmap <Leader>tf :wa<CR><Plug>(go-test)
au FileType go nmap <Leader>av <Plug>(go-alternate-vertical)
au FileType go nmap <Leader>a <Plug>(go-alternate-edit)
"" (TODO) already mapped as gd
au FileType go nmap gdv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dd <Plug>(go-decls)
au FileType go nmap <Leader>da <Plug>(go-decls-dir)
au FileType go nmap gr :GoRename<Space>
au FileType go nmap <Leader>gl <Plug>(go-metalinter)

"" ale
au FileType python nmap <silent> <Leader>j <Plug>(ale_previous_wrap)
au FileType python nmap <silent> <Leader>k <Plug>(ale_next_wrap)


"" *** RUNTIME! ***
" Press  % to navigate beween brace/bracket pairs
runtime! macros/matchit.vim

"" *** AUTOMAGIC ***
augroup reload_vimrc " {
  au!
  au BufWritePost $MYVIMRC source $MYVIMRC | :AirlineRefresh
augroup END " }
