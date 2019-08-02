" Vim color file
" Maintainer:   matveyt
" Last Change:  2019 Jul 31
" URL:          https://github.com/matveyt/vim-modest

hi clear
if exists('g:syntax_on')
    syntax reset
endif

let g:colors_name = 'modest'

let s:palette = {}
let s:palette.Eigengrau = ['Black', 234, '#16161d']
let s:palette.Grey19 = ['NONE', 236, '#272733']
let s:palette.GreyGreen = ['DarkGrey', 242, '#5e716a']
let s:palette.AshGrey = ['LightGrey', 250, '#b2beb5']
let s:palette.Grey85 = ['NONE', 187, '#e6e6cf']
let s:palette.Beige = ['White', 230, '#f5f5dc']
let s:palette.EgyptianBlue = ['DarkBlue', 19, '#1034a6']
let s:palette.LightSeaGreen = ['DarkCyan', 37, '#20b2aa']
let s:palette.Mantis = ['DarkGreen', 77, '#74c365']
let s:palette.DarkChestnut = ['Brown', 95, '#986960']

function! s:hilite(group, fg, bg, ...)
    let l:fg = get(s:palette, a:fg, [a:fg, a:fg, a:fg])
    let l:bg = get(s:palette, a:bg, [a:bg, a:bg, a:bg])
    if !a:0
        let l:term = ''
    elseif stridx(a:1, '=') != -1
        let l:term = a:1
    else
        let l:term = 'term=' . a:1 . ' cterm=' . a:1 . ' gui=' . a:1
    endif
    let l:ctermfg = 'ctermfg=' . l:fg[&t_Co>=256]
    let l:ctermbg = 'ctermbg=' . l:bg[&t_Co>=256]
    let l:guifg = 'guifg=' . l:fg[2]
    let l:guibg = 'guibg=' . l:bg[2]
    execute 'hi' a:group l:term l:ctermfg l:ctermbg l:guifg l:guibg
endfunction

function! s:hilink(to_group, ...)
    for l:from_group in a:000
        execute 'hi! link' l:from_group a:to_group
    endfor
endfunction

if &bg ==# 'dark'
    call s:hilite('Normal', 'AshGrey', 'Eigengrau')
    call s:hilite('Statement', 'Mantis', 'NONE', 'NONE')
    call s:hilite('CursorLine', 'NONE', 'Grey19', 'NONE')
    call s:hilite('TabLine', 'NONE', 'GreyGreen', 'underline')
    call s:hilite('Underlined', 'fg', 'DarkChestnut', 'underline')
    call s:hilite('WildMenu', 'bg', 'Mantis', 'gui=bold')
else
    call s:hilite('Normal', 'EgyptianBlue', 'Beige')
    call s:hilite('Statement', 'DarkChestnut', 'NONE', 'NONE')
    call s:hilite('CursorLine', 'NONE', 'Grey85', 'NONE')
    call s:hilite('TabLine', 'NONE', 'LightSeaGreen', 'NONE')
    call s:hilite('Underlined', 'fg', 'LightSeaGreen', 'underline')
    call s:hilite('WildMenu', 'bg', 'LightSeaGreen')
endif

call s:hilite('Comment', 'GreyGreen', 'NONE')
call s:hilite('PreProc', 'LightSeaGreen', 'NONE')
call s:hilite('Error', 'fg', 'DarkChestnut')
call s:hilite('StatusLine', 'NONE', 'NONE', 'bold,reverse')
call s:hilite('StatusLineNC', 'NONE', 'NONE', 'reverse')
call s:hilite('TabLineSel', 'fg', 'bg', 'bold')
call s:hilite('Visual', 'bg', 'fg', 'NONE')

call s:hilink('Normal', 'CursorLineNr', 'Function', 'Identifier', 'ModeMsg')
call s:hilink('Comment', 'FoldColumn', 'Folded', 'LineNr', 'NonText', 'SignColumn',
    \ 'SpecialKey')
call s:hilink('PreProc', 'cDefine', 'cInclude', 'cPreCondit', 'cPreProc')
call s:hilink('Statement', 'Constant', 'Directory', 'helpHyperTextEntry',
    \ 'helpHyperTextJump', 'helpOption', 'MoreMsg', 'Question', 'Special',
    \ 'texStatement', 'Title', 'Type')
call s:hilink('CursorLine', 'ColorColumn', 'CursorColumn')
call s:hilink('Error', 'DiffDelete', 'ErrorMsg', 'MatchParen', 'PmenuThumb',
    \ 'WarningMsg')
call s:hilink('StatusLine', 'StatusLineTerm', 'ToolbarButton')
call s:hilink('StatusLineNC', 'Cursor', 'DiffChange', 'helpNote', 'lCursor', 'Search',
    \ 'StatusLineTermNC')
call s:hilink('TabLine', 'ToolbarLine')
call s:hilink('Underlined', 'SpellBad', 'SpellCap', 'SpellLocal', 'SpellRare',
    \ 'VisualNOS')
call s:hilink('Visual', 'Pmenu', 'PmenuSbar', 'TabLineFill', 'VertSplit')
call s:hilink('WildMenu', 'DiffAdd', 'DiffText', 'IncSearch', 'PmenuSel', 'Todo')
