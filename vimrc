" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" set colorcolumn=86	" Set character-width column for length indicator
set cursorline		" Set underline to indicate location of cursor
set encoding=utf-8
set gcr=n:blinkon0	" Disable blinking
" set hidden		" Permit switching buffer without saving a file
set ignorecase		" When searching, ignore case
" set laststatus=2	" 0: Never show status; 1: only with two windows, 2: always
" set list		" List end of line and special characters
" set number		" Number each line in the file
" set relativenumber	"
set scrolloff=3		" Keep a minimum number of lines above and below cursor
" set showmatch
" set showmode
set smartcase

" Indentation-related settings
set shiftround		" When using >> or << will round to shiftwidth
set shiftwidth=2	" Use two spaces when using >> or <<
" set softtabstop=8	" Transform 8 spaces into tabs (when noexpandtab)
set expandtab		" Expand tabs into spaces
set smarttab
set tabstop=2		" Use two spaces instead of 8

" set ttyfast
" set visualbell
set wildmenu		" Show possible expansions above the command line
set wildmode=list:longest,full
set wrap
set textwidth=80

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set undofile
set shell=$SHELL\ -l

augroup local_leader
	autocmd!
	autocmd FileType vim,gitconfig set noexpandtab|set tabstop=8|set shiftwidth=8
	autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
	autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType ruby nnoremap <buffer> <localleader>c I#<esc>
augroup END

" Corrections and expansions
iabbrev @@    alan@atomsign.net
iabbrev adn and
abbrev ccopy  Copyright 2013 Alan Fung-Schwarz, all rights reserved.

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Syntaces
Bundle 'dagwieers/asciidoc-vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'wting/rust.vim'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'vim-ruby/vim-ruby'
Bundle 'sunaku/vim-ruby-minitest'
Bundle 'derekwyatt/vim-scala'
Bundle 'timcharper/textile.vim'

" Plugins
Bundle 'kien/ctrlp.vim'
Bundle 'myusuf3/numbers.vim'
Bundle 'mattn/emmet-vim'
Bundle 'msanders/snipmate.vim'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-notes'
Bundle 'tpope/vim-surround'

" Not on Github
Bundle 'L9'
Bundle 'AutoComplPop'

" Disabled
" Bundle 'flazz/vim-colorschemes'
" Bundle 'Floobits/floobits-vim'
" Bundle 'mattn/emmet-vim'
" Bundle 'tpope/vim-bundler'	"Conflicts with Vundle

filetype on

" Set leader to comma, local leader to backslash
let mapleader=","
let maplocalleader="\\"

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>l :ls<cr>:b<space>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>n :NERDTree<cr>
nnoremap <leader>t :CtrlP<cr>
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <leader>g :Git<space>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>s :Ag<space>
nnoremap <leader>cd :cd %:p:h<cr>

" C-D delete line and insert
inoremap <c-d> <esc>ddi
" C-U UPCASE
"inoremap <c-u> <esc>viwUA

" set statusline+=%{fugitive#statusline()}
set splitright splitbelow
set clipboard^=unnamed,unnamedplus

syntax enable
colors bluegreen
