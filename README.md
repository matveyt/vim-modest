### Vim modest colorscheme

A Vim color scheme made to look well in all terminals.

Supports 8/16/256/TrueColor on both dark and light backgrounds. No setup required
whatsoever.

### Installation

Use any plugin manager or simply copy _modest.vim_ to your _colors/_ subdirectory.

### Troubleshooting

On some rare occasions your Vim/Neovim may fail to detect *&t_Co* properly. For example,
Neovim reports 256 colors running on */dev/tty* with 16 colors only. You can try the
following to fix this:

    " disable TrueColor
    set notermguicolors
    " disable xterm 256 colors
    let g:colors_8bit = 0
    " reload color scheme
    colorscheme modest

### Screenshots

![dark](dark.png "Dark background")

![light](light.png "Light background")
