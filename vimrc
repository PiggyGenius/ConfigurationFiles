""""""" TODO """"""""
" Remap ` for marks "
""""""" TODO """"""""

set nocompatible " Uses vim coloring instead of vi
set shellcmdflag=-ic " Allows vim to load bashrc
set encoding=utf-8
set fileencoding=utf-8
filetype off " Needed for vundle
syntax on " Set syntax coloring
set tags+=,.tags; " Adds .tags to the list of possible tag filenames
set path+=$PWD/** " Allows vim to do recursive finds
 "Remove the \ in front of the last \" if you want to use it, usefull if not working in root dir
 "let &path .= system("git rev-parse --show-toplevel | tr -d '\\n'") . \"/**" . \",./**"

" TODO CHANGE SPACES TO TABS
"set softtabstop=0 " Default but let us specify it
"set noexpandtab " We don't want to fill tab with spaces
"set expandtab

set tabstop=4 " Set the width of tab measured in spaces
set shiftwidth=4 " Set indent width
set relativenumber " We want to see line numbers, relatively for simpler yanks
set number " But instead of 0, lets display the real line number
set fileencoding=utf-8 " Set encoding to utf-8
set cindent " Smarter indent than autoindent
set backupdir=~/.vimtmp,. " Directories for backup files from left to right, seperated by comma
set directory=~/.vimtmp,. " Directories for swp files from left to right, seperated by comma
set clipboard=unnamed " We want to use the system clipboard to copy between vim instances.
set backspace=indent,eol,start " Allows you to backspace everything
set history=500 " Keep 500 lines of command line history
set incsearch " Nicer search interface
set mouse=a " Enable mouse
" Prohibits Vim to complete tabs by the first working string
set wildmode=longest,list,full
set wildmenu
set hlsearch " Highlight all words matching search
set foldenable " Allows vim to fold functions
set foldlevelstart=99 " Only folds functions with more than 99 blocks
set foldmethod=syntax " We want to fold blocks
set fillchars="fold: " " Removes the dashes at the end of folds

" Configuration for nicer tab coloring, nicer fold coloring
hi TabLineFill term=bold cterm=bold ctermbg=282828
hi TabLine term=bold cterm=bold ctermbg=282828 ctermfg=282828
hi TabLineSel term=bold cterm=bold ctermbg=Black ctermfg=282828
hi Folded term=underline ctermfg=6 ctermbg=282828

filetype plugin indent on " Adapt indenting to filetype
" Open new buffer into tab
autocmd BufReadPost * tab ball
autocmd BufRead *.md set ft=markdown
" Set X bit on files containing #! on first line
"autocmd BufWritePost,FileWritePost * if getline(1) =~ "^#!" | silent !chmod u+x <afile>
"set autoread " If file changed, you want vim to read it again, mainly for chmod
" Close vim if the only window open is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Vim opens file with cursor on last known position
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\ exe "normal! g`\"" |
\ endif

set runtimepath+=~/.vim/bundle/Vundle.vim " Directories searched for runtime files
call vundle#begin() " Vundle is going to load the plugins
Plugin 'VundleVim/Vundle.vim' " Vundle has to manage Vundle
Plugin 'valloric/youcompleteme' " Code completion engine
Plugin 'rdnetto/ycm-generator' " Generates config files for YCM
Plugin 'scrooloose/nerdcommenter' " Commenter plugin
Plugin 'SirVer/ultisnips' " Snippet engine
Plugin 'scrooloose/nerdtree' " Display tree inside vim
Plugin 'jalvesaq/Nvim-R' " R features
Plugin 'dbext.vim' " SQL client in vim
Plugin 'jpalardy/vim-slime' " Oh you know, just enables communication between vim and everything...
call vundle#end()

let g:ycm_filetype_blacklist = {} " Allows us to have completion inside markdown
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py" " Setup global config file for YCM
let g:ycm_autoclose_preview_window_after_insertion = 1 " Close preview window after insertion
let g:ycm_autoclose_preview_window_after_completion = 1 " Close preview window after completion
let g:ycm_show_diagnostics_ui = 0 " We don't want the syntax checker of YCM
let mapleader="," " Change the leader key for nerdcommenter
let g:UltiSnipsExpandTrigger="<C-d>" " Expand trigger with ctrl key
let g:UltiSnipsListSnippets="<C-Space>" " List all snippets
let g:UltiSnipsJumpForwardTrigger="<C-b>" " Jump forward inside snippet
let g:UltiSnipsJumpBackwardTrigger="<C-z>" " Jumb backward inside snippet
let g:UltiSnipsEditSplit="vertical" " Vertical split when editing snippet
let g:UltiSnipsUsePythonVersion=2 " Vim uses python 2.7. Automatic detection if not specified
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips" " Snippets directory
let g:UltiSnipsSnippetDirectories=["UltiSnips"] " UltiSnippets will search for these directories
let g:dbext_default_history_file='~/.vim/bundle/dbext.vim/config/'
let g:dbext_default_profile_mySQLServer='type=MYSQL:user=carrel:passwd=`cat ~/.vim/bundle/dbext.vim/config/passwd.txt`:dbname=STUDIES'
let g:dbext_default_profile='mySQLServer'
let maplocalleader = "," " Better than \ for Nvim-R
let R_term = "terminator" " We want to use a terminator split
let R_tmux_split = 1 " Sadly, we have to use tmux
let R_rconsole_height = 28 " Nicer split on my home screen
let R_rconsole_width = 106 " Nicer split on my home screen
let R_assign = 2
let R_nvimpager = "vertical"
let R_in_buffer = 0
let R_applescript = 0
let g:EclimCompletionMethod = 'omnifunc' " Should autocomplete java with eclim
let g:slime_python_ipython = 1 " Enables the correct paste function for ipython5
let g:slime_default_config = {"sessionname": "slave", "windowname": "0"}
let g:markdown_fenced_languages = ['python', 'html']
let g:EclimSignLevel = 'error' " Only show errors on vim
xmap <C-e> <Plug>SlimeRegionSend
nmap <silent><C-x> :SlimeSendCurrentLine<CR>
nmap <C-e> <Plug>SlimeParagraphSend
"map <silent><C-m> :NERDTreeToggle<CR>
map <silent><C-l> :noh<CR>
map <silent>td :bd<CR>
inoremap <C-s> <Esc>
vnoremap <C-s> <Esc>

" Because fuck hjkl
noremap z k
noremap k z
noremap s j
noremap j s
noremap q h
noremap h q
noremap d l
noremap l d
noremap ll dd

nnoremap K K<CR>
nnoremap tg gT
" Allows us to open a tag in a new tab
nnoremap <silent><C-f> <C-w><C-]><C-w>T
" Allows us to create a tag file from current directory
command! MakeTags silent execute "!ctags -Rf .tags ." | redraw!
" Allows us to compile tex/md files inside vim
command! Mh silent execute "!html %:t" | redraw!
command! Mp silent execute "!pdf %:t" | redraw!
" Open the output of the tex/md file without leaving vim
command! Cp silent execute "!chrome %:r.pdf" | redraw!
command! Ch silent execute "!chrome %:r.html" | redraw!

" The goal with this is te redfine the tabline function to remove X button, to be improved
function MyTabLine()
	  let s = ''
	  for i in range(tabpagenr('$'))
	    " select the highlighting
	    if i + 1 == tabpagenr()
	      let s .= '%#TabLineSel#'
	    else
	      let s .= '%#TabLine#'
	    endif
	    " the label is made by MyTabLabel()
	    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
	  endfor
	  " after the last tab fill with TabLineFill and reset tab page nr
	  let s .= '%#TabLineFill#%T'
	  return s
	endfunction
	function MyTabLabel(n)
	  let buflist = tabpagebuflist(a:n)
	  let winnr = tabpagewinnr(a:n)
	  "fnamemodify allows us to remove the full path here
	  return fnamemodify(bufname(buflist[winnr - 1]),':t')
	endfunction
set tabline=%!MyTabLine()

" Open fold with ka
function MyFoldText()
	let line = getline(v:foldstart)
	let sub = substitute(line, '{', '{!}', 'g')
	let indent_level = indent(v:foldstart)
	let indent = repeat(' ',indent_level-float2nr((sqrt(indent_level))))
	echo indent_level
	return indent . sub
endfunction
set foldtext=MyFoldText()
