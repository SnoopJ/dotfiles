syntax on

" Change dir based on file
set autochdir

" Searching
set ignorecase
set smartcase
set nohlsearch

" 7 lines to cursor
set scrolloff=7

" number labels
set number
set relativenumber
set nowrap

" Mark columns 72,79
set colorcolumn=72,79
set textwidth=79

" Tabbing
set expandtab
set tabstop=4
set shiftwidth=4

" Tab completion in command mode (e.g. :help partial-topic<TAB>)
set wildmenu

" Buffer navigation
map <C-H> :bp!<ENTER>
map <C-L> :bn!<ENTER>

" Note that these remaps eliminate the possibility of using 'm' as a mark
" List all marks
noremap mm :marks<ENTER> 
" Clear all marks in current buffer
noremap dmm :delmarks!

" netrw fixins from https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
"   autocmd VimEnter * :wincmd l
" augroup END

" MAD-X specifics
au BufNewFile,BufRead *.mdx setf madx
au BufNewFile,BufRead *.srv set nowrap

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

" Scheme fixins
set t_Co=256
let g:solarized_termcolors = &t_Co
set background=dark
colorscheme solarized
let g:airline_theme='solarized'

" vim-hardtime config
let g:hardtime_default_on = 1
let g:hardtime_timeout = 2000
let g:hardtime_maxcount = 2
let g:hardtime_showmsg = 1
