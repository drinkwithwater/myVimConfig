"
" $File: .vimrc
" $Author: Jiakai <jia.kai66@******>
" Adapted by Zhou Xinyu <zxytim@******>
" Adapted by cz
" a useful vimrc file
"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

"


" cz's habbits {"
" set ctags
" set nerd tree "
" map <F2> :NERDTreeToggle<CR>
command Nerd NERDTreeToggle
let NERDTreeWinPos = 1
" set tab "
set showtabline=2
"map <c-t> :tabe<CR>:WMToggle<CR>
map <c-d> :NERDTreeToggle<CR>

map <c-h> :tabp <CR>
map <c-l> :tabn <CR>


nmap <c-t> :tab term <CR>

tnoremap <esc> <c-\><c-n> <CR>
tnoremap <c-h> <c-\><c-n>:tabp <CR>
tnoremap <c-l> <c-\><c-n>:tabn <CR>


" set mru
let g:MRU_File=expand("~")."/.vimtmp/MRU_FILES"

" use sogou input method"
inoremap <C-c> <esc>

nnoremap <s-l> :<C-u>call MotionCamelRight() <CR>
xnoremap <s-l> :<C-u>execute 'normal! gv'<Bar>call MotionCamelRight() <CR>
onoremap <s-l> :<C-u>call MotionCamelRight() <CR>

nnoremap <s-h> :<C-u>call MotionCamelLeft() <CR>
xnoremap <s-h> :<C-u>execute 'normal! gv'<Bar>call MotionCamelLeft() <CR>
onoremap <s-h> :<C-u>call MotionCamelLeft() <CR>

function! MotionCamelRight()
	let curChar = getline('.')[col('.') - 1]
	let pointChar = getline('.')[col('.')]
	let charCount = 1
	while col('.') - 1 + l:charCount < len(getline('.'))
		if (l:pointChar >= 'A' && l:pointChar <='Z') || l:pointChar == ' ' || l:pointChar == '_'
			break
		endif
		let charCount = l:charCount + 1
		let pointChar = getline('.')[col('.') - 1 + l:charCount]
	endwhile
	exec "normal! ".l:charCount."l"
endfunction

function! MotionCamelLeft()
	let pointChar = getline('.')[col('.')-2]
	let charCount = 1
	while col('.') - 1 - l:charCount > 0
		if (l:pointChar >= 'A' && l:pointChar <='Z') || l:pointChar == ' ' || l:pointChar == '_'
			break
		endif
		let charCount = l:charCount + 1
		let pointChar = getline('.')[col('.') - 1 - l:charCount]
	endwhile
	exec "normal! ".l:charCount."h"
endfunction


filetype on
" Folding:
set foldmethod=marker
set foldmarker=/(^_^)\,\(v_v)/
set foldlevel=0
set foldminlines=1

autocmd Filetype lua setlocal foldmethod=indent
autocmd Filetype lua setlocal foldlevel=0

"autocmd Filetype lua setlocal foldmethod=expr
"autocmd Filetype lua setlocal foldexpr=(getline(v:lnum)=~'^$')?-1:((indent(v:lnum-1)<indent(v:lnum))?('>'.indent(v:lnum)):indent(v:lnum))

autocmd BufWinEnter *.lua silent! :foldopen!

"}"


set nocompatible

function! s:get_visual_selection()
	"Why is this not a built-in Vim script function?!
	let [lnum1, col1] = getpos("'<")[1:2]
	let [lnum2, col2] = getpos("'>")[1:2]
	let lines = getline(lnum1, lnum2)
	let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][col1 - 1:]
	return join(lines, "\n")
endfunction

" Bundle: f{{{
filetype off
set rtp+=~/.vim/bundle/vundle/

"call vundle#rc()
"Bundle 'nerdtree'

autocmd FileType stylus set shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" }


" Ensure all autocommands, functions and commands are included only once
if !exists("header_protecter")
	let header_protecter = 1

	if has('persistent_undo')
		set undofile
		set undodir=~/.vimtmp/undo
	endif


	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\   exe "normal g`\"" |
				\ endif

	" Automatically updates the time and date in the head of the file
	" autocmd BufWritePre,FileWritePre *   call LastMod()
	fun LastMod()
		let ll = line(".")
		let l = line("$")
		let c = col(".")
		if l > 50
			let l = 50
		endif
		execute '1,' . l . 'substitute/' . '^\(.*\$Date:\).*$' . '/\1 ' . strftime('%a %b %d %H:%M:%S %Y %z') . '/e'
		execute '1,' . l . 'substitute/' . '^\(.*\$File:\).*$' . '/\1 ' . expand('<afile>:t') . '/e'

		let l = line("$")
		if l > 50
			let l = 50
		endif
		execute '1,' . l . 's/\(【日期】\).*$' . '/\1 ' . strftime('%a %b %d %H:%M:%S %Y %z') . '/e'
		call cursor(ll, c)
	endfun
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
syntax on
" set autoindent        " always set autoindenting on
set smartindent
if has("vms")
	set nobackup        " do not keep a backup file, use versions instead
else
	set backup        " keep a backup file
endif
set history=50        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch        " do incremental searching

set number
set shiftwidth=4 softtabstop=4 tabstop=4
set fileencodings=utf-8,gb2312,gbk,ucs-bom
set guifont=Monospace\ 16
set nobk

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p :let current_reg = @"gvs=current_reg

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif


" Move cursor in the insert mode
"inoremap <c-h> <Left>
"inoremap <c-j> <Down>
"inoremap <c-k> <Up>
"inoremap <c-l> <Right>
"inoremap <c-e> <End>
"inoremap <c-f> <Home>
"inoremap <c-w> <Right><Esc>wi
"inoremap <c-b> <Right><Esc>bi
" map ctrl+O in insert mode
"inoremap <c-o> <Esc>o


" look up dictionary for word under cursor
"map Z :! sdcv  `echo <cword> \| sed -e 's/[^[:alnum:]]//g'` <CR>
"map Z :! echo `echo <cword> \| sed -e 's/[^[:alnum:]]//g'` <CR>
"-u 朗道英汉字典5.0

" remove trailing whitespaces
func DeleteTrailingWhiteSpace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endfunc
au BufWrite * if &ft != 'mkd' | call DeleteTrailingWhiteSpace() | endif

autocmd filetype python setlocal expandtab textwidth=200

set timeoutlen=150

colorscheme elflord
" color scheme
" {
" auto FileType python		colorscheme delek
" }

set wildmenu

" turn on html5 highlighting in eruby
autocmd BufRead,BufNewFile *.erb setlocal filetype=eruby.html shiftwidth=4 softtabstop=4 tabstop=4

augroup filetype
  au BufRead,BufNewFile *.flex,*.jflex    set filetype=jflex
augroup END

"au Syntax jflex    so ~/.vim/syntax/jflex.vim
"au Syntax byacc		so ~/.vim/syntax/jflex.vim

" html auto completion
" au Filetype html,xml,xsl source ~/.vim/plugin/closetag.vim
" inoremap >>^M >^[F<lyt>o</^R">^[O

" cpp11 support
au BufNewFile,BufRead *.cpp setlocal syntax=cpp
au BufNewFile,BufRead *.decaf setlocal ft=decaf syntax=java

" javascript
function! JavaScriptFold()
	setl foldmethod=syntax
	setl foldlevelstart=1
	syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

	function! FoldText()
		return substitute(getline(v:foldstart), '{.*', '{...}', '')
	endfunction
	setl foldtext=FoldText()
endfunction
" autocmd FileType javascript call JavaScriptFold()
autocmd FileType javascript setl fen
autocmd FileType javascript map <c-z> :call JavaScriptFold() <CR>
autocmd FileType javascript setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
" TODO

autocmd FileType ruby set shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType coffee set shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType jade set shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd FileType tex set conceallevel=2
autocmd FileType python set colorcolumn=200 softtabstop=4 tabstop=5

"set scrolljump=5
"set scrolloff=5
"set sidescroll=3
"set sidescrolloff=3

set showmatch
set matchtime=0

set timeoutlen=300
set ttimeoutlen=0

nnoremap ; :

nnoremap n nzzzv
nnoremap N Nzzzv


set formatoptions+=m

" some highlights for frequently used types
syn keyword cppType real_t Vector Matrix
syn keyword cppSTL priority_queue isfinite isnan shared_ptr make_shared numeric_limit string queue map
syn keyword cppSTLType T


" Font
if has('gui_running')
	set guifont=SourceCodePro:h11
endif


"set foldmethod=marker
"set foldmarker=region,endregion
"set foldnestmax=2
"set foldminlines=5
nnoremap zo zO
nnoremap zz zR

nnoremap zh za
nnoremap zl zo

nnoremap <c-j> zj
nnoremap <c-k> zk



"hi Folded guibg=black guifg=grey40 ctermfg=darkgrey ctermbg=darkgrey
hi Folded ctermfg=darkblue  ctermbg=230


" execute pathogen#infect()
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
"
"au BufNewFile,BufRead *.luast setlocal syntax=luast
"au BufNewFile,BufRead *.luast setlocal foldmethod=indent
"au BufNewFile,BufRead *.luast setlocal foldlevel=0

au BufNewFile,BufRead *.tempproto setlocal syntax=proto
au BufNewFile,BufRead *.sproto setlocal syntax=python

au BufNewFile,BufRead *.vue setlocal syntax=html
au BufNewFile,BufRead *.nvue setlocal syntax=html

autocmd VimEnter * call RemoteOpen()
