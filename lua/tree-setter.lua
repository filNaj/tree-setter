local queries = require("nvim-treesitter.query")

local M = {}

function M.init()
    require("nvim-treesitter").define_modules({
        tree_setter = {
            module_path = "tree-setter.main",
            is_supported = function(lang)
                return queries.get_query(lang, 'tsetter') ~= nil
            end
        }
    })
end

return M
