-- =====================
-- Global variables
-- =====================
local Setter = {}

-- ==============
-- Functions
-- ==============
--
-- What does it do?
--	This function adds the given character to the end of the line.
--  
-- Parameters:
--	@bufnr: The buffer number where to change it (0 for current)
--	@line_num: The line number where the character should be added to
--	@character: The character which should be added to the line (if it's not
--	there yet)
--
function Setter.set_character(bufnr, line_num, end_column, character)
    -- since we're changing the previous line (after hitting enter) vim
    -- will move the indentation of the current line as well. This
    -- variable stores the indent of the previous line which will be
    -- added after adding the given line with the semicolon/comma/double
    -- point.
    -- We are doing `line_num + 1` because remember: Lua indexes start with 1!
    -- So if `line_num` is 1, we are referring to the first line!
    local indent_fix = (' '):rep(vim.fn.indent(line_num + 1))

    -- We have an exception if the character is ':', because suppose you write
    -- something like this ("|" represents the cursor):
    --  
    --      case 5:|
    --
    -- If you hit enter now, than your cursor should land like this:
    --
    --      case 5:
    --          |
    --
    -- and not this:
    --
    --      case 5:
    --      |
    -- 
    -- so we have to add the indent given by the `shiftwidth` option
    -- as well!
    if character == ':' then
        indent_fix = indent_fix .. (' '):rep(vim.o.shiftwidth)
    end

    -- get the last character to know if there's already the needed
    -- character or not
    local line = vim.api.nvim_buf_get_lines(0, line_num, line_num + 1, false)[1]
    -- in this part, we're looking at the certain index where the
    -- semicolon/comma/... should be, for example if there's already one.
    -- We have two cases which for the following two example cases
    --
    --  1. example case:
    --
    --      for (int a = 0; a < 10; a++)
    --
    --  2. example case:
    --      
    --      int a
    --
    local wanted_character
    if end_column + 1 < line:len() then
        -- This is for case 1.
        -- First sub:
        --      Go to the part of the query
        -- Second sub:
        --      Pick up the last character of the query
        wanted_character = line:sub(end_column, end_column + 1):sub(-1)
    else
        -- In this case the query is the has the last part of the line as well
        -- so we can just pick up the last character of the whole line (see
        -- example case 2)
        wanted_character = line:sub(-1)
    end

    -- is our character already placed? If not => Place it!
    --
    -- The second condition is used, to check cases like this:
    --
    --      for (int var = 0; var < 10; var++)
    --
    --  Without the second condition, we'd let `var++` enter this condition,
    --  which would add a semicolon after the `)`.
    if (wanted_character ~= character) and (wanted_character ~= ')') then
        -- we need the "+ 2" here, because:
        --  1. The column-index is *exclusive* => + 1
        --  2. We need to set even the next line with our new indentation => + 1
        vim.api.nvim_buf_set_lines(0, line_num, line_num + 2, true,
                                   {line .. character, indent_fix})
    end
end

return Setter
