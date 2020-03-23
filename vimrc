set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/ScrollColors'
Plugin 'tpope/vim-rails'
Plugin 'mileszs/ack.vim'
Plugin 'sjl/gundo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-rvm'
Plugin 'tpope/vim-endwise'
Plugin 'gcmt/taboo.vim'
Plugin 'scrooloose/syntastic'
Plugin 'thoughtbot/vim-rspec'
Plugin 'gregsexton/gitv'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-rake'
Plugin 'tomasr/molokai'
Plugin 'bronson/vim-visual-star-search'
Plugin 'benmills/vim-golang-alternate'
Plugin 'ConradIrwin/vim-bracketed-paste'

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
set directory=$HOME/.vim/swapfiles//
let mapleader=","
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

"" ctrlp.vim
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0

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

"" ack.vim
let g:ackhighlight = 1
let g:ack_default_options = " -s -H --nocolor --nogroup --column --smart-case --follow --ignore-file=ext:a"

"" *** KEYMAPS ***
noremap <Leader>n :set invnumber<CR>
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Leader>; :cp<CR>
noremap <Leader>' :cn<CR>
noremap <Leader>w <C-w>w
nnoremap <silent> <Space> :noh<CR>
nnoremap <Leader>s :sh<CR>
noremap <Leader>[ :tabprev<CR>
noremap <Leader>] :tabnext<CR>
nnoremap <Leader>qq :only<CR>
nnoremap <Leader>qt :tabonly<CR>
noremap <Leader><Tab> :tabe<CR>:lcd<space>
nnoremap <silent> <Leader>vimrc :tabe $MYVIMRC<CR>
noremap <Leader>P "0P
noremap <Leader>p "0p
nnoremap <Leader>v :vs<CR><C-w>=
nnoremap <Leader>vn :vnew<CR><C-w>=
nnoremap <Leader>ww <C-w>H<C-w>=
nnoremap <Leader>b :b#<CR>
nmap K i<Enter><Esc>
nmap <Leader>vb <Leader>v<Leader>b
noremap <silent> <Leader><Leader>h <C-w>h
noremap <silent> <Leader><Leader>j <C-w>j
noremap <silent> <Leader><Leader>k <C-w>k
noremap <silent> <Leader><Leader>l <C-w>l

"" nerdtree
noremap <Leader>nt :NERDTreeFind<CR>
noremap <Leader>ntt :NERDTreeToggle<CR>

"" nerdcommenter
map <Leader>/ <Plug>NERDCommenterToggle
map <Leader>// <Plug>NERDCommenterYank
map <Leader>/b <Plug>NERDCommenterAlignLeft

"" gundo.vim
nnoremap <Leader>u :GundoToggle<CR>

"" ack.vim
noremap <Leader>f :Ack!<space>
noremap <Leader>fw :Ack! "<cword>"<CR>
nnoremap <Leader>m :Ack "<<<"<CR>

"" vim-fugitive
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gl :Glog<CR>

"" vim-rvm
nnoremap <Leader>rv :Rvm use<CR>

"" vim-trailing-whitespace
nnoremap <Leader>dw :FixWhitespace<CR>

"" vim-rspec
au Filetype ruby noremap <Leader>r :call RunCurrentSpecFile()<CR>
au Filetype ruby nnoremap <Leader>rr :call RunNearestSpec()<CR>
au Filetype ruby nnoremap <Leader>l :call RunLastSpec()<CR>
au Filetype ruby nnoremap <Leader>ra :call RunAllSpecs()<CR>

"" vim-go
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <Leader>gdv <Plug>(go-def-vertical)

"" vim-rails
au Filetype ruby nnoremap <Leader>a :A<CR>
au Filetype ruby nnoremap <Leader>av :AV<CR>

"" vim-golang-alternate
au Filetype go nnoremap <Leader>a :A<CR>
au Filetype go nnoremap <Leader>av :AV<CR>

"" gitv
nnoremap <Leader>gv :Gitv<CR>

"" vim-rake
au Filetype ruby nnoremap <Leader>t :Rake test TEST=%<CR>
au Filetype ruby nnoremap <Leader>ta :Rake test<CR>

"" ctrlp.vim
nnoremap <Leader>bb :CtrlPBuffer<CR>

"" *** RUNTIME! ***
runtime! macros/matchit.vim


"" *** AUTOMAGIC ***
augroup reload_vimrc " {
  au!
  au BufWritePost $MYVIMRC source $MYVIMRC | :AirlineRefresh
augroup END " }

augroup ruby_syntax_for_capistrano_recipes " {
  au!
  au BufReadPost *.cap set syntax=ruby
augroup END " }