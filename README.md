# WARNING
This module is still in a VEEERY young state and works only (partially, let's
rather say *barely* workking) for the
C programming language! So be prepared for a lot of bugs if you're trying it
out! If you want to know a little bit more, then you can read [this
issue-message](https://github.com/TornaxO7/tree-setter/issues/1#issuecomment-1025161228).

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

# Other information
## Why so less commits?
The problem is, that treesitter gives different results if the syntax is wrong
which makes it really hard to write the queries. So we have to wait until it
stabilizes that.
