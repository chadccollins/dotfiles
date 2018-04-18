" Color schemes/themes 
set termguicolors " Use 24-bit, modern terminal, escape codes for commands
set background=dark " Seattle? Dark. Not too dark. Just dark.

if globpath(&runtimepath, 'colors/lucius.vim', 1) != ''
    colorscheme lucius " Flavor of the week

    if !empty($CONEMUBUILD)
        " ConEmu should use LuciusBlack to get around terminal color issues
        LuciusBlack
    endif
endif

" General Settings
set clipboard+=unnamedplus " Use system clipboard, instead of '*', '+' registers
set ignorecase " Searches ignore case. w/smartcase, only all lower-case searches
set smartcase " w/ignorecase opt, case sensitive on mixed case searches
set showmatch " Highlight matching brackets as you cursor over them
set number " Turn on line numbers
set wrap! " Line wrapping off
