# WARNING
This module is still in a VEEERY young state and works only for the C
programming language!

# TreeSetter
TreeSetter is a
[nvim-treesitter-module](https://github.com/nvim-treesitter/module-template)
which **adds semicolons (`;`), commas (`,`) and double points (`:`) automatically**
for you, if you hit enter at the end of a line!

# Demo
![demo](./Demo.mp4)

As you can see from in the key-screen-bar
[screenkey](https://gitlab.com/screenkey/screenkey) I almost never pressed the
`;` key. I just needed to write the line of code, what I wanted and pressed the
`<CR>` key. The semicolon was added automatically.

# Installation
With [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'TornaxO7/tree-setter'
```

Add this into your `treesitter`-settings:
```lua
require('nvim-treesitter.configs').setup {
    -- your other modules ...

    tree_setter = {
        enable = true
    },

    -- your other modules ...
}
```
