syntax on

" Change dir based on file
set autochdir

" Searching
set ignorecase
set smartcase
set nohlsearch

" Enable cursor line
set cursorline

" 7 lines to cursor
set scrolloff=7

" number labels
set number
set relativenumber

set nowrap

" Mark columns 72,79 so we have a sense for how long a line is getting
" (72 characters is the recommended length for comments and docstrings
" in PEP 8
set colorcolumn=72,79

" Tabs are four spaces, Linus Torvalds be damned
set expandtab
set tabstop=4
set shiftwidth=4

" Tab completion in command mode (e.g. :help partial-topic<TAB>)
set wildmenu

" Map sequence gqq to format the current paragraph
noremap gqq gqap

" If we opened vim without any specified file, bring up 
" a list of recent files
function RecentFilesList()
    if @% == ""
        " No filename for current buffer
        browse oldfiles
    endif
endfunction

au VimEnter * call RecentFilesList()
        
" Pre-populate registers with some useful snippets
let @i = "import code; code.interact(local=locals())\n"

" Put swap/backup files in a single place instead of polluting CWD
" Courtesy of Hacker News user parfe: https://news.ycombinator.com/item?id=1690673
" N.B. these directories must exist, or vim will fall back on .
set backupdir^=~/.vim/backup//
set directory^=~/.vim/swp//

" Buffer navigation
map <C-H> :bp!<ENTER>
map <C-L> :bn!<ENTER>

" netrw fixins from https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Syntax highlighting when modifying dotfiles additions to bashrc
autocmd BufNewFile,BufRead *.bashrc.patch setfiletype sh

" MAD-X specifics
autocmd BufNewFile,BufRead *.mdx setfiletype madx
autocmd BufNewFile,BufRead *.md setfiletype markdown
autocmd BufNewFile,BufRead *.srv set nowrap

" Courtesy of StackOverflow user jqno, with a custom toggle function
" http://stackoverflow.com/a/1676672/2881396
" Commenting blocks of code.
autocmd FileType c,cpp,java,scala,javascript let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType madx             let b:comment_leader = '! '
" weirdly, Ctrl+/ is recognized as Ctrl+_ ?
noremap <silent> <C-_> :call ToggleComment(b:comment_leader)<CR>

function! ToggleComment(commentchar) range
    let lnum = a:firstline
    let commentchar_esc = escape(a:commentchar,'\/"%>#')
    while lnum <= a:lastline
        exe "normal " . lnum . "gg"
        if match(getline(lnum), "^\W*" . commentchar_esc) > -1
            exe (":s/^\s*" . commentchar_esc . "//")
        else
            exe "normal gI" . a:commentchar
        endif
        let lnum = lnum + 1
    endwhile
    exe "normal " . a:firstline . "gg"
endfunction

"  *** VISUALS ***
execute pathogen#infect()
let g:solarized_italic=0
let g:airline#extensions#tabline#enabled = 1
" Status bar
set laststatus=2
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" And the modification time
let g:airline_section_b="Modified: %{strftime('%H:%M %Z %x',getftime(expand('%')))}"

" Scheme fixins
set t_Co=256
let g:solarized_termcolors = &t_Co
set background=dark
colorscheme solarized
let g:airline_theme='solarized'

" Highlight sloppy language as if it were an error
syntax keyword WeaselWords Clearly clearly Obviously obviously
highlight link WeaselWords ErrorMsg

" vim-hardtime config, to limit my habit of holding hjkl
let g:hardtime_default_on = 1
let g:hardtime_timeout = 2000
let g:hardtime_maxcount = 15
let g:hardtime_showmsg = 1

" vim, what the hell is the name of the C-style function I'm looking at 
" right now?  " Courtesy of StackOverflow user manav m-n: 
" https://stackoverflow.com/a/23259759/2881396
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
command FunctionName call ShowFuncName()

" Rebuild documentation for plugins
:Helptags
