function Dump(o)
    if type(o) == 'table' then
        local s = ''
        for k, v in pairs(o) do
            if type(k) == 'boolean' then
                k = tostring(k)
            elseif type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. Dump(v) .. ','
        end
        return '{ ' .. string.sub(s, 1, -3) .. ' } '
    else
        return tostring(o)
    end
end
