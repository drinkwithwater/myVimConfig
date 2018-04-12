"
" $File: .vimrc
" $Date: 四 4月 12 17:24:38 2018 +0800
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
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim/
call vundle#rc()

" let Vundle manage Vundle
" required!
"Bundle 'gmarik/vundle'

"Bundle 'mips.vim'
"Bundle 'jsbeautify'
"Bundle 'vim-coffee-script'
"Bundle 'vim-pandoc/vim-pandoc'
"Bundle 'Lokaltog/powerline'
Bundle 'nerdtree'

"let g:pandoc_no_folding = 1

" vim outline of markdown
"Bundle 'VOoM'

" sublime-like multi-cursor edit
"Bundle "terryma/vim-multiple-cursors"

" ejs
"Bundle "briancollins/vim-jst"

"Bundle "wavded/vim-stylus"
autocmd FileType stylus set shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" html scaffold
"Bundle "Emmet.vim"

" jade
"Bundle "digitaltoad/vim-jade"

" auto detect encoding
" useful command:
"	FencAutoDetect
"	FencView
"Bundle 'FencView.vim'
"let g:fencview_autodetect = 0
"let g:fencview_checklines = 10


"Bundle "Lokaltog/vim-easymotion"

" not working
" Bundle 'myhere/vim-nodejs-complete'

"Bundle 'Valloric/YouCompleteMe'
"Bundle 'matchit.zip'
" f}}}

let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1

let g:EclimCompletionMethod = 'omnifunc'

" preview
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1



let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }
nnoremap <Leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
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

	" set :make and some commands
	auto FileType cpp let &makeprg="g++ % -o %:r -Wall -Wextra -O2 -std=c++11"
	auto FileType c let &makeprg="gcc % -o %:r -Wall -Wextra -O2 -std=c++11"
	auto FileType tex let &makeprg="make"

	fun Make_arg(arg, ...)
		let makeprg0 = &makeprg
		let &makeprg = a:arg
		for s in a:000
			let &makeprg .= " " . s
		endfor
		make
		let &makeprg = makeprg0
	endfun

	command -nargs=* Makegdb call Make_arg("g++ % -o %:r -ggdb -Wall -Wextra -std=c++11", <f-args>)
	command -nargs=* Makepg call Make_arg("g++ % -o %:r -pg -Wall -Wextra -std=c++11", <f-args>)
	command -nargs=* TryCompile call Make_arg("g++ % -o /tmp/vim_try_compile -Wall -Wextra -c -std=c++11", <f-args>)
	command -nargs=* Makedebug call Make_arg("g++ % -o %:r -g -Wall -Wextra -DDEBUG -D__DEBUG_BUILD -std=c++11", <f-args>)


	" Automatically updates the time and date in the head of the file
	autocmd BufWritePre,FileWritePre *   call LastMod()
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


let g:pydiction_location = '~/.vim/after/ftplugin/pydiction/complete-dict'
nmap <Leader>ps :call PinyinSearch()<CR>
nnoremap ? :call PinyinSearch()<CR>
nmap <Leader>pn :call PinyinNext()<CR>
let g:PinyinSearch_Dict = $HOME . "/.vim/bundle/vim-PinyinSearch/PinyinSearch.dict"


" look up dictionary for word under cursor
"map Z :! sdcv  `echo <cword> \| sed -e 's/[^[:alnum:]]//g'` <CR>
map Z :! echo `echo <cword> \| sed -e 's/[^[:alnum:]]//g'` <CR>
"-u 朗道英汉字典5.0

" remove trailing whitespaces
func DeleteTrailingWhiteSpace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endfunc
au BufWrite * if &ft != 'mkd' | call DeleteTrailingWhiteSpace() | endif

" This works
map Q :r! expr-sdcv `echo <cword> \| sed -e 's/[^[:alnum:]]//g'` <CR> kJ

" {{{make
func Make()                        " silent make with quickfix window popup
    if &ft == 'cpp'
        if filereadable(getcwd() . "/Makefile")
            let &makeprg="make"
        elseif  filereadable(getcwd() . "/../Makefile")
            let &makeprg="make -C .."
        endif
    endif
    make
    " silent make ?
    redraw!
    for i in getqflist()
        if i['valid']
            cwin | winc p | return
        endif
    endfor
endfunc

func FindMakefile()
    exec "cd " . expand ("%:p:h")
    while ! filereadable(getcwd() . "/Makefile") && getcwd () != "/"
        cd ..
    endw
    :!make
endfunc
au Filetype gnuplot let &makeprg="gnuplot % ; feh ./*"
au Filetype dot let &makeprg="dot -Tpng -O -v % ; feh %.png"
au Filetype php let &makeprg="php %"
au Filetype r let &makeprg="R <% --vanilla"
func InstantRun()
    if &ft == 'python'
        if matchstr(getline(1), 'python2') == ""
            :!python %
        else | :!python2 %
		endif
    elseif &ft == 'ruby' | :!ruby %
    elseif &ft == 'sh' | :!bash %
    elseif &ft == 'cpp' | :!gdb -tui %<
    elseif &ft == 'java' | :! javac % && echo "Compilation succeed" && java %<
    elseif &ft == 'javascript' | :! node %
    elseif &ft == 'tex' | :! xelatex %
    elseif &ft == 'lisp' | :! sbcl --script %
    elseif &ft == 'coffee' | :! coffee %
	elseif &ft == 'asm' | :! as % -o %<.o --32 && ld %<.o -o %< -m elf_i386
	else | call Make() | endif
endfunc
nnoremap <Leader>rr :call InstantRun() <CR>
nnoremap <Leader>mk :call Make()<CR>
nnoremap <Leader>mr :!make run <CR>
nnoremap <Leader>make :call FindMakefile()<CR>
" }}}

" This do not work
" map Q :r! expr-sdcv `echo <cword> \| sed -e 's/[^[:alnum:]]//g'` <CR>
"inoremap <c-a> <Esc>:r! expr-sdcv `echo <cword> \| sed -e 's/[^[:alnum:]]//g'` <CR> kJo


" <F6> auto compile and debug command
" {
auto FileType cpp     let COMPILER = "g++" |
		              let COMPILE_INPUT = "%" |
					  let COMPILE_FLAGS_DEBUG = "-g -Wall -Wextra -std=c++11" |
					  let COMPILE_FLAGS_RELEASE = "-O2 -Wall -Wextra -std=c++11" |
					  let COMPILE_LIBS = "" |
					  let COMPILE_OUTPUT = "-o %<" |
					  let DEBUGER = "gdb" |
					  let DEBUG_FILE = "%<" |
					  let INTERPRETER = "" |
					  let EXE_FILE = "./%<"

auto FileType c       let COMPILER = "gcc" |
                      let COMPILE_INPUT = "%" |
					  let COMPILE_FLAGS_DEBUG = "-g -Wall -Wextra" |
					  let COMPILE_FLAGS_RELEASE = "-O2" |
					  let COMPILE_LIBS = "" |
					  let COMPILE_OUTPUT = "-o %<" |
					  let DEBUGER = "gdb" |
					  let DEBUG_FILE = "%<" |
					  let INTERPRETER = "" |
					  let EXE_FILE = "./%<"


auto FileType pascal  let COMPILER = "fpc" |
                      let COMPILE_INPUT = "%" |
					  let COMPILE_FLAGS_DEBUG = "-g" |
					  let COMPILE_FLAGS_RELEASE = "-O2" |
					  let COMPILE_LIBS = "" |
					  let COMPILE_OUTPUT = "-o%<" |
					  let DEBUGER = "gdb" |
					  let DEBUG_FILE = "%<" |
					  let INTERPRETER = "" |
					  let EXE_FILE = "./%<"

"auto FileType python  let INTERPRETER = "python" |
"					  let EXE_FILE = "./%"


function InstantMakeDebug()
	:call Make_arg(g:COMPILER . " " . g:COMPILE_INPUT . " " . g:COMPILE_FLAGS_DEBUG . " " . g:COMPILE_LIBS . " " . g:COMPILE_OUTPUT)
endfunction

function InstantMakeDebug_DDEBUG()
	:call Make_arg(g:COMPILER . " " . g:COMPILE_INPUT . " " . g:COMPILE_FLAGS_DEBUG . " " . g:COMPILE_LIBS . " " . g:COMPILE_OUTPUT . " -DDEBUG" )
endfunction

function InstantMakeRelease()
	:call Make_arg(g:COMPILER . " " . g:COMPILE_INPUT . " " . g:COMPILE_FLAGS_RELEASE. " " . g:COMPILE_LIBS . " " . g:COMPILE_OUTPUT)
endfunction

function InstantDebug()
	:exec ":!" . g:DEBUGER . " " . g:DEBUG_FILE
endfunction

function InstantExecute()
	:exec ":!" . g:INTERPRETER . " " . g:EXE_FILE
endfunction

"auto FileType cpp,c,pascal				nmap <buffer> <F6> :call InstantMakeDebug() <CR>
"auto FileType cpp,c						nmap <buffer> <F8> :call InstantMakeDebug_DDEBUG() <CR>
"auto FileType cpp,c,pascal				nmap <buffer> <F7> :call InstantMakeRelease() <CR>
"auto FileType cpp,c,pascal				nmap <buffer> <F5> :call InstantDebug() <CR>
"auto FileType cpp,c,pascal,python		nmap <buffer> <F9> :call InstantExecute() <CR>
" }

" auto FileType tex nmap <buffer> T :!xelatex % <CR>
" nmap <buffer> T :call InstantRun() <CR>

autocmd filetype python setlocal expandtab textwidth=79


" code below are from http://fcitx.github.com/handbook/chapter-remote.html
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set timeoutlen=150

"autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2zh()


" code below are from
" http://vim-latex.sourceforge.net/documentation/latex-suite/recommended-settings.html
" for vimlatex suite
" {
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
"filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
"set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
"filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
"let g:tex_flavor='latex'
" }


"
vmap <F3> <Esc><Esc>:call EnhancedCommentify('yes','comment',line("'<"),line("'>"))<CR>
vmap <M-F3> <Esc><Esc>:call EnhancedCommentify('yes','decomment',line("'<"),line("'>"))<CR>


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
au BufNewFile,BufRead *.cpp setlocal syntax=cpp11
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
autocmd FileType python set colorcolumn=80 softtabstop=4 tabstop=5

" au VimEnter * :IndentGuidesEnable
" let g:indent_guides_auto_colors = 0
" let g:indent_guides_guide_size = 1
" hi IndentGuidesOdd ctermbg=white
" hi IndentGuidesEven ctermbg=green


set scrolljump=5
set scrolloff=5
set sidescroll=3
set sidescrolloff=3

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


" auto add execute permission to sh file
au BufWritePost *
            \ if getline(1) =~ "^#!/bin/[a-z]*sh" |
            \   exe "silent !chmod a+x <afile>" |
            \ endif

"function HighlightFunctionsAndClasses()
"    syn match cCustomClass	"\w\+\s*\(::\)\@#"
"    hi def link cCustomClass cppType
"endfunc
"au Syntax * call HighlightFunctionsAndClasses()


" Font
if has('gui_running')
	set guifont=SourceCodePro:h11
endif


"set foldmethod=marker
"set foldmarker=region,endregion
"set foldnestmax=2
"set foldminlines=5
nnoremap zo zO
nnoremap zz zA

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

au BufNewFile,BufRead *.sproto setlocal syntax=python

