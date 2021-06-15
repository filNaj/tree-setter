-- =================
-- Requirements
-- =================
-- =====================
-- Global variables
-- =====================
local Setter = {}

-- ==============
-- Functions
-- ==============
function Setter.set_character(bufnr, line_num, character)
    -- get the line which should be modified
    local curr_line = vim.api.nvim_buf_get_lines(bufnr, line_num, line_num + 1,
                                                 false)
    if curr_line ~= nil then
        -- add the character to the line
        vim.api.nvim_buf_set_lines(bufnr, line_num, line_num + 1, false,
                                   {curr_line[1] .. character})
    end
end

return Setter
