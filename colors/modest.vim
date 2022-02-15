" Vim color file
" Maintainer:   matveyt
" Last Change:  2022 Feb 15
" License:      VIM License
" URL:          https://github.com/matveyt/vim-modest

let s:save_cpo = &cpo
set cpo&vim

hi clear
let g:colors_name = 'modest'

let s:palette = {}
let s:palette.Eigengrau     = ['#16161d', 234, 'Black']
let s:palette.Grey19        = ['#272733', 236, 'NONE']
let s:palette.GreyGreen     = ['#5e716a', 242, has('nvim') ? 8 : 'DarkGrey']
let s:palette.AshGrey       = ['#b2beb5', 250, 'LightGrey']
let s:palette.Grey85        = ['#e6e6cf', 187, 'NONE']
let s:palette.Beige         = ['#f5f5dc', 230, 'White']
let s:palette.EgyptianBlue  = ['#1034a6',  19, 'DarkBlue']
let s:palette.LightSeaGreen = ['#20b2aa',  37, 'DarkCyan']
let s:palette.Mantis        = ['#74c365',  77, 'DarkGreen']
let s:palette.DarkChestnut  = ['#986960',  95, 'DarkYellow']

function s:hilite(group, fg, bg, ...) abort
    let l:term = !a:0 ? '' : stridx(a:1, '=') >= 0 ? a:1 :
        \ printf('term=%s cterm=%s gui=%s', a:1, a:1, a:1)
    let l:fg = get(s:palette, a:fg, [a:fg, a:fg, a:fg])
    let l:bg = get(s:palette, a:bg, [a:bg, a:bg, a:bg])
    let l:ix = get(g:, 'colors_8bit', &t_Co >= 256) ? 1 : 2
    execute printf('hi %s %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s',
        \ a:group, l:term, l:fg[l:ix], l:bg[l:ix], l:fg[0], l:bg[0])
endfunction

function s:hilink(to_group, ...) abort
    for l:from_group in a:000
        execute 'hi clear' l:from_group
        execute 'hi! link' l:from_group a:to_group
    endfor
endfunction

function s:setansicolors(...) abort
    if !has('nvim')
        let g:terminal_ansi_colors = []
    endif
    for l:ix in range(a:0)
        let l:name = a:000[l:ix]
        let l:color = has_key(s:palette, l:name) ? s:palette[l:name][0] : l:name
        if !has('nvim')
            call add(g:terminal_ansi_colors, l:color)
        else
            let g:terminal_color_{l:ix} = l:color
        endif
    endfor
endfunction

if &background is# 'dark'
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

call s:hilink('NONE', 'CursorLineNr', 'Function', 'Identifier', 'ModeMsg', 'vimUserFunc')
call s:hilink('Normal', 'Terminal')
call s:hilink('Comment', 'Conceal', 'EndOfBuffer', 'FoldColumn', 'Folded', 'Ignore',
    \ 'LineNr', 'NonText', 'SignColumn', 'SpecialKey')
call s:hilink('Statement', 'Constant', 'Directory', 'helpHyperTextJump', 'MoreMsg',
    \ 'Question', 'Special', 'Title', 'Type')
call s:hilink('CursorLine', 'ColorColumn', 'CursorColumn', 'VertSplit')
call s:hilink('Error', 'MatchParen', 'PmenuThumb')
call s:hilink('ErrorMsg', 'DiffDelete', 'WarningMsg')
call s:hilink('StatusLine', 'StatusLineTerm', 'ToolbarButton')
call s:hilink('StatusLineNC', 'Cursor', 'DiffChange', 'lCursor', 'StatusLineTermNC',
    \ 'Todo')
call s:hilink('TabLine', 'ToolbarLine')
call s:hilink('Underlined', 'QuickFixLine', 'Search', 'SpellBad', 'SpellCap',
    \ 'SpellLocal', 'SpellRare', 'VisualNOS')
call s:hilink('Visual', 'Pmenu', 'PmenuSbar', 'TabLineFill')
call s:hilink('WildMenu', 'DiffAdd', 'DiffText', 'IncSearch', 'PmenuSel')

call s:setansicolors('Eigengrau', 'Firebrick', 'Mantis', 'DarkChestnut', 'EgyptianBlue',
    \ 'DarkOrchid', 'LightSeaGreen', 'AshGrey', 'GreyGreen', 'Red2', 'LawnGreen',
    \ 'Goldenrod', 'CornflowerBlue', 'Orchid', 'Aqua', 'Beige')

unlet s:palette
delfunction s:hilite
delfunction s:hilink
delfunction s:setansicolors

let &cpo = s:save_cpo
unlet s:save_cpo
