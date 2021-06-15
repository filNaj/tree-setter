local Helpers = {}

function Helpers.starts_with(string, start_string)
    -- trim the string first
    string = string:gsub("%s", "")
    return string:sub(1, #start_string) == start_string
end

return Helpers
