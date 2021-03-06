""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Loosely based on
"   https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
" automatically save any changes made to buffers before they're hidden
set autowriteall

" enable syntx highlighting
syntax on
" drop compatibility as it might cause troubles with some plugins
set nocompatible

" do not write backup files
set nobackup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" show commands being typed in the last line of the screen
set showcmd
" show line numbers
set number
" set background colour
set background=dark

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" visual autocomplete for command menu
set wildmenu            

" Faster updates on CursorHold/CursorHoldI
set updatetime=1000

" auto-open quickfix
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

hi CursorLine cterm=NONE ctermbg=235
set cursorline
augroup cursor_hi
    autocmd!
    autocmd WinLeave * set nocursorline 
    autocmd WinEnter * set cursorline 
augroup END

" so that backspace behaves like you would expect to
set backspace=indent,eol,start

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" good to know predefined keys
"
" move between windows in split mode
"   ctrl+w hjkl
" search for word under cursor
"   *
" start visual mode and select the next match
"   gn
" delete next match and start insert mode
"   cgn
" visual mode (block)
"   ctrl+v
" visual mode (line)
"   shift+v

" set the prefix (=leader) for custom commands
let mapleader = "`"

"   delete buffer
nnoremap <Leader>x :bd<cr>

"   turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"   resize panel vertically to 80 chars
nnoremap \| <C-W>80\|

"   search for visually selected text
vnoremap <space> y/\V<C-R>=escape(@",'/\')<CR><CR>
" hint: once the text is highlighted you can just replace it with
"   %s//<your-replacement-string>

" Use word under cursor as search pattern
nnoremap <space> m`:keepjumps normal! *``<cr>

" navigate through search results without affecting jumplist
cnoremap <C-n> <cr>
nnoremap <C-n> :keepjumps normal n<cr>

"   exit insert mode
inoremap <C-c> <Esc>

" quickfix navigation
nnoremap ]c :cnext<CR>
nnoremap [c :cprevious<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '907th/vim-auto-save'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'SirVer/ultisnips'
Plug 'mhinz/vim-startify'
Plug 'greymd/oscyank.vim'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-signify'
Plug 'solarnz/thrift.vim', { 'for': 'thrift' }
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'janko/vim-test', { 'for': 'python' }
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'wincent/vim-clipper'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>p :Commands<cr>
nmap <Leader>o :Files<cr>
nmap <Leader>l :Lines<cr>
nmap <Leader>m :Marks<cr>
nmap <C-k> :Buffers<cr>

nmap <leader>y <Plug>(ClipperClip)

let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "CursorHold"]
let g:auto_save_silent = 1  " do not display the auto-save notification

let g:airline_theme='deus'
let g:airline_powerline_fonts=1
let g:airline_section_c = '%{getcwd()}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '

let g:vimwiki_list = [{'path': '~/Dropbox/wiki/', 'syntax': 'markdown', 'ext': '.txt'}]
nmap <Leader>i <Plug>VimwikiIndex
nmap <Leader>t <Plug>VimwikiMakeDiaryNote

let test#strategy = "make"

let g:deoplete#enable_at_startup = 1
autocmd CompleteDone * silent! pclose

let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1
nmap <Leader>f <Plug>(ale_fix)
nmap <Leader>? <Plug>(ale_hover)
nmap <Leader>* <Plug>(ale_find_references)
nmap <C-]> <Plug>(ale_go_to_definition)
nmap [e <Plug>(ale_previous_wrap_error)
nmap ]e <Plug>(ale_next_wrap_error)

nnoremap <leader>d :SignifyDiff<cr>
nnoremap <leader>hd :SignifyHunkDiff<cr>
nnoremap <leader>hu :SignifyHunkUndo<cr>
nmap ]h <plug>(signify-next-hunk)
nmap [h <plug>(signify-prev-hunk)
