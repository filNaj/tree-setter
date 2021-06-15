# WARNING
This module is still in a VEEERY young state and works only for the C
programming language!

# Demo


# TreeSetter
TreeSetter is a
[nvim-treesitter-module](https://github.com/nvim-treesitter/module-template)
which **adds semicolons (`;`), commas (`,`) and double points (`:`) automatically**
for you, if you hit enter at the end of a line!

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
