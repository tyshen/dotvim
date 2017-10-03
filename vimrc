call plug#begin('~/.vim/plugged')

Plug  'Lokaltog/vim-easymotion'
Plug  'Raimondi/delimitMate'
Plug  'ervandew/supertab'
"Plug  'godlygeek/tabular'
"Plug  'junegunn/vim-easy-align'
Plug  'junegunn/fzf'
Plug  'junegunn/fzf.vim'
Plug  'mhinz/vim-grepper'
Plug  '~/.vim/plugged/Conque-GDB' , {'on' : 'ConqueGdb'}
Plug  'henrik/vim-indexed-search'

Plug  'luochen1990/rainbow'
"Plug  'majutsushi/tagbar' , {'on' : 'TagbarToggle' }
"Plug  'scrooloose/nerdtree' , { 'on': 'NERDTreeToggle' }
Plug  'tpope/vim-surround'
Plug  'tpope/vim-rsi'
"Plug  'tpope/vim-dispatch'
"Plug  'tyshen/snipmate.vim'
"Plug  'sjl/gundo.vim'
"Plug  'YankRing.vim'

"Plug  'w0rp/ale'
"Plug  'vim-syntastic/syntastic'
Plug   'neomake/neomake'

Plug  'mh21/errormarker.vim'
Plug  'kshenoy/vim-signature'
"Plug  'lyuts/vim-rtags'
Plug  'cazador481/vim-systemverilog'
Plug  'wellle/targets.vim'
"Plug  'kana/vim-textobj-user'
"Plug  'glts/vim-textobj-indblock'
"Plug  'Julian/vim-textobj-variable-segment'
"Plug  'beloglazov/vim-textobj-quotes'
"Plug  'machakann/vim-textobj-functioncall'

Plug  'chrisbra/vim-diff-enhanced'
"Plug  'lambdalisue/vim-diffa'
"colorscheme
Plug  'vim-scripts/desert256.vim'
Plug  'vim-scripts/desertEx'
Plug  'ciaranm/inkpot'
Plug  'sickill/vim-monokai'
Plug  'tomasr/molokai'
Plug  'nanotech/jellybeans.vim'
Plug  'morhetz/gruvbox'
Plug  'sjl/badwolf'
Plug  'w0ng/vim-hybrid'

" vim-scripts repos
Plug  'vim-scripts/QuickBuf'
"Plug  'vim-scripts/VisIncr'
Plug  'vim-scripts/a.vim'
Plug  'vim-scripts/cscope_macros.vim'


call plug#end()


"copy from /etc/vimrc for some common setting
if has("win32")
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    set noswf
    set nobackup
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ruler
syntax on
set hls

runtime macros/matchit.vim

"===================================================================================================
" vim 7 config
"===================================================================================================
if v:version >= 700

"map <LEADER>e <ESC>:set modifiable!<CR><ESC>:set modifiable?<CR>
"set color number
"default to 256 colors. This could have problem in term not support 256 colors.
if !has("gui_running") 
    set t_Co=256
    "set t_AB=[48;5;%dm
    "set t_AF=[38;5;%dm
endif

"set color scheme 
set bg=dark
if(&t_Co == 88)
    colorscheme desertEx
else
    colorscheme desertEx
endif

"set highit cursor line
"set cursorline
"hi cursorline cterm=bold ctermbg=235 guibg=darkgreen
hi TabLineSel cterm=bold ctermbg=4

if has("gui_running")
  "set font
  if has("unix")
    "set guifont=Monospace\ 14
    set guifont=Monaco\ for\ powerline\ 12
    "exceed work slowly in Monospace font
    "set guifont=Fixed\ 14 

  elseif has("win32")
    set guifont=Monaco:h12
  endif

  "Omni menu colors
  hi Pmenu guibg=#333333
  hi PmenuSel guibg=#555555 guifg=#ffffff
  set guioptions-=T

endif


"tab page related setting.
try
  set switchbuf=usetab
  "alway show tabline
  "  set stal=2
catch
endtry


"netrw setting
"open in new tab
let g:netrw_browse_split=3


"Enable use of the mouse.
"this setting will cause some problem in scroll back(mouse wheel) of screen
if($term!="^screen")
  set mouse+=a
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

else ""//v:version >= 700
"===================================================================================================
" vim 6 config
"===================================================================================================
endif 
"==================================================================================================

"==================================================================================================
" General  config
"==================================================================================================

filetype plugin on
if has("autocmd")
    filetype plugin indent on
endif

"set cspc=2

"setting for virtual edit 
"set virtualedit=all

set nowrap
map <LEADER><LEADER>w <ESC>:set wrap!<cr><ESC>:set wrap?<cr>


"expand tab to space
"et only expand tab in insert mode, not expand tab when read file
set et


"convention of springsoft code indent
set shiftwidth=4
"do not change tab stop for indent if not necessary
set tabstop=4

"setting for auto indent
set ai
set si

"setting for auto search on visual selection
"vmap <C-F> y/<C-R>"<CR>
vnoremap // "vy/<C-R>v<CR>
"backspace in Visual mode deletes selection
vnoremap <BS> d

"Turn on WiLd menu
set wildmenu


"Change buffer - without saving
set hid

"nnoremap .. :ls<CR>:b<space>
"nnoremap .. <c-e> :set nomre <Bar> :ls<Bar> :set more<CR>:b<space>

"show matched bracket
"set showmatch

set nu
map <LEADER><LEADER>n <ESC>:set nu!<cr><ESC>:set nu?<cr>


"incremental search
set incsearch
"ignore caes when search
set ignorecase
"set smartcase "cause auto complete case sensitive too
map <LEADER><LEADER>ic <ESC>:set ignorecase!<CR><ESC>:set ignorecase?<CR>

"special characters that can be used in search patterns.
set magic

"indent contrl with tab and s-tab
nmap <tab> V>
nmap <s-tab> V<

"setting file encoding to search multiple encoding when support
if has("multi_byte")
  "set bomb
  set fileencodings=latin1,ucs-bom,utf-8,big5,cp936
  "with termencoding, vim can read utf8 file and translate to termencoding(cp950). Then putty/screen can read with cp950(big5) without config as utf8
  "set termencoding=cp950
  "set encoding=utf-8
endif

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"disable search light
map <LEADER><LEADER>l :nohls<CR>
"sudo write
command Sudow w !sudo tee % > /dev/null


set viminfo='10,f0

"================================================================================
" QUICKFIX WINDOW
"================================================================================
" chage g:qfix_win to tab base var t:qfix_win can operate between tabpages
" add tabdo can open/close on every tab
if v:version < 700
    command -bang -nargs=? QFix call QFixToggle(<bang>0)
    function! QFixToggle(forced)
        if exists("t:qfix_win") && a:forced == 0
            cclose
            unlet t:qfix_win
        else
            copen 10
            let t:qfix_win = bufnr("$")
        endif
    endfunction
    "nnoremap <leader>q :QFix<CR>
else
    "QFixToggle fail when quickfix will open automatically
    nnoremap qq :call QFixSwitch()<CR>

    "QFixSwitch can be done by change g:qfix_win of QFixToggle to t:qfix_win.
    "Still keep for memo
    function! QFixSwitch()
        let tabbuflist = tabpagebuflist()
        for i in tabbuflist
            if(getbufvar(i,"&bt") == "quickfix")
                cclose
            else
                copen
            endif
        endfor
    endfunction
endif

"================================================================================

"================================================================================
"VIM TIP
"================================================================================
"Remove the Windows ^M
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Remove indenting on empty lines
"map <F2> :%s/\s*$//g<cr>:noh<cr>''

"add newline for pattern 
(c-v,c-m)
":%s/pattern/
/g

"set report=0
"count keyword
":%s/word/&/g
"count line (lines)
":%s/^ 
"count words
":%s/\i\+/&/g
"count char
":%s/./&/g
"find module in verilog
":map <F6> ma?^\s*\<module\><CR>Wyiw'a:echo "module -->" @0<CR>
"================================================================================

"move selected block up/down in visual block mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"================================================================================
"local syntax
"================================================================================
syn keyword btTF TRUE FALSE
hi link btTF Constant


"================================================================================
"Plug  confguration
"================================================================================

"================================================================================
"map ,t <ESC>:TagbarToggle<cr>
"let g:tagbar_ctags_bin = '/depot/ctag-5.5.4/bin/ctags'
"================================================================================

"================================================================================
"QuickBuf
let g:qb_hotkey = ",," 

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ackprg = 'ag --vimgrep'
    let g:BckPrg = 'ag --vimgrep'
endif

"================================================================================
"omin
if v:version >= 700
  set completeopt-=preview
endif

"================================================================================
"jQuery Syntax file
"au BufRead,BufNewFile *.js set ft=javascript.jquery


"================================================================================
"python.vim alternate python syntax
let python_highlight_all= 1

"================================================================================
"NERD_tree key map
"map ,n :NERDTreeToggle<cr>
"map <F10> <ESC>:NERDTreeFind<cr>
"let g:NERDTreeIgnore = ['\~$','\.o$','\.moc.cpp$','_bf_ckcancel$','^CVS$']
"let g:NERDTreeWinSize = 20
"let g:NERDTreeDirArrows=0

"================================================================================
"SuperTab
"let g:SuperTabMappingForward = '<c-tab>'
"let g:SuperTabMappingBackward = '<tab>'
"let g:SuperTabDefaultCompletionType = "<c-x><c-p>"
"

"================================================================================
"Easymotion
map <space> <Plug>(easymotion-prefix)
let g:EasyMotion_keys=';abcdefghijklmnopqrstuvwzyz'
"let g:EasyMotion_keys='asdfghjkl'

"================================================================================
"grepper
cnoremap <c-n> <down>
cnoremap <c-p> <up>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

nnoremap <leader>gs :Grepper -tool ag -side<cr>
nnoremap <leader>*  :Grepper -tool ag -cword -noprompt<cr>
nnoremap <leader>b* :Grepper -buffer -tool ag -noprompt -cword<cr>

let g:grepper = {
    \ 'tools': ['ag', 'git', 'grep'],
    \ 'open':  1,
    \ 'jump':  0,
    \ }

"================================================================================
"errormarker
let g:errormarker_disablemappings = 1

"================================================================================
"cowork with indentline
set list lcs=tab:\|\ 

"================================================================================
"Syntastic syntax checking
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
let g:alternateExtensions_cc = "hh,h,H,hpp,HPP"
let g:alternateExtensions_hh = "c,cc,cpp,cxx,CC"
""    set laststatus=2

"================================================================================
" started In Diff-Mode set diffexpr (plugin not loaded yet)
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
let g:diffa_enable = 0
if &diff
    let g:diffa_enable = 0
endif


"================================================================================
"fzf
map ,. :Buffers<cr>
map <leader>his :History<cr>
map <leader>h: :History:<cr>

"================================================================================
"conque_gdb
let g:ConqueGdb_GdbExe = '/u/tyshen/util/bin/gdb'
let g:ConqueGdb_SaveHistory = 1

set makeprg=/u/tyshen/util/bin/vgbuild.vim.sh

