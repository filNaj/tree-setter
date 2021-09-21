# HINT
This project is put into archive because I found out that it's almost impossible
to achieve an auto-setting "module" by using treesitter, since it parses
uncompleted code pretty "weird". Anyway, this should mainly work for C files,
but not for other languages... so you *could* still use it but it might do some
stuff wrong...

# WARNING
This module is still in a VEEERY young state and works only for the C
programming language!

# TreeSetter
TreeSetter is a
[nvim-treesitter-module](https://github.com/nvim-treesitter/module-template)
which **adds semicolons (`;`), commas (`,`) and double points (`:`) automatically**
for you, if you hit enter at the end of a line!

# Demo
![demonstration](./Documentation_Images/demo.gif)

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

# Contributing
Take a look into the [CONTRIBUTING.md](./CONTRIBUTING.md) file for that ;)
