local queries = require("nvim-treesitter.query")

local M = {}

function M.init()
    require("nvim-treesitter").define_modules({
        tree_setter = {
            -- the file with the "main-code" of the module
            module_path = "tree-setter.main",

            -- Look if the module supports the current language by looking up,
            -- if there's an appropriate query file to it. For example if we're
            -- currently editing a C file, then this function looks if there's a
            -- "tree-setter/queries/c/tsetter.scm" file.
            is_supported = function(lang)
                return queries.get_query(lang, 'tsetter') ~= nil
            end
        }
    })
end

return M
