" Vim color file
" Maintainer:   matveyt
" Last Change:  2020 Jun 10
" URL:          https://github.com/matveyt/vim-modest

let s:save_cpo = &cpo
set cpo&vim

hi clear
if exists('g:syntax_on')
    syntax reset
endif

let g:colors_name = 'modest'

let s:palette = {}
let s:palette.Eigengrau     = ['#16161d', 234, 'Black']
let s:palette.Grey19        = ['#272733', 236, 'NONE']
let s:palette.GreyGreen     = ['#5e716a', 242, 'DarkGrey']
let s:palette.AshGrey       = ['#b2beb5', 250, 'LightGrey']
let s:palette.Grey85        = ['#e6e6cf', 187, 'NONE']
let s:palette.Beige         = ['#f5f5dc', 230, 'White']
let s:palette.EgyptianBlue  = ['#1034a6',  19, 'DarkBlue']
let s:palette.LightSeaGreen = ['#20b2aa',  37, 'DarkCyan']
let s:palette.Mantis        = ['#74c365',  77, 'DarkGreen']
let s:palette.DarkChestnut  = ['#986960',  95, 'Brown']

function s:hilite(group, fg, bg, ...) abort
    if !a:0
        let l:term = ''
    elseif stridx(a:1, '=') >= 0
        let l:term = a:1
    else
        let l:term = printf('term=%s cterm=%s gui=%s', a:1, a:1, a:1)
    endif
    let l:fg = get(s:palette, a:fg, [a:fg, a:fg, a:fg])
    let l:bg = get(s:palette, a:bg, [a:bg, a:bg, a:bg])
    let l:guifg = 'guifg='..l:fg[0]
    let l:guibg = 'guibg='..l:bg[0]
    let l:ctermfg = 'ctermfg='..l:fg[1 + (&t_Co<256)]
    let l:ctermbg = 'ctermbg='..l:bg[1 + (&t_Co<256)]
    execute 'hi' a:group l:term l:ctermfg l:ctermbg l:guifg l:guibg
endfunction

function s:hilink(to_group, ...) abort
    for l:from_group in a:000
        execute 'hi! link' l:from_group a:to_group
    endfor
endfunction

function s:setansicolors(...) abort
    if !has('nvim')
        let g:terminal_ansi_colors = []
    endif
    for l:idx in range(a:0)
        let l:name = a:000[l:idx]
        let l:color = has_key(s:palette, l:name) ? s:palette[l:name][0] : l:name
        if !has('nvim')
            call add(g:terminal_ansi_colors, l:color)
        else
            let g:terminal_color_{l:idx} = l:color
        endif
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
call s:hilite('ErrorMsg', 'bg', 'DarkChestnut')
call s:hilite('StatusLine', 'NONE', 'NONE', 'bold,reverse')
call s:hilite('StatusLineNC', 'NONE', 'NONE', 'reverse')
call s:hilite('TabLineSel', 'fg', 'bg', 'bold')
call s:hilite('Visual', 'bg', 'fg', 'NONE')

call s:hilink('Normal', 'CursorLineNr', 'Function', 'Identifier', 'ModeMsg')
call s:hilink('Comment', 'Conceal', 'EndOfBuffer', 'FoldColumn', 'Folded', 'Ignore',
    \ 'LineNr', 'NonText', 'SignColumn', 'SpecialKey')
call s:hilink('PreProc', 'cDefine', 'cInclude', 'cPreCondit', 'cPreProc')
call s:hilink('Statement', 'Constant', 'Directory', 'helpHyperTextEntry',
    \ 'helpHyperTextJump', 'helpOption', 'MoreMsg', 'Question', 'Special',
    \ 'texStatement', 'Title', 'Type')
call s:hilink('CursorLine', 'ColorColumn', 'CursorColumn', 'VertSplit')
call s:hilink('Error', 'MatchParen', 'PmenuThumb')
call s:hilink('ErrorMsg', 'DiffDelete', 'WarningMsg')
call s:hilink('StatusLine', 'StatusLineTerm', 'ToolbarButton')
call s:hilink('StatusLineNC', 'Cursor', 'DiffChange', 'helpNote', 'lCursor', 'Search',
    \ 'StatusLineTermNC')
call s:hilink('TabLine', 'ToolbarLine')
call s:hilink('Underlined', 'SpellBad', 'SpellCap', 'SpellLocal', 'SpellRare',
    \ 'VisualNOS')
call s:hilink('Visual', 'Pmenu', 'PmenuSbar', 'TabLineFill')
call s:hilink('WildMenu', 'DiffAdd', 'DiffText', 'IncSearch', 'PmenuSel',
    \ 'QuickFixLine', 'Todo')

call s:setansicolors('Eigengrau', 'Firebrick', 'Mantis', 'DarkChestnut', 'EgyptianBlue',
    \ 'DarkOrchid', 'LightSeaGreen', 'AshGrey', 'GreyGreen', 'Red2', 'LawnGreen',
    \ 'Goldenrod', 'CornflowerBlue', 'Orchid', 'Aqua', 'Beige')

unlet s:palette
delfunction s:hilite
delfunction s:hilink
delfunction s:setansicolors

let &cpo = s:save_cpo
unlet s:save_cpo
