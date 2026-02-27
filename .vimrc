set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on    " required
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set completeopt=longest,menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" hit enter to cancel searched highlight
noremap <CR> :nohlsearch<CR>

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
" autocmd FileType c,cpp,py,cu setlocal 
set shiftwidth=4
set expandtab

"set nu
set cursorcolumn
set cursorline
set smarttab
set showmode
set showcmd
set autoread
set laststatus=2
"
colorscheme molokai

set incsearch
set hlsearch
set ic

let g:tagbar_ctags_bin = '/usr/local/ctags-5.8/bin/ctags'
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

let g:lasttab = 1
nmap <C-L> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

set backspace=2
set wildmenu wildmode=full 
set wildchar=<Tab> wildcharm=<C-Z>

let g:lasttab = 1
nmap <C-T> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

autocmd Filetype json let g:indentLine_setConceal = 0

set wildignore+=*/tmp/*,*.so,*.swp,*.zip   

hi CocMenuSel ctermbg=red ctermfg=white guibg=#1e1e1e guifg=#9fcf8c

" 自动检测粘贴模式
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    let g:before_paste = {'line': line('.'), 'col': col('.')}
    set paste
    return ""
endfunction

" 当 pastetoggle 关闭 paste 模式时退出插入模式
" augroup auto_exit_paste
"     autocmd!
"     autocmd OptionSet paste if !v:option_new | call feedkeys("\<C-c>`[jv`]9>", 'n') | endif
" augroup END

function! AdjustPasteIndent()
    if coc#pum#visible()
        call coc#pum#cancel()
        echo "补全窗口已关闭"
    else
        echo "补全窗口未打开"
    endif
    " 1. 先退出插入模式
    if mode() =~# '[iR]'  " 如果是插入或替换模式
        call feedkeys("\<C-c>", 'n')
    endif
    
    " 2. 等待模式切换完成
    call timer_start(10, {-> s:DoIndentAdjustment_v2()})
endfunction

" 从尾部选择到第一行第一列
function! s:DoIndentAdjustment_v2()
    " 3. 获取粘贴区域的开始和结束位置
    let start_line = line("'[")  " 修改开始行
    let end_line = line("']")    " 修改结束行
    " 4. 检查是否有有效的修改区域
    if start_line == 0 || end_line == 0 || start_line >= end_line || !empty(substitute(g:paste_before_line, '\s', '', 'g'))
        call feedkeys("a", 'n')
        echo "没有有效的粘贴区域"
        return
    endif
    let indent_amount = 100
    let indents = ""
    let insert_amount = g:before_paste.col - 1
    let indent_str = repeat(' ', insert_amount)
    let first_line = substitute(getline(start_line), '\s\+$', '', '')
    call setline(start_line, first_line[insert_amount:])
    for line_num in range(start_line, end_line)
        let current_line = getline(line_num)
        let current_line_indent_amount = len(matchstr(current_line, '^\s*'))  " 计算前导空格数
        let indents = indents . current_line_indent_amount . '|'
        if len(substitute(current_line, '\s', '', '')) == 0
            continue
        endif
        if current_line_indent_amount < indent_amount
            let indent_amount = current_line_indent_amount
        endif
    endfor
    for line_num in range(start_line, end_line)
        let current_line = substitute(getline(line_num), '\s\+$', '', '')
        call setline(line_num, indent_str . current_line[indent_amount:])
    endfor
    " 8. 反馈信息
    let adjusted_lines = end_line - start_line + 1
    echo "已调整 " . adjusted_lines . " 行的缩进（移除:" . indent_amount . " 插入:" . insert_amount . "）空格 " . indents
    call cursor(start_line, insert_amount+1)
endfunction

function! s:DoIndentAdjustment()
    " 3. 获取粘贴区域的开始和结束位置
    let start_line = line("'[")  " 修改开始行
    let end_line = line("']")    " 修改结束行
    
    " 4. 检查是否有有效的修改区域
    if start_line == 0 || end_line == 0 || start_line >= end_line
        echo "没有有效的粘贴区域"
        return
    endif
    
    " 5. 获取第一行的缩进量
    let first_line = getline(start_line)
    let indent_amount = len(matchstr(first_line, '^\s*'))  " 计算前导空格数
    
    " 6. 如果第一行没有缩进，则不需要调整
    if indent_amount == 0
        echo "第一行没有缩进，保持不变"
        return
    endif
    
    " 7. 从第二行开始应用相同的缩进
    let indent_str = repeat(' ', indent_amount)
    
    for line_num in range(start_line + 1, end_line)
        let current_line = getline(line_num)
        " 移除现有缩进，添加新的缩进
        let new_line = indent_str . current_line
        call setline(line_num, new_line)
    endfor
    
    " 8. 反馈信息
    let adjusted_lines = end_line - start_line
    echo "已调整 " . adjusted_lines . " 行的缩进（" . indent_amount . " 空格）"
    call cursor(start_line, indent_amount+1)
endfunction

augroup auto_exit_paste
    autocmd!
    autocmd OptionSet paste if v:option_new | let g:paste_before_line = getline('.') | endif
    autocmd OptionSet paste if !v:option_new | call AdjustPasteIndent() | endif
augroup END

" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
