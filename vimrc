"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"config for vundle 
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/vundle/ 
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-easymotion'
Bundle 'Raimondi/delimitMate'
"Bundle 'altercation/vim-colors-solarized'
Bundle 'cgraeser/vim-cmdpathup'
Bundle 'drmingdrmer/xptemplate'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
"Bundle 'jpalardy/vim-slime'
Bundle 'kana/vim-arpeggio'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'kien/tabman.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/zencoding-vim'
Bundle 'mileszs/ack.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'plasticboy/vim-markdown'
Bundle 'rainux/vim-desert-warm-256'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
"Bundle 'trapd00r/neverland-vim-theme'
"Bundle 'tyshen/snipmate.vim'

" vim-scripts repos
Bundle 'CRefVim'
Bundle 'EasyGrep'
Bundle 'IndexedSearch'
Bundle 'OmniCppComplete'
Bundle 'QuickBuf'
Bundle 'ShowMarks'
Bundle 'VisIncr'
Bundle 'a.vim'
Bundle 'camelcasemotion'
Bundle 'cscope.vim'
Bundle 'errormarker.vim'
Bundle 'verilog_systemverilog.vim'
Bundle 'textobj-user'
Bundle 'VimOutliner'

filetype plugin indent on     " required!
" or 
" filetype plugin on          " to not use the indentation settings set by plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime macros/matchit.vim
"copy from /etc/vimrc for some common setting
if has("unix")
    if(findfile("vimrc","/etc/")!="")
        source /etc/vimrc
    endif
elseif has("win32")
    set nocompatible
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    set noswf
    set nobackup
else
    set nocompatible
    set ruler
    syntax on
endif
set nocompatible
set ruler
syntax on
set hls

"===================================================================================================
" vim 7 config
"===================================================================================================
if v:version >= 700

map <LEADER>e <ESC>:set modifiable!<CR><ESC>:set modifiable?<CR>
"set color number
"default to 256 colors. This could have problem in term not support 256 colors.
if !has("gui_running") 
    set t_Co=256
    "set t_AB=[48;5;%dm
    "set t_AF=[38;5;%dm
endif

"set color scheme 
if has("gui_running")
  "colorscheme railscasts
  colorscheme monokai
else
  if(&t_Co == 8) 
    colorscheme desertEx
  else
    "set background=dark "for peaksea color scheme
    "colorscheme mywombat256
    "colorscheme desert256
    "colorscheme twilight256
    "colorscheme desert-warm-256
    "colorscheme 256-grayvim
    "colorscheme desertEx 
    "colorscheme deveiate 
    "colorscheme inkpot 
    "colorscheme railscasts 
    "colorscheme monokai
    "colorscheme molokai
    colorscheme xoria256
    "colorscheme burnttoast256
  endif
endif

"set highit cursor line
set cursorline
hi cursorline cterm=bold ctermbg=235 guibg=darkgreen
hi TabLineSel cterm=bold ctermbg=4

if has("gui_running")
  "set font
  if has("unix")
    set guifont=Monospace\ 14
    "exceed work slowly in Monospace font
    "set guifont=Fixed\ 14 

  elseif has("win32")
    "set guifont=ProFontWindows:h12
    set guifont=Monaco:h12
  endif

  "Omni menu colors
  hi Pmenu guibg=#333333
  hi PmenuSel guibg=#555555 guifg=#ffffff
  "set guioptions-=T

endif


"tab page related setting.

try
  set switchbuf=usetab
  "alway show tabline
  "  set stal=2
catch
endtry

"open tag and file with tab
"nmap <C-]> viwy:tab tag <C-R>"<CR>
"nmap gf :tabedit <cfile><CR>

"netrw setting
"open in new tab
let g:netrw_browse_split=3

"tab page hot key
noremap <C-F4> :tabc
inoremap <C-F4> <C-O>:tabc
cnoremap <C-F4> <C-C>:tabc
" CTRL+N is new tab
"noremap <C-N> :tabe<CR>
"inoremap <C-N> <C-O>:tabe<CR>
"cnoremap <C-N> <C-C>:tabe<CR>


"open every buffer in new tab
"PS1: project plugin have problem on this
"au BufAdd,BufNewFile,BufRead * nested tab sball

"set tab page header label and color
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label = ''

  " Add '+' if one of the buffers in the tab page is modified
  if getbufvar(buflist[winnr - 1], "&modified")
    let label = '+'
  endif

  return label . substitute(bufname(buflist[winnr - 1]),".*/","","g") "show file name only
endfunction

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  return s
endfunction

set tabline=%!MyTabLine()


function GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor

  " Append the number of windows in the tab page if more than one
  let wincount = tabpagewinnr(v:lnum, '$')
  if wincount > 1
    let label .= wincount
  endif
  if label != ''
    let label .= ' '
  endif

  " Append the buffer name
  return label .  substitute(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]),".*/","","g") 
endfunction
set guitablabel=%{GuiTabLabel()}

"Enable use of the mouse.
"this setting will cause some problem in scroll back(mouse wheel) of screen
if($term!="screen")
  set mouse=a
endif

else ""//v:version >= 700
"===================================================================================================
" vim 6 config
"===================================================================================================
"noremap <C-D> :bd<CR>
endif 
"==================================================================================================

"==================================================================================================
" General  config
"==================================================================================================

filetype plugin on
if has("autocmd")
    filetype plugin indent on
endif

"if filereadable("~/util/tagfile/${branch}tags")
"  set tags+=~/util/tagfile/${branch}tags
"endif
if filereadable("tags")
  set tags+=./tags
endif
command Csadd :cs add ~/util/tagfile/plcscope ~/LINUX/fle2
function Lxr()
    set cscopeprg=lxrtag
    cs add ~/util/tagfile/qttags
endfunction
command Lxrtag call Lxr()
function Alltags()
    set tags+=~/util/tagfile/bttags
    set tags+=~/util/tagfile/qttags
    call Lxr()
endfunction
command Atag call Alltags()
"set cspc=2

"setting for virtual edit 
"set virtualedit=all

set nowrap
map <LEADER>w <ESC>:set wrap!<cr><ESC>:set wrap?<cr>

"swap paste mode
map <LEADER>pa <ESC>:set paste!<cr><ESC>:set paste?<cr>

"expand tab to space
"et only expand tab in insert mode, not expand tab when read file
set et


"convention of springsoft code indent
set shiftwidth=4
"do not change tab stop for indent if not necessary
set tabstop=4

"setting for auto indent
set ai
map <LEADER>i <ESC>:set ai!<CR><ESC>:set ai?<cr>

"setting for auto search on visual selection
vmap <C-F> y/<C-R>"<CR>

"Turn on WiLd menu
set wildmenu


"
"Customized for SPS env
"
"integrated compiler
"filter out warning from bt. ONLY FOR SPS ENV
"command Makeb :set makeprg=makeb\\\|\&sed\ \"\/invalid\ offsetof\ from\/d;\/daSigIP_MethodArgument_S\/d\"
"command Makei :set makeprg=makei\\\|\&sed\ \"\/invalid\ offsetof\ from\/d;\/daSigIP_MethodArgument_S\/d\"
"command Makep :set makeprg=makep\\\|\&sed\ \"\/invalid\ offsetof\ from\/d;\/daSigIP_MethodArgument_S\/d\"
"command Maken :set makeprg=make\\\|\&sed\ \"\/invalid\ offsetof\ from\/d;\/daSigIP_MethodArgument_S\/d\"
function SPSmakecmd(type)
    let l:orgcmd=&makeprg
    execute 'set makeprg=' . a:type . '\\\|\&sed\ \"\/invalid\ offsetof\ from\/d;\/daSigIP_MethodArgument_S\/d\"'
    make
    "recovery original setting when need
    "execute 'set makeprg='.escape(l:orgcmd,' /|&"\')
endfunction
command Makeb call SPSmakecmd("makeb")
command Makei call SPSmakecmd("makei")
command Makep call SPSmakecmd("makep")
command Makeg call SPSmakecmd("makeg")
map <F8> <ESC>:cd %:h<CR>:make<CR>
"if v:version >= 700
"Makeb
"endif
"integrate with springsoft customized cvs cmd
command Ckout :!ckout %<CR>:e!
command Ckcancel :!ckcancel %<CR>:e!


"Change buffer - without saving
set hid

"show matched bracket
"set showmatch

"show line no
"if v:version >=703
"  set rnu
"else
  set nu
"endif


"set autoindent
"set smartindent

"incremental search
set incsearch
"ignore caes when search
set ignorecase
"set smartcase "cause auto complete case sensitive too
map <LEADER>ic <ESC>:set ignorecase!<CR><ESC>:set ignorecase?<CR>

"special characters that can be used in search patterns.
set magic

"backspace in Visual mode deletes selection
vnoremap <BS> d

"indent contrl with tab and s-tab
nmap <tab> V>
nmap <s-tab> V<

"disable swap file
"set noswapfile

"setting file encoding to search multiple encoding when support
if has("multi_byte")
  "set bomb
  set fileencodings=latin1,ucs-bom,utf-8,big5
  "with termencoding, vim can read utf8 file and translate to termencoding(cp950). Then putty/screen can read with cp950(big5) without config as utf8
  "set termencoding=cp950
endif

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"disable search light
map ,l :nohls<CR>
"toggle line number
map <leader>n <ESC>:set nu!<CR>
"sudo write
command Sudow w !sudo tee % > /dev/null

"just reference
"Fast modify in equation Ex.(a=b)
"Key:cr modify left statment
"Key:cl modify right statment
"if &ft == 'python'
"  nmap cr=    $F=lc$
"else
"  nmap cr=    $F=lcf;
"endif
"  nmap cl=    $F=hc^

"work around for arrow fail in insert mode
"http://vim.wikia.com/wiki/Fix_broken_arrow_key_navigation_in_insert_mode
"set timeout ttimeoutlen=100 timeoutlen=5000

"enable number pad only when need
"map <Esc>Oq 1
"map <Esc>Or 2
"map <Esc>Os 3
"map <Esc>Ot 4
"map <Esc>Ou 5
"map <Esc>Ov 6
"map <Esc>Ow 7
"map <Esc>Ox 8
"map <Esc>Oy 9
"map <Esc>Op 0
"map <Esc>On .
"map <Esc>OQ / "confilt with F2
"map <Esc>OR *
"map <Esc>Ol +
"map <Esc>OS -

"auto complete () {} []
"inoremap ( ()<ESC>i
"inoremap ) <c-r>=ClosePair(')')<CR>
"inoremap { {<CR>}<ESC>O
"inoremap } <c-r>=ClosePair('}')<CR>
"inoremap [ []<ESC>i
"inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap " ""<ESC>i
"inoremap ' ''<ESC>i
"function ClosePair(char)
"  if getline('.')[col('.') - 1] == a:char
"      return "\<Right>"
"  else
"      return a:char
"  endif
"endfunction

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

"add newline for pattern (c-v,c-m)
":%s/pattern//g

"set report=0
"count keyword
":%s/word/&/g
"count line (lines)
":%s/^ 
"count words
":%s/\i\+/&/g
"count char
":%s/./&/g
"================================================================================


"================================================================================
"local syntax
"================================================================================
syn keyword btTF TRUE FALSE
hi link btTF Constant


"================================================================================
"Plugin confguration
"================================================================================

"================================================================================
"Tag List plugin
let Tlist_Inc_Winwidth=0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window=1
map ,t <ESC>:TagbarToggle<cr>

"================================================================================
"Project plugin
let g:proj_flags="sgLmc"
map ,p <F12>

"================================================================================
"setting for Shell.vim plugin
let g:PROMPT=">"

"================================================================================
"setting for file-explorer plugin
let g:explHideFiles='\.gz$,\.exe$,\.zip$,\.o,\.moc.cpp,.*_bf_ckcancel$,\.swp$'
let g:explDateFormat="%d %b %Y %H:%M"
let g:explUseSeparators=1

"================================================================================
"open buffer explorer
"nmap <F9> :BufExplorer<CR>
"map ,b <ESC>:BufExplorer<CR>

"================================================================================
"QuickBuf
let g:qb_hotkey = ",," 

"================================================================================
"qnamebuf
"let g:qnamebuf_hotkey=",."
"let g:qnamefile_hotkey=",m"

"command-t
"nmap <silent> ,f :CommandT<CR>
"nmap <silent> ,m :CommandTBuffer<CR>
"nmap <silent> ,b :CommandTBuffer<CR>
"command -nargs=* Ct :CommandT <args>
"set wig+=*.o,*/CVS/*,*.bak,cron.*,*.a,*/inc/*,*/lib/*,*/.git/*,*/.hg/*,*/.svn/*,*.lib++,*.swp

"ctrlp.vim
let g:ctrlp_by_filename = 1
let g:ctrlp_map = ',f'
let g:ctrlp_jump_to_buffer = 2
let g:ctrlp_working_path_mode = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_mruf_include = '\.cpp$\|\.h$'
let g:ctrlp_max_depth = 40
let g:ctrlp_extensions = ['dir']
"let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
let g:ctrlp_custom_ignore = '\(\.o\|\.moc\.cpp\|\.a\|\.bak\|\.swp\|CVS\|\.git\|\.hg\|\.lib++\)$\|/inc/\|/lib/\|/GEMINIDB/'
nmap <silent> ,m :CtrlPBuffer<CR>
nmap <silent> ,or :CtrlP $PROD_ROOT/protoProd/src/rp<CR>
nmap <silent> ,om :CtrlP $PROD_ROOT/protoProd/src/hdlmod<CR>
nmap <silent> ,plcom :CtrlP $PROD_ROOT/share/src/flCompilePrePar<CR>

"================================================================================
"setting for tabber plugin not used now
let Tb_loaded= 1 " disable TabBar plugin
if exists('Tb_loaded') "tabbar was disabled then use my own tabpage hotkey
  " CTRL+d is close tab
  "nmap <C-D> :tabc<CR>
  if !has("gui_running")
    "configure for terminal
    map <unique> 1 <ESC>1gt
    map <unique> 2 <ESC>2gt
    map <unique> 3 <ESC>3gt
    map <unique> 4 <ESC>4gt
    map <unique> 5 <ESC>5gt
    map <unique> 6 <ESC>6gt
    map <unique> 7 <ESC>7gt
    map <unique> 8 <ESC>8gt
    map <unique> 9 <ESC>9gt
  else 
    " configure for gvim 
    map <unique> <M-1> 1gt
    map <unique> <M-2> 2gt
    map <unique> <M-3> 3gt
    map <unique> <M-4> 4gt
    map <unique> <M-5> 5gt
    map <unique> <M-6> 6gt
    map <unique> <M-7> 7gt
    map <unique> <M-8> 8gt
    map <unique> <M-9> 9gt
  endif
else
  " CTRL+d is close tab
  noremap <unique> <C-D> :bd<CR>
  "force TabBar to try to place selected buffers into a window that does not have a nonmodifiable buffer.
  "let g:Tb_ModSelTarget = 1
  ""Put new window below current or on the  right for vertical split
  ""let g:Tb_SplitBelow=1 
  "let g:Tb_MoreThanOne=2
  "let g:Tb_UseSingleClick = 1
  "let g:Tb_AutoUpdt = 0
  "map <F9> <ESC>:TbToggle<CR>
endif 
""================================================================================
"setting for MiniBufExplorer it has problem on cowork with project plugin
"Put new window below current or on the right for vertical split
"let g:miniBufExplSplitBelow=1
"use vertical mode
"let g:miniBufExplVSplit = 10
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplorerMoreThanOne=2

"================================================================================
"setting for VisualMakr
"set color again. Because color setting was erase usually by colorscheme
"if &bg == "dark"
" highlight SignColor ctermfg=white ctermbg=blue guifg=white guibg=RoyalBlue3
"else
" highlight SignColor ctermbg=white ctermfg=blue guibg=grey guifg=RoyalBlue3
"endif

"================================================================================
"setting for winmanager wks plugin
"let g:WorkspaceExplorerColours = {}
"let g:WorkspaceExplorerColours["Worksapce"]="Directory"
"let g:WorkspaceExplorerColours["Project"]="String"
"let g:WorkspaceExplorerColours["Filter"]="Type"
"let g:WorkspaceExplorerColours["File"]="Keyword"
"map <F9> <ESC>:WKSpace ~/util/wks/gaia.vimwks<CR>

"================================================================================
"omin
if v:version >= 700
  set completeopt-=preview
endif

"================================================================================
"jQuery Syntax file
au BufRead,BufNewFile *.js set ft=javascript.jquery

"================================================================================
"sienna colorscheme
let g:sienna_style = 'dark' " dark or light

"CSApprox
"disable plugin only enable when need. Enable CSApprox by comment option 
"CSApprox work not well in screen
"let g:CSApprox_loaded = 1

"python.vim alternate python syntax
let python_highlight_all= 1

"NERD_tree key map
map <F10> :NERDTreeToggle<cr>
map ,n <ESC>:NERDTreeToggle<cr>
let g:NERDTreeIgnore = ['\~$','\.o$','\.moc.cpp$','_bf_ckcancel$','^CVS$']
let g:NERDTreeWinSize = 20
let g:NERDTreeDirArrows=0

"SuperTab
"let g:SuperTabMappingForward = '<c-tab>'
"let g:SuperTabMappingBackward = '<tab>'
"
"myprojects
let g:myprojects_auto_open=0
let g:myprojects_syntax =0
let g:myprojects_cursorline=0

"showmarks
let g:showmarks_include="abcdefghijklmnopqrstuvwxyz"

"mark multiple 
map <Leader>cm <Plug>MarkClear

"Conque Shell
"(Defaults shown below)
" Return prompt to user after this many miliseconds without any new output from the terminal. 
" Increasing this value will cause fewer read timeouts, but will also make the terminal appear less responsive.
"let g:Conque_Read_Timeout = 40

" Use this syntax type with Conque. The default is relatively stripped down, although it does provide good MySQL highlighting
"let g:Conque_Syntax = 'conque'

" Terminal identification
" Leaving this value as "dumb" will cause the fewest formatting errors, and may make the terminal slightly faster. 
" Setting it to "xterm" will enable more features.
"let g:Conque_TERM = 'dumb'
"
"Easymotion
let g:EasyMotion_leader_key='.'
"EasyGrep
let g:EasyGrepMode = 2

"ranbow 
command Rainbow call rainbow_parentheses#activate()|call rainbow_parentheses#load('(',')')|call rainbow_parentheses#load('{','}')
let g:rbpt_colorpairs = [
			\ ['brown',       'RoyalBlue3'],
			\ ['Darkblue',    'SeaGreen3'],
			\ ['darkgreen',   'firebrick3'],
			\ ['darkcyan',    'RoyalBlue3'],
			\ ['darkred',     'SeaGreen3'],
			\ ['darkmagenta', 'DarkOrchid3'],
			\ ['brown',       'firebrick3'],
			\ ['yellow',      'yellow'],
			\ ['Darkblue',    'firebrick3'],
			\ ['darkgreen',   'RoyalBlue3'],
			\ ['darkcyan',    'SeaGreen3'],
			\ ['darkred',     'DarkOrchid3'],
			\ ['red',         'firebrick3'],
			\ ]

"Arpeggio
call arpeggio#map('i', '', 0, 'jk','<esc>')

"errormarker
let g:errormarker_disablemappings = 1

"emacs style keymap for inster mode
imap <C-b> <Left>
imap <C-n> <Down>
imap <C-p> <Up>
imap <C-f> <Right>
imap <C-v> <PageDown>
imap <M-v> <PageUp>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-q> <Esc>
imap <C-d> <Delete>

