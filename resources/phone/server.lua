RegisterServerEvent('ArtPhone:GetPosts')
AddEventHandler('ArtPhone:GetPosts', function()
    MySQL.Async.fetchAll('SELECT yp.id, yp.message, p.character_name, pp.phone FROM yellow_pages AS yp INNER JOIN players AS p' ..
    ' ON yp.player_id = p.id INNER JOIN players_phone AS pp ON pp.player_id = p.id ORDER BY yp.id DESC', {}, function (result)
    	if result then
            TriggerClientEvent('ArtPhone:RetrievePosts', -1, result)
		end
    end)
end)

RegisterServerEvent('ArtPhone:SaveMyPost')
AddEventHandler('ArtPhone:SaveMyPost', function(message)
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam

    MySQL.Async.fetchAll('INSERT INTO yellow_pages (message, player_id)' ..
    ' SELECT "' .. message .. '", id FROM players WHERE players.steam_id = @steam LIMIT 1', {['@steam'] = steam}, function ()
        TriggerClientEvent('ArtPhone:GetUpdatedPosts', -1)
    end)
end)

RegisterServerEvent('ArtPhone:Balance')
AddEventHandler('ArtPhone:Balance', function()
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam
    MySQL.Async.fetchAll('SELECT p.character_name, ba.money FROM players AS p INNER JOIN bank_account AS ba' ..
    ' ON ba.player_id = p.id WHERE p.steam_id = @steam ORDER BY ba.id DESC LIMIT 1',
    {['@steam'] = steam}, function (result)
        if result[1].money then
            TriggerClientEvent('ArtPhone:CurrentBalance', -1, result[1])
        end
    end)
end)