syntax on
filetype indent plugin on

" Change dir based on file
set autochdir

" Persistent undo (guess why I included this?)
set undofile
set undodir=~/.vim/undo

" Searching
set ignorecase
set smartcase
set nohlsearch

" Show location of cursor
set cursorline
set cursorcolumn

" 7 lines of margin around the cursor
set scrolloff=7

" number labels
set number
set relativenumber

set nowrap

" Mark columns 72,79 so we have a sense for how long a line is getting
" (72 characters is the recommended length for comments and docstrings
" in PEP 8)
set colorcolumn=72,79

" Tabs are four spaces, Linus Torvalds be damned
set expandtab
set tabstop=4
set shiftwidth=4

" Tab completion in command mode (e.g. :help partial-topic<TAB>)
set wildmenu

" If we're in cursorbind mode with more than one window, just redraw the screen every time we navigate. 
" Probably pretty slow, but that's why there's a flag
let g:redraw_when_bound=1
nnoremap <expr> h (g:redraw_when_bound && winnr('$')>1 && &cursorbind) ? "h:redraw!<CR>:echo('hi')<CR>" : 'h' 
nnoremap <expr> j (g:redraw_when_bound && winnr('$')>1 && &cursorbind) ? "j:redraw!<CR>:echo('hi')<CR>" : 'j' 
nnoremap <expr> k (g:redraw_when_bound && winnr('$')>1 && &cursorbind) ? "k:redraw!<CR>:echo('hi')<CR>" : 'k' 
nnoremap <expr> l (g:redraw_when_bound && winnr('$')>1 && &cursorbind) ? "l:redraw!<CR>:echo('hi')<CR>" : 'l' 

" Bugfix for LogiPat plugin shadowing :E for :Explore
" Courtesy of StackOverflow user melpomene, https://stackoverflow.com/a/31695784/2881396
let g:loaded_logipat = 1

" Map sequence gqq to format the current paragraph
noremap gqq gqap

" Map <leader>i to pipe the current selection (or entire file) to ix.io for a quick paste
" Courtesy of Omar Abou Mrad: http://aboumrad.info/faster-pastes-with-ix-io.html
noremap <silent> <leader>i :w !ix<CR>

" If we opened vim without any specified file, bring up 
" a list of recent files
function RecentFilesList()
    if @% == ""
        " No filename for current buffer
        browse oldfiles
    endif
endfunction

au VimEnter * call RecentFilesList()
        
" Snippets for things I'd have to otherwise look up. Some of these use :read,
" some use :edit! to open the file in a new buffer for yanking
command NumpyDoc :edit! ~/.vim/templates/numpydoc.py

command ArgparseTemplate :read ~/.vim/templates/argparse.py
command ScriptMain :read ~/.vim/templates/script_main.py

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
autocmd BufNewFile,BufRead *.srv set nowrap

" I mean Markdown when I have .md, not Modula-2!
autocmd BufNewFile,BufRead *.md setfiletype markdown

if !empty(glob("~/.vim/plugin/black.vim"))
    let g:black_enabled = 0  " disabled by default for now...
    function! PyBlack()
        if g:black_enabled > 0
            exe "Black"
        endif
    endfunction

    " Automatically run Python through the Black formatter if enabled
    autocmd BufWritePre *.py :call PyBlack()
endif

" Highlight sloppy language as if it were an error
syntax keyword WeaselWords Clearly clearly Obviously obviously
highlight link WeaselWords ErrorMsg

" fenced syntax highlighting for code blocks in Markdown
let g:markdown_fenced_languages = ['cpp', 'madx', 'javascript', 'python']

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

" Toggle scrollbind on/off with F10
map <F10> :set scrollbind!<CR>:set scrollbind?<CR>

" Toggle line numbering with F5, useful for copying in KiTTY
map <F5> :set number!<CR>:set relativenumber!<CR>

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

" vim-hardtime config, to limit my habit of holding hjkl
let g:hardtime_default_on = 1
let g:hardtime_timeout = 750
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

" required for vim compiled with dynamic Python
let g:jedi#force_py_version = 3
" disable immediate completion of Python
let g:jedi#popup_on_dot = 0
" don't automatically complete `from x` with `import`, it's jarring!
let g:jedi#smart_auto_mappings = 0

" Rebuild documentation for plugins
:Helptags
