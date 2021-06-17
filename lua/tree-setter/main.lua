-- =================
-- Requirements
-- =================
local queries = require("vim.treesitter.query")
local ts_utils = require("nvim-treesitter.ts_utils")

-- all functions, which can modify the buffer, like adding the semicolons and
-- commas
local setter = require("tree-setter.setter")

-- =====================
-- Global variables
-- =====================
-- this variable is also known as `local M = {}` which includes the stuff of the
-- module
local TreeSetter = {}

-- includes the queries which match with the current filetype
local query

-- this variable stores the last line num where the cursor was.
-- It's mainly used as a control variable to check, if the cursor moved down or
-- not. Take a look into the "TreeSitter.main()` function to see its usage in
-- action.
local last_line_num = 0

-- ==============
-- Functions
-- ==============
function TreeSetter.add_character()
    -- get the relevant nodes to be able to judge the current case (if we need
    -- to add a semicolon/comma/... or not)
    local curr_node = ts_utils.get_node_at_cursor(0)
    if not curr_node then
        return
    end

    local parent_node = curr_node:parent()
    if not parent_node then
        parent_node = curr_node
    end

    -- Reduce the searching-range on the size of the parent node (and not the
    -- whole buffer)
    local start_row, _, end_row, _ = parent_node:range()
    -- since the end row is end-*exclusive*, we have to increase the end row by
    -- one
    end_row = end_row + 1

    -- iterate through all matched queries from the given range
    for _, match, _ in query:iter_matches(parent_node, 0, start_row, end_row) do
        for id, node in pairs(match) do

            -- get the "coordinations" of our current line, where we have to
            -- lookup if we should add a semicolon or not.
            local char_start_row, _, _, char_end_column = node:range()
            print(ts_utils.get_node_text(node, 0)[1])

            -- get the type of character which we should add.
            -- So for example if we have "@semicolon" in our query, than
            -- "character_type" will be "semicolon", so we know that there
            -- should be a semicolon at the end of the line
            local character_type = query.captures[id]

            -- so look first, if we reached an "exception" which have the
            -- "@skip" predicate. 
            if character_type == "skip" then
                return
            end

            -- Add the given character to the given line
            if character_type == 'semicolon' then
                setter.set_character(0, char_start_row, char_end_column, ';')
            elseif character_type == 'comma' then
                setter.set_character(0, char_start_row, char_end_column, ',')
            elseif character_type == 'double_points' then
                setter.set_character(0, char_start_row, char_end_column, ':')
            end
        end
    end
end

-- The main-entry point. Here we are checking the movement of the user and look
-- if we need to look if we should add a semicolon/comma/... or not.
function TreeSetter.main()
    local line_num = vim.api.nvim_win_get_cursor(0)[1]

    -- look if the user pressed the enter key by checking if the line number
    -- increased. If yes, look if we have to add the semicolon/comma/etc. or
    -- not.
    if last_line_num < line_num then
        TreeSetter.add_character()
    end

    -- refresh the old cursor position
    last_line_num = line_num
end

function TreeSetter.attach(bufnr, lang)
    query = queries.get_query(lang, "tsetter")

    vim.cmd([[
        augroup TreeSetter
        autocmd!
        autocmd CursorMovedI * lua require("tree-setter.main").main()
        augroup END
    ]])
end

function TreeSetter.detach(bufnr) end

return TreeSetter
