RegisterServerEvent('ArtBank:Balance')
AddEventHandler('ArtBank:Balance', function()
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam
    MySQL.Async.fetchAll('SELECT ba.money FROM players AS p INNER JOIN bank_account AS ba' ..
    ' ON ba.player_id = p.id INNER JOIN users AS u ON p.user_id = u.id WHERE u.steam_id = @steam LIMIT 1',
    {['@steam'] = steam}, function (result)
    	if result[1].money then
            TriggerClientEvent('ArtBank:CurrentBalance', -1, result[1].money)
		end
    end)
end)

RegisterServerEvent('ArtBank:WithdrawMoney')
AddEventHandler('ArtBank:WithdrawMoney', function(amount)
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam
    MySQL.Async.fetchAll('SELECT p.id, ba.money FROM players AS p INNER JOIN bank_account AS ba' ..
    ' ON ba.player_id = p.id INNER JOIN users AS u ON p.user_id = u.id WHERE u.steam_id = @steam LIMIT 1',
    {['@steam'] = steam}, function (result)
        if result[1].money and amount ~= nil and amount >= 0 and result[1].money >= amount then
            local money = result[1].money
            local pid = result[1].id
            MySQL.Async.fetchAll('INSERT INTO bank_account (player_id, money) VALUES (@id, @money)',
            {['@id'] = pid, ['@money'] = (money - amount)}, function (result)
                TriggerClientEvent('ArtBank:SetMoney', -1, amount, 'inc')
                TriggerClientEvent('ArtBank:BankResponse', -1, 'success', 'Retirado com sucesso.')
            end)
        else
            TriggerClientEvent('ArtBank:BankResponse', -1, 'error', 'Quantia inválida.')
        end
    end)
end)

RegisterServerEvent('ArtBank:DepositMoney')
AddEventHandler('ArtBank:DepositMoney', function(amount, moneyPocket)
    local identifiers = exports.functions:ExtractIdentifiers(source)
    local steam = identifiers.steam
    MySQL.Async.fetchAll('SELECT p.id, ba.money FROM players AS p INNER JOIN bank_account AS ba' ..
    ' ON ba.player_id = p.id INNER JOIN users AS u ON p.user_id = u.id WHERE u.steam_id = @steam LIMIT 1',
    {['@steam'] = steam}, function (result)
        if result[1].money and amount ~= nil and amount >= 0 and moneyPocket >= amount then
            local money = result[1].money
            local pid = result[1].id
            MySQL.Async.fetchAll('INSERT INTO bank_account (player_id, money) VALUES (@id, @money)',
            {['@id'] = pid, ['@money'] = (money + amount)}, function (result)
                TriggerClientEvent('ArtBank:SetMoney', -1, amount, 'dec')
                TriggerClientEvent('ArtBank:BankResponse', -1, 'success', 'Depositado com sucesso.')
            end)
        else
            TriggerClientEvent('ArtBank:BankResponse', -1, 'error', 'Quantia inválida.')
        end
    end)
end)