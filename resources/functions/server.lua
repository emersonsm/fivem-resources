function ExtractIdentifiers(s)
    local identifiers = {
        steam = "",
    }

    for i = 0, GetNumPlayerIdentifiers(s) - 1 do
        local id = GetPlayerIdentifier(s, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        end
    end

    return identifiers
end