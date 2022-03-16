RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setKickReason)
	local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam

	if string.len(steam) == 0 then
		setKickReason('Não foi possível encontrar o SteamID, por favor reinicie o Launcher e a Steam caso ela já esteja aberta.')
		CancelEvent()
	end
end)

RegisterServerEvent('artBase:setupUser')
AddEventHandler('artBase:setupUser', function()
	local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam

	if string.len(steam) == 0 then
		setKickReason('Não foi possível encontrar o SteamID, por favor reinicie o Launcher e a Steam caso ela já esteja aberta.')
		CancelEvent()
	end
end)