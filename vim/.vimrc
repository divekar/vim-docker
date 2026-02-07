" ============================================================
" Basic Vim Settings
" ============================================================
set nocompatible              " Use Vim settings rather than Vi
syntax on                     " Enable syntax highlighting
filetype plugin indent on     " Enable filetype detection and plugins

" Set leader key to space (must be set before any leader mappings)
let mapleader = " "
let g:mapleader = " "

" ============================================================
" Indentation - 4 Spaces, No Tabs
" ============================================================
set tabstop=4                 " Display width of tab characters
set softtabstop=4             " Number of spaces in tab when editing
set shiftwidth=4              " Number of spaces for indentation
set expandtab                 " Convert tabs to spaces
set smartindent               " Smart autoindenting
set autoindent                " Copy indent from current line

" ============================================================
" Smart Vim Features
" ============================================================
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set cursorline                " Highlight current line
set showcmd                   " Show command in bottom bar
set wildmenu                  " Visual autocomplete for command menu
set showmatch                 " Highlight matching brackets
set incsearch                 " Search as characters are entered
set hlsearch                  " Highlight search matches
set ignorecase                " Case insensitive searching
set smartcase                 " Case sensitive if uppercase present
set mouse=a                   " Enable mouse support
set clipboard=unnamedplus     " Use system clipboard
set encoding=utf-8            " UTF-8 encoding
set backspace=indent,eol,start " Backspace behavior
set hidden                    " Allow hidden buffers
set updatetime=300            " Faster completion
set signcolumn=yes            " Always show sign column

" ============================================================
" Plugins (via vim-plug)
" ============================================================
call plug#begin('~/.vim/plugged')

" C++ Language Server & Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Color Schemes / Themes
Plug 'catppuccin/vim', {'as': 'catppuccin'}
Plug 'ghifarit53/tokyonight-vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'dracula/vim', {'as': 'dracula'}

" AI Assistance
Plug 'github/copilot.vim'                " GitHub Copilot

" File Navigation
Plug 'preservim/nerdtree'                " File tree explorer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                  " Fuzzy finder

" Code Navigation & Tags
Plug 'preservim/tagbar'                  " Tag viewer

" C++ Specific
Plug 'derekwyatt/vim-fswitch'            " Switch between .h and .cpp
Plug 'octol/vim-cpp-enhanced-highlight'  " Better C++ syntax highlighting

" Code Commenting
Plug 'tpope/vim-commentary'              " Easy commenting with gcc

" Git Integration
Plug 'tpope/vim-fugitive'                " Git commands in Vim
Plug 'airblade/vim-gitgutter'            " Show git diff in gutter

" Status Line
Plug 'vim-airline/vim-airline'           " Enhanced status bar
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" ============================================================
" Theme Configuration
" ============================================================
" Set Catppuccin as default theme
set termguicolors
colorscheme catppuccin_mocha

" Alternative themes (uncomment to use):
" colorscheme tokyonight
" colorscheme nightfox
" colorscheme onedark
" colorscheme dracula

" ============================================================
" GitHub Copilot Configuration
" ============================================================
" Enable Copilot
let g:copilot_enabled = 1

" Copilot keybindings
imap <silent><script><expr> <C-Space> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Alternative keybindings (use Alt/Option key to avoid conflicts)
imap <M-j> <Plug>(copilot-accept-word)
imap <M-]> <Plug>(copilot-next)
imap <M-[> <Plug>(copilot-previous)

" Disable Copilot for certain filetypes if needed
" let g:copilot_filetypes = {'markdown': v:false}

" ============================================================
" vim-airline Configuration
" ============================================================
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline_powerline_fonts = 0

" ============================================================
" GitGutter Configuration
" ============================================================
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0  " Disable default mappings, use custom ones
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
set updatetime=100  " Update git signs faster

" ============================================================
" coc.nvim Configuration for C++
" ============================================================
" Use <TAB> for completion navigation
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <CR> to confirm completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Snippet navigation - jump between parameters (insert mode only)
" Use Ctrl-j to jump forward and Ctrl-k to jump backward through snippet placeholders
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Navigate between diagnostics (errors/warnings)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Show documentation with K
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>fm  <Plug>(coc-format-selected)
nmap <leader>fm  <Plug>(coc-format-selected)

" Show document symbols (functions, classes, etc.) in current file
nnoremap <silent> <leader>o :CocList outline<CR>

" Show all symbols in workspace
nnoremap <silent> <leader>S :CocList -I symbols<CR>
\" Show references in CoC list
nnoremap <silent> <leader>r :CocList references<CR>
" ============================================================
" NERDTree Configuration
" ============================================================
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" ============================================================
" FSwitch Configuration (Switch between .h and .cpp)
" ============================================================
nnoremap <leader>s :FSHere<CR>
nnoremap <leader>sh :FSSplitRight<CR>

" ============================================================
" Git Integration (vim-fugitive)
" ============================================================
" Show git status
nnoremap <leader>gs :Git<CR>

" Show diff of current file
nnoremap <leader>gd :Gvdiffsplit<CR>

" Show git blame
nnoremap <leader>gb :Git blame<CR>

" Alternative blame command (opens in vertical split)
nnoremap <leader>gB :Gblame<CR>

" Show commit history for current file
nnoremap <leader>gl :0Gclog<CR>

" Show all commits
nnoremap <leader>gL :Gclog<CR>

" Write and stage current file
nnoremap <leader>gw :Gwrite<CR>

" Read (checkout/discard changes) current file
nnoremap <leader>gR :Gread<CR>

" Jump to next/previous git hunk (changed section)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Preview git hunk
nnoremap <leader>gh :GitGutterPreviewHunk<CR>

" Stage/unstage git hunk
nnoremap <leader>ga :GitGutterStageHunk<CR>
nnoremap <leader>gu :GitGutterUndoHunk<CR>

" ============================================================
" Additional Key Mappings
" ============================================================

" Clear search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ============================================================
" FZF (Fuzzy Finder) Key Mappings - Like VS Code Search
" ============================================================
" Search files by name
nnoremap <leader>p :Files<CR>
nnoremap <C-p> :Files<CR>

" Search text in all files (requires ripgrep)
nnoremap <leader>f :Rg<CR>
nnoremap <C-f> :Rg<Space>

" Search in git files only
nnoremap <leader>gf :GFiles<CR>

" Search in open buffers
nnoremap <leader>b :Buffers<CR>

" Search in current buffer lines
nnoremap <leader>/ :BLines<CR>

" Search in all lines across all files
nnoremap <leader>l :Lines<CR>

" Search specific file types (C++ development)
nnoremap <leader>ph :call fzf#run(fzf#wrap({'source': 'find . -type f \( -name "*.h" -o -name "*.hpp" \)'}))<CR>
nnoremap <leader>pc :call fzf#run(fzf#wrap({'source': 'find . -type f \( -name "*.cpp" -o -name "*.cc" -o -name "*.cxx" \)'}))<CR>
nnoremap <leader>pm :call fzf#run(fzf#wrap({'source': 'find . -type f -name "*.mk"'}))<CR>
nnoremap <leader>pa :call fzf#run(fzf#wrap({'source': 'find . -type f \( -name "*.h" -o -name "*.hpp" -o -name "*.cpp" -o -name "*.cc" -o -name "*.cxx" \)'}))<CR>

" Custom fzf commands for file type filtering
command! FZFHeaders call fzf#run(fzf#wrap({'source': 'find . -type f \( -name "*.h" -o -name "*.hpp" \)'}))
command! FZFCpp call fzf#run(fzf#wrap({'source': 'find . -type f \( -name "*.cpp" -o -name "*.cc" -o -name "*.cxx" \)'}))
command! FZFMakefiles call fzf#run(fzf#wrap({'source': 'find . -type f -name "*.mk"'}))
command! FZFAllCpp call fzf#run(fzf#wrap({'source': 'find . -type f \( -name "*.h" -o -name "*.hpp" -o -name "*.cpp" -o -name "*.cc" -o -name "*.cxx" \)'}))

" Search text in specific file types (C++ development)
nnoremap <leader>fh :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '*.h' -g '*.hpp' -- ".shellescape(input('Search in headers: ')), 1, fzf#vim#with_preview())<CR>
nnoremap <leader>fc :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '*.cpp' -g '*.cc' -g '*.cxx' -- ".shellescape(input('Search in C++ files: ')), 1, fzf#vim#with_preview())<CR>
nnoremap <leader>fmk :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '*.mk' -- ".shellescape(input('Search in makefiles: ')), 1, fzf#vim#with_preview())<CR>
nnoremap <leader>fa :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '*.h' -g '*.hpp' -g '*.cpp' -g '*.cc' -g '*.cxx' -- ".shellescape(input('Search in C++ files: ')), 1, fzf#vim#with_preview())<CR>

" Custom ripgrep commands for searching in specific file types
command! -nargs=* RgHeaders call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '*.h' -g '*.hpp' -- ".shellescape(<q-args>), 1, fzf#vim#with_preview())
command! -nargs=* RgCpp call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '*.cpp' -g '*.cc' -g '*.cxx' -- ".shellescape(<q-args>), 1, fzf#vim#with_preview())
command! -nargs=* RgMakefiles call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '*.mk' -- ".shellescape(<q-args>), 1, fzf#vim#with_preview())
command! -nargs=* RgAllCpp call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '*.h' -g '*.hpp' -g '*.cpp' -g '*.cc' -g '*.cxx' -- ".shellescape(<q-args>), 1, fzf#vim#with_preview())

" ============================================================
" Build/Compilation and Error Navigation (Quickfix)
" ============================================================
" Set environment variables and build command
" Uses ./docker-build.sh with BUILD_SCLS and PLATFORM environment variables
let $BUILD_SCLS = 'gcc-toolset-11'
let $PLATFORM = 'AS8'

" Set makeprg to use docker-build.sh script
set makeprg=BUILD_SCLS=gcc-toolset-11\ PLATFORM=AS8\ ./docker-build.sh\ $*

" Run build with target prompt
nnoremap <leader>m :call BuildWithTarget()<CR>

" Build function that prompts for target
function! BuildWithTarget()
  let target = input('Build target: ', '', 'file')
  if target != ''
    execute 'make ' . target
    cwindow
  else
    echo 'Build cancelled - no target specified'
  endif
endfunction

" Quick build with default/last target
nnoremap <leader>mm :make<CR>:cwindow<CR>

" Quickfix window control
nnoremap <leader>co :copen<CR>       " Open quickfix window
nnoremap <leader>cc :cclose<CR>      " Close quickfix window
nnoremap <leader>cf :cfirst<CR>      " First error
nnoremap <leader>cl :clast<CR>       " Last error

" Note: Error navigation is defined below with smart warning-skipping

" Filter quickfix to show only errors (remove warnings)
function! FilterQuickfixErrors()
  let qflist = getqflist()
  let errors_only = filter(qflist, 'v:val.type == "E" || v:val.text !~? "warning"')
  call setqflist(errors_only)
  echo 'Filtered ' . (len(qflist) - len(errors_only)) . ' warnings. Showing ' . len(errors_only) . ' errors.'
endfunction

command! QFErrors call FilterQuickfixErrors()
nnoremap <leader>ce :call FilterQuickfixErrors()<CR>

" Toggle to show all quickfix entries (reload from original)
nnoremap <leader>ca :cgetfile<CR>:echo 'Showing all errors and warnings'<CR>

" Smart error-only navigation (skips warnings)
function! NextError()
  let qflist = getqflist()
  let qfidx = getqflist({'idx': 0}).idx
  let qfsize = len(qflist)
  
  if qfsize == 0
    echo 'No items in quickfix'
    return
  endif
  
  " Start from next position
  let start = qfidx
  let idx = qfidx
  
  " Loop through all items (with wrap around)
  for i in range(qfsize)
    let idx = idx % qfsize + 1
    let item = qflist[idx - 1]
    
    " Check if this is NOT a warning
    if item.text !~? '^\s*warning:'
      " Jump to this item
      execute 'cc ' . idx
      return
    endif
    
    " If we've wrapped around to where we started, no errors found
    if idx == start
      echo 'No errors found (only warnings)'
      return
    endif
  endfor
  
  echo 'No errors found (only warnings)'
endfunction

function! PreviousError()
  let qflist = getqflist()
  let qfidx = getqflist({'idx': 0}).idx
  let qfsize = len(qflist)
  
  if qfsize == 0
    echo 'No items in quickfix'
    return
  endif
  
  " Start from previous position
  let start = qfidx
  let idx = qfidx
  
  " Loop through all items backwards (with wrap around)
  for i in range(qfsize)
    let idx = idx - 2
    if idx < 0
      let idx = idx + qfsize
    endif
    let idx = idx + 1
    
    if idx < 1
      let idx = qfsize
    endif
    
    let item = qflist[idx - 1]
    
    " Check if this is NOT a warning
    if item.text !~? '^\s*warning:'
      " Jump to this item
      execute 'cc ' . idx
      return
    endif
    
    " If we've wrapped around to where we started, no errors found
    if idx == start
      echo 'No errors found (only warnings)'
      return
    endif
  endfor
  
  echo 'No errors found (only warnings)'
endfunction

" Override navigation to skip warnings by default
nnoremap <leader>cn :call NextError()<CR>
nnoremap <leader>cp :call PreviousError()<CR>
nnoremap ]q :call NextError()<CR>
nnoremap [q :call PreviousError()<CR>
nnoremap <F10> :call NextError()<CR>
nnoremap <F9> :call PreviousError()<CR>

" Navigate through ALL items (errors + warnings)
nnoremap <leader>cN :cnext<CR>
nnoremap <leader>cP :cprevious<CR>

" ============================================================
" Location List Navigation (for coc-references, etc.)
" ============================================================
" Navigate to next/previous reference in location list
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>

" Location list window control
nnoremap <leader>lo :lopen<CR>       " Open location list window
nnoremap <leader>lc :lclose<CR>      " Close location list window
nnoremap <leader>lf :lfirst<CR>      " First item
nnoremap <leader>ll :llast<CR>       " Last item

" ============================================================
" Tags Configuration
" ============================================================
" Generate tags for current directory
nnoremap <leader>gt :!ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .<CR>

" Command to generate tags for C++ projects
command! GenTags !ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .

" Set tags file location (searches up directory tree)
set tags=./tags;,tags;