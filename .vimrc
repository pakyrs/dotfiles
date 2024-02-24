"set mouse=r                       " remove mouse support - helps with copy paste"
"set mouse=nicr
:nmap <F12> :set invnumber<CR>    " Toggle line numbers on/ off using F12"
set paste                         " fix pasting feom yml or code to avoid spaces"
set nocompatible                  " Must come first because it changes other options. Dont try to be vi compatible"
syntax on                         " Turn on syntax highlighting"
filetype plugin indent on         " Turn on file type detection. For plugins to load correctly"
set showcmd                       " Display incomplete commands"
set showmode                      " Display the mode youre in"
set backspace=indent,eol,start    " Intuitive backspacing"
set hidden                        " Handle multiple buffers better"
set wildmenu                      " Enhanced command line completion"
set wildmode=list:longest         " Complete files like a shell"
set ignorecase                    " Case-insensitive searching"
set smartcase                     " But case-sensitive if expression contains a capital letter"
set ruler                         " Show cursor position"
set incsearch                     " Highlight matches as you type"
set hlsearch                      " Highlight matches"
set autoread                      " Automatically reload on changes"
set nowrap                        " Turn on line wrapping"
set scrolloff=3                   " Show 3 lines of context around the cursor"
set title                         " Set the terminals title"
set ttyfast                       " Rendering"
set nobackup                      " Dont make a backup before overwriting a file."
set nowritebackup                 " And again."
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location"
set encoding=utf-8                " set encoding "
" NO BELLS OR BEEPING 
set visualbell                    
set noerrorbells
set novisualbell
set belloff=esc
" CLIPBOARD requires +clipboard compiled vim
set clipboard=unnamedplus

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" UNCOMMENT TO USE
set tabstop=3                     " Global tab width.
"set shiftwidth=2                  " And again, related.
"set expandtab                     " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set statusline=%<%f%=\ [%1*%M%*%n%R%H]\ %19(%2c\ c:%3o\ l:%3l/%-3L\ %)

" Or use vividchalk
"colorscheme topfunky-light
set background=dark

" DRACULA THEME
packadd! dracula
syntax enable
colorscheme dracula
