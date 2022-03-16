RegisterServerEvent('ArtCharacter:GetMyCharacters')
AddEventHandler('ArtCharacter:GetMyCharacters', function()
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local player = {
        steam_id=identifiers.steam, steam_name=GetPlayerName(source)
    }
    MySQL.ready(function ()
        MySQL.Async.fetchAll('SELECT p.id, p.character_name, p.character_age, p.character_bio,' ..
        ' DATE_FORMAT(p.created_at, "%d/%m/%Y") AS created_at' ..
        ' FROM players AS p INNER JOIN users AS u ON u.id = p.user_id WHERE u.steam_id = @steam_id' ..
        ' AND u.steam_name = @steam_name AND p.disabled_at IS NULL',
        {['@steam_id'] = player.steam_id, ['@steam_name'] = player.steam_name}, function (result)
            if #result > 0 then
                TriggerClientEvent('ArtCharacter:SelectCharacter', -1, result)
            else
                TriggerClientEvent('ArtCharacter:SelectCharacter', -1, false)
            end
        end)
    end)
end)

RegisterServerEvent('ArtCharacter:SaveUser')
AddEventHandler('ArtCharacter:SaveUser', function()
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local player = {
        steam_id=identifiers.steam, steam_name=GetPlayerName(source)
    }
    MySQL.ready(function ()
        MySQL.Async.fetchAll('SELECT EXISTS(SELECT id FROM users WHERE steam_id = @steam_id AND steam_name = @steam_name LIMIT 1) AS row_exists',
        {['@steam_id'] = player.steam_id, ['@steam_name'] = player.steam_name}, function (result)
            if result[1].row_exists == 0 then
                MySQL.Async.execute('INSERT INTO users (steam_id, steam_name) VALUES (@steam_id, @steam_name)',
                {['@steam_id'] = player.steam_id, ['@steam_name'] = player.steam_name})
            end
        end)
    end)
end)

RegisterServerEvent('ArtCharacter:SaveCharacter')
AddEventHandler('ArtCharacter:SaveCharacter', function(char)
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local player = {
        steam_id=identifiers.steam, steam_name=GetPlayerName(source)
    }
    MySQL.ready(function ()
        MySQL.Async.fetchAll('SELECT id FROM users WHERE steam_id = @steam_id AND steam_name = @steam_name LIMIT 1',
        {['@steam_id'] = player.steam_id, ['@steam_name'] = player.steam_name}, function (result)
            MySQL.Async.fetchAll('INSERT INTO players (user_id, character_name, character_age, character_bio)' ..
            ' VALUES (@id, @character_name, @character_age, @character_bio); SELECT LAST_INSERT_ID() AS last_id;',
            {['@id'] = result[1].id, ['@character_name'] = char.name, ['@character_age'] = char.age, ['@character_bio'] = char.bio}, function (result)
                if #result[2] > 0 then
                    MySQL.Async.execute('INSERT INTO bank_account (player_id, money) VALUES (@id, 0)',
                    {['@id'] = result[2][1].last_id})

                    MySQL.Async.execute('INSERT INTO players_phone (player_id, phone) VALUES (@id, LPAD(FLOOR(RAND() * 999999.99), 5, "0"))',
                    {['@id'] = result[2][1].last_id})

                    MySQL.Async.execute('INSERT INTO players_inventory (player_id, items) VALUES (@id, NULL)',
                    {['@id'] = result[2][1].last_id})

                    TriggerClientEvent('ArtCharacter:GetUpdatedCharacters', -1)
                end
            end)
        end)
    end)
end)

RegisterServerEvent('ArtCharacter:DeleteCharacter')
AddEventHandler('ArtCharacter:DeleteCharacter', function(character)
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local player = {
        steam_id=identifiers.steam, steam_name=GetPlayerName(source)
    }
    MySQL.ready(function ()
        MySQL.Async.fetchAll('SELECT u.id FROM users AS u INNER JOIN players AS p ON p.user_id = u.id' ..
        ' WHERE u.steam_id = @steam_id AND u.steam_name = @steam_name AND p.id = @player_id LIMIT 1',
        {['@steam_id'] = player.steam_id, ['@steam_name'] = player.steam_name, ['@player_id'] = character.id}, function (result)
            if #result > 0 then
                MySQL.Async.execute('UPDATE players SET disabled_at = NOW() WHERE id = @player_id', {['@player_id'] = character.id}, function()
                    TriggerClientEvent('ArtCharacter:GetUpdatedCharacters', -1)
                end)
            end
        end)
    end)
end)