RegisterServerEvent('ArtGarage:ListMyCarsIn')
AddEventHandler('ArtGarage:ListMyCarsIn', function()
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam
    MySQL.Async.fetchAll('SELECT id FROM players WHERE steam_id = @steam LIMIT 1',
    {['@steam'] = steam}, function (result)
    	if result[1].id then
	        MySQL.Async.fetchAll('SELECT label, plate, model FROM players_vehicle WHERE player_id = @id AND at_garage = 1',
			{['@id'] = result[1].id}, function (result)
				TriggerClientEvent('ArtGarage:MyVehicles', -1, result)
			end)
		end
    end)
end)

RegisterServerEvent('ArtGarage:ListMyCarsOut')
AddEventHandler('ArtGarage:ListMyCarsOut', function()
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam
    MySQL.Async.fetchAll('SELECT id FROM players WHERE steam_id = @steam LIMIT 1',
    {['@steam'] = steam}, function (result)
        if result[1].id then
            MySQL.Async.fetchAll('SELECT label, plate, model FROM players_vehicle WHERE player_id = @id AND at_garage = 0',
            {['@id'] = result[1].id}, function (result)
                TriggerClientEvent('ArtGarage:MyVehicles', -1, result, true)
            end)
        end
    end)
end)

RegisterServerEvent('ArtGarage:FeeCar')
AddEventHandler('ArtGarage:FeeCar', function(car)
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam
    MySQL.Async.fetchAll('SELECT id FROM players WHERE steam_id = @steam LIMIT 1',
    {['@steam'] = steam}, function (result)
        if result[1].id then
            MySQL.Async.fetchAll('SELECT at_garage FROM players_vehicle WHERE player_id = @id AND plate = @plate',
            {['@id'] = result[1].id, ['@plate'] = car.plate}, function (result)
                if result[1].at_garage == false then
                    TriggerClientEvent('ArtGarage:FeePlayer', -1, car)
                else
                    TriggerClientEvent('ArtGarage:SpawnMyCar', -1, car)
                end
            end)
        end
    end)
end)

RegisterServerEvent('ArtGarage:UpdateCarStored')
AddEventHandler('ArtGarage:UpdateCarStored', function(value)
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam
    MySQL.Async.fetchAll('SELECT id FROM players WHERE steam_id = @steam LIMIT 1',
    {['@steam'] = steam}, function (result)
        if result[1].id then
            MySQL.Async.fetchAll('UPDATE players_vehicle SET at_garage = @value WHERE player_id = @id',
            {['@value'] = value, ['@id'] = result[1].id})
        end
    end)
end)

RegisterServerEvent('ArtGarage:StoreMyCar')
AddEventHandler('ArtGarage:StoreMyCar', function(plate)
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam
    MySQL.Async.fetchAll('SELECT id FROM players WHERE steam_id = @steam LIMIT 1',
    {['@steam'] = steam}, function (result)
        if result[1].id then
            MySQL.Async.fetchAll('SELECT plate FROM players_vehicle WHERE player_id = @id AND plate = @plate',
            {['@id'] = result[1].id, ['@plate'] = plate}, function (result)
                if result[1].plate then
                    TriggerClientEvent('ArtGarage:DespawnMyCar', -1)
                end
            end)
        end
    end)
end)