set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

"" Vim appearance plugins
Plugin 'gcmt/taboo.vim'
Plugin 'vim-scripts/ScrollColors'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tomasr/molokai'

"" Editing plugins
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'tpope/vim-endwise'

"" Navigation and search plugins
" Type <Leader>\* to search for word under cursor
Plugin 'bronson/vim-visual-star-search'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

"" Syntax plugins
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/syntastic'

" Git plugins
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'gregsexton/gitv'

" Go plugins
Plugin 'fatih/vim-go'

call vundle#end()

syntax enable
set encoding=utf-8
set showcmd
set number
set hidden
set wildmenu
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

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Display
set splitright
set splitbelow
set laststatus=2
set scrolloff=3
set sidescrolloff=5

"" Colors
set t_Co=256
colorscheme molokai
" Fix wonky matching parentheses
hi MatchParen ctermfg=233 ctermbg=208 cterm=bold

"" *** PLUGIN SETTINGS ***

"" ctrlp.vim
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_cmd = 'CtrlPMixed'

"" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'env'] }

"" taboo.vim
let g:taboo_tabline = 0

"" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme="luna"

"" vim-go
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
" linter isn't always reliable
let g:go_metalinter_autosave = 0
let g:go_auto_sameids = 0
let g:go_auto_type_info = 1
" gopls works for module renaming
let g:go_rename_command = "gopls"

"" *** KEYMAPS ***

" Leader is now comma
let mapleader=","
" Toggle line numbers
noremap <Leader>n :set invnumber<CR>
" Disable cursor keys
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>
" Navigate quickfix list
noremap <silent> <Leader>; :cp<CR>
noremap <silent> <Leader>' :cn<CR>
noremap <silent> <Leader>l :cclose<CR>
" Navigate between windows
noremap <silent> <Leader>[ <C-w>h
noremap <silent> <Leader>] <C-w>l
" Move right window to left
nnoremap <Leader>ww <C-w>H<C-w>=
" Hide search highlights
nnoremap <silent> <Space> :noh<CR>
" Temporarily open an shell, type exit to return to vim
nnoremap <Leader>s :sh<CR>
" Switch between tabs
noremap <silent> <Leader><Leader>[ :tabprev<CR>
noremap <silent> <Leader><Leader>] :tabnext<CR>
" Close all windows except current
nnoremap <Leader>qw :only<CR>
" Close all tabs except current
nnoremap <Leader>qt :tabonly<CR>
" Edit ~/.vimrc in new tab
nnoremap <silent> <Leader>vimrc :tabe $MYVIMRC<CR>
" (TODO) Edit new file and set local directory
noremap <Leader>nt :tabe<CR>:lcd<space>
" (TODO) Paste line above or below
noremap <Leader>P "0P
noremap <Leader>p "0p
" (TODO) Split current file vertically
nnoremap <Leader>v :vs<CR><C-w>=
" Open alternate buffer in window
nnoremap <Leader>b :b#<CR>

"" *** EDIITNG KEYMAPS ***
" Clean trailing whitespaces with vim-trailing-whitespace and save file
nnoremap <Leader>w :FixWhitespace<CR>:w<CR>


"" *** PROGRAMMING KEYMAPS AND CONFIGS ***
""Go

" Show go test results (clear only works on Linux)
au FileType go nnoremap <Leader>tt :!clear && go test ./...<CR>
au FileType go nnoremap <Leader>w :FixWhitespace<CR>:w<CR>:<C-u>call <SID>build_go_files()<CR>
" Auto change local directory to current file
au BufEnter * silent! lcd %:p:h

"" *** PLUGIN KEYMAPS ***

"" nerdtree

" Open navigator
" Toggle navigator
noremap <Leader>x :NERDTreeToggle<CR>

"" nerdcommenter

" Toggle line comment
map <Leader>/ <Plug>NERDCommenterToggle
" (TODO) Other less-used NERDCommenter functionality
map <Leader>// <Plug>NERDCommenterYank
map <Leader>/b <Plug>NERDCommenterAlignLeft

"" vim-fugitive
" git diff current file
nnoremap <Leader>gd :Gdiff<CR>
" git log current fil
nnoremap <Leader>gl :Glog<CR>

"" vim-go

" Build and test Go source files. Only compile for test files
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" (TODO) Build or test may not be needed
au FileType go nmap <Leader>rr <Plug>(go-run)
au FileType go nmap <Leader>t <Plug>(go-test)
au Filetype go nnoremap <Leader>av :AV<CR>
au Filetype go nnoremap <Leader>a :A<CR>
au FileType go nmap <Leader>d <Plug>(go-defs)
au FileType go nmap <Leader>r :GoRename<Space>

"" gitv
" (TODO) Browse git version history
nnoremap <Leader>gv :Gitv<CR>

"" ctrlp.vim
" (TODO) Open CtrlP to search buffers
nnoremap <Leader>bb :CtrlPBuffer<CR>

"" *** RUNTIME! ***
" Press  % to navigate beween brace/bracket pairs
runtime! macros/matchit.vim

"" *** AUTOMAGIC ***
augroup reload_vimrc " {
  au!
  au BufWritePost $MYVIMRC source $MYVIMRC | :AirlineRefresh
augroup END " }
