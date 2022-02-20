local header = "[Tree-Setter]: "

local logger = {
    error = function(message)
        vim.notify(header .. message, vim.log.levels.ERROR)
    end,
    info = function(message)
        vim.notify(header .. message, vim.log.levels.INFO)
    end,
}

return logger
