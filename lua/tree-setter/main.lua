-- =================
-- Requirements
-- =================
local queries = require("vim.treesitter.query")
-- all functions, which can modify the buffer, like adding the semicolons and
-- commas
local ts_utils = require("nvim-treesitter.ts_utils")
local helpers = require("tree-setter.helpers")

-- =====================
-- Global variables
-- =====================
local M = {}
-- includes the current query
local query
-- this variable stores the last line num where the cursor was.
-- It's mainly used as a control variable since we are mainly adding the
-- semicolons, commas and double points when the user presses the enter key,
-- which will change the line number of the cursor
local last_line_num = 0

-- ==============
-- Functions
-- ==============
function M.should_skip(line)
    if helpers.starts_with(line, "if") or helpers.starts_with(line, "else if")
        or helpers.starts_with(line, "else")
        or helpers.starts_with(line, "while") or helpers.starts_with(line, "for") then
        return true
    end

    return false
end

function M.add_character()
    -- get the current node from the cursor
    local curr_node = ts_utils.get_node_at_cursor(0)
    if not curr_node then
        return
    end

    local parent_node = curr_node:parent()
    if not parent_node then
        return
    end

    -- Reduce the searching-place on the size of the parent node
    local start_row, _, end_row, _ = parent_node:range()
    -- since the end row is end-*exclusive*, we have to increase the end row by
    -- one
    end_row = end_row + 1

    local skip = false

    -- now look if some queries fit with the current filetype
    for pattern, match, _ in query:iter_matches(parent_node, 0, start_row,
                                                end_row + 1) do
        for id, node in pairs(match) do

            local char_start_row, _, char_end_row, _ = node:range()
            char_end_row = char_end_row + 1

            -- get the type of character which we should add
            -- So for example if we have "@semicolon" in our query, than
            -- "character_type" will be "semicolon", so we know that there
            -- should be a semicolon at the end of the line
            local character_type = query.captures[id]

            -- get the last character to know if there's already the needed
            -- character or not
            local line = vim.api.nvim_buf_get_lines(0, char_start_row,
                                                    char_end_row, false)[1]
            local wanted_character = line:sub(-1)

            if not M.should_skip(line) then
                -- since we're changing the previous line (after hitting enter) vim
                -- will move the indentation of the current line as well. This
                -- variable stores the indent of the previous line which will be
                -- added after adding the given line with the semicolon/comma/double
                -- point.
                local indent_fix = (' '):rep(vim.fn.indent(char_start_row + 1))

                if (character_type == "semicolon") and (wanted_character ~= ';') then
                    vim.api.nvim_buf_set_lines(0, char_start_row, char_end_row,
                                               true, {line .. ';', indent_fix})

                elseif (character_type == "comma") and (wanted_character ~= ',') then
                    vim.api.nvim_buf_set_lines(0, char_start_row, char_end_row,
                                               false, {line .. ',', indent_fix})

                elseif (character_type == "double_points")
                    and (wanted_character ~= ':') then
                    vim.api.nvim_buf_set_lines(0, char_start_row, char_end_row,
                                               false, {line .. ':', indent_fix})
                end
            end
        end
    end
end

function M.main()
    local line_num = vim.api.nvim_win_get_cursor(0)[1]

    -- look if the cursor has changed his line position, if yes, than this
    -- means (normally) that the user pressed the <CR> key => Look which
    -- character we have to add
    if last_line_num ~= line_num then
        M.add_character()
    end

    -- refresh the old cursor position
    last_line_num = line_num
end

function M.attach(bufnr, lang)
    query = queries.get_query(lang, 'tsetter')

    -- if there's no query for the current filetype -> Don't do anything
    if not query then
        return
    end

    vim.cmd([[
        augroup TreeSetter
        autocmd!
        autocmd TextChangedI * lua require("tree-setter.main").main()
        augroup END
    ]])
end

function M.detach(bufnr) end

return M
