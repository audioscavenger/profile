" http://danielmiessler.com/blog/enhancements-to-shell-and-vim-productivity

"set verbose=5

"1. If the environment variable $VIMRUNTIME is set, it is used.  You can use
"   this when the runtime files are in an unusual location.
"2. If "$VIM/vim{version}" exists, it is used.  {version} is the version
"   number of Vim, without any '-' or '.'.  For example: "$VIM/vim54".  This is
"   the normal value for $VIMRUNTIME.
"3. If "$VIM/runtime" exists, it is used.
"4. The value of $VIM is used.  This is for backwards compatibility with older
"   versions.
"5. When the 'helpfile' option is set and doesn't contain a '$', its value is
"   used, with "doc/help.txt" removed from the end.

" ==> For Unix, when there is a compiled-in default for $VIMRUNTIME (check the output of ":version"), steps 2, 3 and 4 are skipped, and the compiled-in default is used after step 5.  This means that the compiled-in default overrules the value of $VIM.

"    system vimrc file: "$VIM/vimrc"
"      user vimrc file: "~/etc/vim/vimrc"
"  2nd user vimrc file: "$VIMRUNTIME/vimrc"
"  3rd user vimrc file: "~/.vimrc" 

" http://phdru.name/Software/dotfiles/vimrc.html


"""""""""""""
" 1 important

" Remove ALL autocommands in case the file is sourced for the second time
autocmd!

language messages C " Print messages in English

if v:version >= 700
  "Example 1: setting runtimepath wiyh real hard path will work but it's not dynamic:
  "set runtimepath=$VIMRUNTIME,/portable/path

  "Example 2: this command appends $PWD to runtimepath, however that's not what we want:
  "let &runtimepath.=','.escape(expand('%:p:h'), '\,')

  "Example 3: forcely sourcing a file would also help vim to find the files from the runtimePortable:
  "so $VIMRUNTIME/syntax/syntax.vim

  " VIM 7+ PORTABLE SECONDARY SOLUTION:
  " http://stackoverflow.com/questions/3377298/how-can-i-override-vim-and-vimrc-paths-but-no-others-in-vim
  " Hence, we want to append a dynamic path to VIMRUNTIME.
  " 1) So, what is the name of the directory containing this file?
  let s:runtimePortable = expand('<sfile>:p:h')
  
  " 2) append the runtimePortable path to 'runtimepath', with all the other ones from the environment:
  let &runtimepath = printf('%s,%s,%s/after', s:runtimePortable, &runtimepath, s:runtimePortable)
  
  " 2b) alternatively, we can completely replace the runtimepath:
  "let &runtimepath = printf('%s/after', s:runtimePortable)
  " WARNING: printf do not work with vim6
else
  set runtimepath=~/.vim,/usr/share/vim,/usr/share/vim/vimfiles/after,~/.vim/after,$VIM
endif

" now to check the runtimepath content:
": set rtp

" http://blog.sanctum.geek.nz/gracefully-degrading-vimrc/
" THE solution for hard coded VIMRUNTIME path in many platforms
try
  syntax on
catch
  so $VIM/syntax/syntax.vim
endtry

if exists("b:wrap") " Only do this on the second and subsequent :source's
   let fenc = &fileencoding
   let ftype = &filetype
   let mod = &modified
   set all& " Reset all options, except terminal options, to their default value.
   execute 'set fileencoding=' . fenc
   execute 'set filetype=' . ftype
   if mod
      set modified
   else
      set nomodified
   endif
   unlet fenc ftype mod
endif

" No, it is not VI, it is VIM! It is important to set this first, because this
" command resets many other options.
set nocompatible

" Set behavior to xterm, not mswin
behave xterm


"""""""""""""""""""""""""""""""""""""""""
" 2 moving around, searching and patterns

set ignorecase    " Ignore case in search patterns
set smartcase     " Match 'word' case-insensitive and 'Word' case-sensitive
set nostartofline " Keep cursor's column
set whichwrap=b,s,h,l,<,>,[,],~ " Wrap to the previous/next line on all keys and ~ command
set magic         " changes special characters in search patterns (default)
set esckeys       " Required to be able to use keypad keys and map missed escape sequences


"""""""""""""""""""
" 4 displaying text

set display=lastline,uhex " Show the last line instead of '@'; show non-printable chars as <hex>
set lazyredraw    " Do not update screen while executing macros
set list          " listchars only works with 'list'
set listchars=tab:>_,trail:_,extends:+ " Show tabs, trailing spaces, long lines
set wrap          " Visually wrap long lines

" With 'set wrap' wrap long lines at a character in 'breakat'
" Please note 'nolist' is required to use 'linebreak'
set linebreak showbreak=+\ " A plus and a space
set sidescroll=1  " The minimal number of columns to scroll horizontally


""""""""""""""""
" 5 highlighting

set nohlsearch    " Stop the search highlighting
set showmatch     " show matching brackets
set showmode      " display mode INSERT/REPLACE/...
set showmatch


""""""""""""""""""""
" 6 multiple windows

set hidden        " Don't unload a buffer when no longer shown in a window; allow to switch between buffers/windows when the buffer is modified
set laststatus=2  " Always show status line
set splitbelow    " A new window is put below of the current one
set splitright    " A new window is put right of the current one


""""""""""""
" 8 terminal

set ttyfast       " terminal connection is fast
set title         " Set title to the value of 'titlestring' or to 'filename - VIM'
set titleold=     " string to restore the title to when exiting Vim


"""""""""""""""""""
" 9 using the mouse

" using mouse and wheel scrolling in putty is impressive, however copy paste from vim is affected: you need to hold SHIFT to copy
"set mouse=ar      " Use mouse in all modes, plus hit-return
set mouse=ar            " hold shift to copy xterm
set ttymouse=xterm2     " necessary for gnu screen & mouse

""""""""""""""""""""""
" 12 messages and info

set ruler         " Show cursor position below each window
set showcmd       " Show (partial) command keys in the status line
" Short message for [Modified];
" overwrite message for writing a file with subsequent message;
" truncate long file messages
set shortmess=mot


"""""""""""""""""
" 14 editing text

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set complete+=k                 " Scan spell dictionaries for completion in addition to standard places
set infercase                   " adjust case of a keyword completion match
set nojoinspaces                " Do not insert two spaces after a '.', '?' and '!' with a join command
set nrformats=hex               " I seldom edit octal numbers, but very often dates like 2001-02-01

" Default value 'croql' is a compromise for both natural and programming
" languages, but as any compromise it works good for neither natural nor
" programming languages. This value is good for natural texts,
" let ftplugins to set values suitable for programming languages.
set formatoptions=2t " list of flags that tell how automatic formatting works


"""""""""""""""""""""""
" 15 tabs and indenting

set paste        " disable indent when pasting
set expandtab     " expand <Tab> to spaces in Insert mode
set shiftwidth=2  " number of spaces used for each step of (auto)indent
set smarttab      " a <Tab> in an indent inserts 'shiftwidth' spaces
set softtabstop=2 " number of spaces to insert for a <Tab>
set noautoindent  " Do not automatically set the indent of a new line


""""""""""""
" 18 mapping

set timeout timeoutlen=3000 " allow timing out up to 3 seconds halfway into a mapping


"""""""""""""""""""""""""
" 21 command line editing

set history=1000            " how many command lines are remembered
set suffixes+=.pyc,.pyo     " list of file name extensions that have a lower priority
set wildignore+=*.py[co]    " Ignore these patterns when completing file names
set wildmenu                " command-line completion shows a list of matches
set wildmode=longest,list:longest,full " Bash-vim completion behavior

""""""""""""""""""""""""""""""""
" 22 executing external commands

if has("filterpipe")
  set noshelltemp           " Use pipes on Unix
endif

""""""""""""""""""""""""""""""""
" 23 editing crontab

set backupcopy=yes

""""""""""""""""""""""""""
" 25 multi-byte characters

" Automatically detected character encodings
set fileencodings=utf-8,ucs-bom,us-ascii,koi8-r,cp1251,cp866,latin1


""""""""""""
" 26 various

" ! - when included, save and restore global variables that start
"     with an uppercase letter, and don't contain a lowercase letter;
" h - disable the effect of 'hlsearch';
" ' - number of files for which the marks are remembered;
" " and < - maximum number of lines saved for a register;
" s - maximum size of an item in Kbytes.
if version < 603
   set viminfo=!,h,'50,\"1000
else
   set viminfo=!,h,'50,<1000,s10
endif

" c - convert viminfo to the current encoding;
if has("iconv")
   set viminfo^=c
endif

" Removable media paths
if has("win32")
   set viminfo+=ra:,rb:
endif

" highlight & colors ---------->
if has("gui_running")
  set background=light

  if has("win32")
    "set guifont=Courier_New:h18:cRUSSIAN
    set guifont=Lucida_Console:h18:cRUSSIAN
  else
    set guifont=Monospace\ 18
    set toolbar=icons,text " how to show the toolbar
  endif

  " set guicursor+=a:blinkon0 " Stop cursor blinking

  " Make shift-insert work like in Xterm
  " map <S-Insert> <MiddleMouse>
  " map! <S-Insert> <MiddleMouse>


  " Set nice colors
  " Background for normal text is light grey
  " Cursor is green
  " Text below the last line is darker grey
  " Status line is bright white on blue
  highlight Normal guibg=grey90
  highlight Cursor guibg=green guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant guibg=grey90
  highlight Special gui=NONE guibg=grey90
  highlight StatusLine gui=bold guifg=white guibg=blue

  " ----------
  " From http://slobin.pp.ru/vim/_vimrc.html

  " Arrows should go into wrapped lines, but not while popup menu is visible
  imap <expr> <Down> pumvisible() ? "<Down>" : "<C-O>gj"
  imap <expr> <Up> pumvisible() ? "<Up>" : "<C-O>gk"

  " The <CR> key should select from completion menu without adding a newline
  imap <expr> <CR> pumvisible() ? "<C-Y>" : "<CR>"
  " ----------

else

  if (&term =~ "linux") || ($BACKGROUND == 'DARK') || ($BACKGROUND == 'dark') || has("win32")
    " Background of the terminal is black or dark grey
    set background=dark
  else
    set background=light
  endif

  if (&term =~ "linux")
    set <BS>=<7f>
  else
    highlight MoreMsg cterm=bold ctermfg=NONE
    highlight Question cterm=bold ctermfg=NONE
  endif

  if (&term =~ "term") || (&term =~ "rxvt") || (&term =~ "vt100") || (&term =~ "screen")
    " 'autoselect' to always put selected text on the clipboard;
    " 'unnamed' to use the * register like unnamed register '*'
    " for all yank, delete and put operations;
    " This allows to use mouse for copy/paste in local xterm,
    " but prevents to save the unnamed register between sessions.
    " set clipboard=autoselect,unnamed,exclude:cons\|linux

    " http://drupal7.notanothersheep.com/?q=node/29
    if has("terminfo")
      if &term == "xterm-256color"
        set t_Co=256
        colorscheme xoria256.1.6
        " colorscheme notepad++
      else
        set t_Co=16
      endif
      set t_Sf=[3%p1%dm
      set t_Sb=[4%p1%dm
    else
      set t_Co=8
      set t_Sf=[3%dm
      set t_Sb=[4%dm
    endif
   endif

  if (&term =~ "screen")
    set ttymouse=xterm " Enable mouse codes under GNU screen
  endif
endif

highlight SpellBad term=underline cterm=NONE ctermfg=white ctermbg=red guifg=white guibg=red " gui=undercurl guisp=red
highlight StatusLine cterm=bold ctermfg=white ctermbg=blue gui=NONE guifg=white guibg=blue
highlight Visual cterm=NONE ctermfg=white ctermbg=blue gui=NONE guifg=white guibg=blue " Selection highlighting
" highlight & colors ----------<

" Multiline comments often confuse vim syntax highlighting - these maps
" allow to resynchronize; the first is faster, the second is more thorough
nmap \sc :syntax sync clear<Enter>
nmap \ss :syntax sync fromstart<Enter>


""""""""""""""
" AUTOCOMMANDS

" Enable filetype detection
filetype plugin indent on

" Reread me after editing
autocmd BufWritePost ~/.vimrc source ~/.vimrc | syntax on

if version >= 700
  " Save all files before running any quickfix command (grep, makeprg, etc.)
  autocmd QuickFixCmdPre * wall
endif

" Syntax highlighting
"autocmd BufReadPost * syntax on

" Restore last known cursor position
function! RestorePosition()
   if exists('b:position_restored')
      return
   endif

   if line("'\"") > 0
      call cursor(line("'\""), col("'\""))
   endif
   let b:position_restored = 1
endfunction

" When editing a file, always jump to the last cursor position (if saved)
autocmd BufReadPost * call RestorePosition()

function! SlowTerm()
   set laststatus=1
   set noruler
   set shortmess=aoOtT
   set noshowcmd
   set scrolljump=5 " The minimal number of lines to scroll vertically when the cursor gets of the screen
   set sidescroll=5
   set nottyfast
   set notitle
   set timeoutlen=5000
   set nowildmenu
   set wildmode=list:longest
   set viminfo=!,h,'10,<100,s5
   syntax off
   highlight NonText cterm=NONE ctermfg=NONE
endfunction

if exists("$SLOWTERM")
   call SlowTerm()
endif



" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on search pattern highlighting.
  set hlsearch

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  highlight Normal guibg=grey90
  highlight Cursor guibg=Green guifg=NONE
  highlight lCursor guibg=Cyan guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95

endif


" cycle between colorschemes :
" :colorscheme,space,TAB
" :colorscheme,space,CTRL+d
"
" Show whitespace and EOL characters
"set list
"
" Show line numbers
" set nu
" Hide Line Numbers
" set nonu
"
" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty
" Define the point at which lines wrap in vanilla mode
set wrapmargin=10
"
""" show whole debug when something get wrong: type this:
":so $VIMRUNTIME/bugreport.vim
""" show built-in terminal-info:
":set term=xxx


" http://vimdoc.sourceforge.net/htmldoc/filetype.html
" loads default filetype
setfiletype sh

" This has to go to the very end of ~/.vimrc to allow reading the .vimrc
set secure        " safer working with script files in the current directory
