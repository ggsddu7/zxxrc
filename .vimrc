set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'tpope/vim-surround'
Plugin 'klen/python-mode'
"Plugin 'benmills/vimux'
Plugin 'mileszs/ack.vim' " sudo yum install ack
Plugin 'majutsushi/tagbar'
"Plugin 'vim-scripts/EnhancedJumps'
"Plugin 'vim-scripts/ingo-library'
"Plugin 'vim-scripts/taglist.vim'
"Plugin 'jiangmiao/auto-pairs'
call vundle#end()            " required
filetype plugin indent on    " required

let g:ycm_global_ycm_extra_conf = '/home/zhangjiguo/.ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_disable_for_files_larger_than_kb = 50
"let g:ycm_filetype_whitelist = { 'python': 1, 'cpp': 1, 'javascript': 1}
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
"let g:ycm_complete_in_comments = 1
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_server_use_vim_stdout = 1
let g:ycm_goto_buffer_command = 'new-or-existing-tab'
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:EclimCompletionMethod = 'omnifunc'
"imap JJ  <c-x><c-f> "when file big, use vimcp to complete path

set completeopt=longest,menu
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" hit enter to cancel searched highlight
noremap <CR> :nohlsearch<CR>
noremap <C-N> :Ack <cword><CR>

map Q <Nop>
noremap m gt
" select ALL
"map <C-A> ggVG
map <C-L> $v0
map <C-P> :CtrlP <CR>
noremap <c-t> :b <c-z>
"nmap 0 0w " use ^ substitute
nmap <Home> 0
imap <Home> <ESC>0i
map <C-S> :w <CR>
imap <C-S> <ESC>:w <CR>
map <F10> <Esc>:tabnew<CR>
"nmap <C-I> j[mzf%
"nmap <C-N> zdj
map <C-J> gT
imap <C-J> <Esc>gT
map <C-K> gt
imap <C-K> <Esc>dt i
"map <C-,> \cm <Esc>
"imap <C-,> <Esc>\cm <Esc>
map <C-_> \cc <Esc>
imap <C-_> <Esc>\cc <Esc>
map <C-\> \cu<Esc>
imap <C-\> <Esc>\cu<Esc>
set pastetoggle=<F6>
"noremap <F5> :silent! e!<CR>
"vmap <F5> : w!/tmp/x1<CR>
"vmap <F6> : r /tmp/x1<CR>
nmap <F7> :reg<CR>
map <F9> <Esc>:tabm
imap <F9> <Esc>:tabm
nmap <F11> :TagbarToggle<CR>
map <F12> :BufExplorer<CR>
map <Backspace> Xi
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap * y/<C-R>"<CR>:%s///gn<CR>
imap <C-u> : <Esc>c0	
" noremap * *:%s///gn<CR>


syntax enable
syntax on
autocmd FileType c,cpp,py,cu setlocal shiftwidth=4 "| set expandtab

"set nu
set cursorcolumn
set cursorline
set smarttab
set foldmethod=marker
set showmode
set showcmd
set autoread
"let g:Powerline_symbols = 'fancy'
"let g:Powerline_stl_path_style = 'full'
"let g:airline_powerline_fonts=1
let g:airline_theme="simple"
let g:airline_section_c = '%F'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
"let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
set laststatus=2
"
colorscheme molokai

let g:pymode_warnings = 0
let g:pymode_indent = 1
let g:pymode_folding = 0
let g:pymode_breakpoint = 0
let g:pymode_lint_message = 1
let g:pymode_lint_cwindow = 0
let g:pymode_rope = 0
"let g:pymode_rope_completion = 0
"let g:pymode_rope_complete_on_dot = 0
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_run = 0

let g:airline_powerline_fonts=0

let g:ackhighlight = 1

set incsearch
set hlsearch
set ic

let g:tagbar_ctags_bin = '/usr/local/ctags-5.8/bin/ctags'
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

let g:lasttab = 1
nmap <C-H> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

"source ~/.vim/bundle/zjump.vim
"nmap <C-[> :call NCO()<CR>

set backspace=2
set wildmenu wildmode=full 
set wildchar=<Tab> wildcharm=<C-Z>
