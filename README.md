### Vim modest colorscheme

A color scheme with both dark and light background.

Painless support for 8/16/256/TrueColor.

### Installation

By [minpac](https://github.com/k-takata/minpac):

```vim
call minpac#init()
call minpac#add('matveyt/vim-modest', {'type': 'opt'})
```

Note: prefer installing colorschemes under `opt` to keep `&runtimepath` as short as
possible.

Alternatively, use any other plugin manager or just copy _modest.vim_ to your _colors/_
subdirectory.

### Troubleshooting

If you wish you can also force only 16 colors in a terminal like this:

    " disable TrueColor
    set notermguicolors
    " disable xterm-256 colors
    let g:colors_8bit = 0
    " reload color scheme
    colorscheme modest

### Screenshots

![dark](dark.png "Dark background")

![light](light.png "Light background")
