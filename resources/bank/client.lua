ARTX = ARTX or {}
local coord = false
local nearAtm = false
local atmInUse = false
local cashRegister = {
	{x=145.995, y=-1035.124, z=29.34},
	{x=147.764, y=-1035.722, z=29.34},
	{x=242.336, y=225.020, z=106.28},
	{x=149.942, y=-1040.450, z=29.37},
	{x=-1212.980, y=-330.841, z=37.78},
	{x=-2962.582, y=482.627, z=15.70},
	{x=-112.012, y=6469.148, z=31.62},
	{x=-351.534, y=-49.529, z=49.04},
	{x=1175.064, y=2706.643, z=38.09},
	{x=-386.733, y=6045.953, z=31.50},
	{x=-283.158, y=6225.821, z=31.49},
	{x=-133.005, y=6366.493, z=31.47},
	{x=-95.556, y=6457.074, z=31.46},
	{x=-97.190, y=6455.340, z=31.46},
	{x=155.555, y=6642.509, z=31.61},
	{x=174.363, y=6637.720, z=31.57},
	{x=1701.549, y=6426.415, z=32.63},
	{x=1735.291, y=6410.684, z=35.03},
	{x=1702.987, y=4933.509, z=42.06},
	{x=1968.091, y=3743.619, z=32.34},
	{x=1822.615, y=3683.116, z=34.27},
	{x=540.322, y=2671.120, z=42.15},
	{x=2564.599, y=2584.714, z=38.08},
	{x=2558.882, y=351.010, z=108.62},
	{x=2558.412, y=389.492, z=108.62},
	{x=1077.764, y=-776.294, z=58.23},
	{x=1138.393, y=-468.936, z=66.73},
	{x=1166.988, y=-456.116, z=66.79},
	{x=1153.738, y=-326.759, z=69.20},
	{x=380.778, y=323.395, z=103.56},
	{x=237.162, y=217.600, z=106.28},
	{x=264.906, y=212.055, z=106.28},
	{x=285.527, y=143.461, z=104.17},
	{x=158.533, y=234.109, z=106.62},
	{x=-165.115, y=232.728, z=94.92},
	{x=-165.093, y=234.807, z=94.92},
	{x=-1827.191, y=784.897, z=138.30},
	{x=-1410.317, y=-98.728, z=52.43},
	{x=-1409.677, y=-100.532, z=52.43},
	{x=-1204.975, y=-326.324, z=37.83},
	{x=-2072.608, y=-317.230, z=13.31},
	{x=-2975.393, y=380.161, z=14.99},
	{x=-2962.60, y=482.191, z=15.76},
	{x=-2956.914, y=487.728, z=15.46},
	{x=-2959.015, y=487.765, z=15.46},
	{x=-3043.992, y=594.587, z=7.73},
	{x=-3144.13, y=1127.415, z=20.86},
	{x=-3241.063, y=997.350, z=12.55},
	{x=-3240.670, y=1008.551, z=12.83},
	{x=-1305.399, y=-706.373, z=25.32},
	{x=-537.706, y=-854.466, z=29.29},
	{x=-712.917, y=-818.965, z=23.72},
	{x=-710.024, y=-819.014, z=23.72},
	{x=-717.660, y=-915.696, z=19.21},
	{x=-526.566, y=-1222.90, z=18.43},
	{x=-258.781, y=-723.415, z=33.46},
	{x=-256.213, y=-716.010, z=33.52},
	{x=-203.775, y=-861.571, z=30.26},
	{x=111.220, y=-775.452, z=31.43},
	{x=114.407, y=-776.528, z=31.41},
	{x=112.575, y=-819.362, z=31.33},
	{x=119.118, y=-883.724, z=31.12},
	{x=-846.304, y=-340.402, z=38.68},
	{x=-1205.729, y=-324.765, z=37.85},
	{x=-56.933, y=-1752.135, z=29.42},
	{x=314.187, y=-278.621, z=54.17},
	{x=24.332, y=-946.284, z=29.35},
	{x=-254.432, y=-692.368, z=33.60},
	{x=-1570.197, y=-546.651, z=34.95},
	{x=-1416.085, y=-211.964, z=46.50},
	{x=-1430.112, y=-211.014, z=46.50},
	{x=33.202, y=-1348.064, z=29.49},
	{x=129.211, y=-1291.113, z=29.26},
	{x=130.048, y=-1292.686, z=29.26},
	{x=288.757, y=-1282.340, z=29.64},
	{x=288.828, y=-1256.860, z=29.44},
	{x=296.460, y=-894.123, z=29.23},
	{x=295.729, y=-896.104, z=29.21},
	{x=1686.753, y=4815.809, z=42.00},
	{x=-302.408, y=-829.945, z=32.41},
	{x=5.134, y=-919.949, z=29.55},
	{x=527.26, y=-160.76, z=57.09},
	{x=-866.692, y=-187.656, z=37.84},
	{x=-867.565, y=-186.107, z=37.83},
	{x=-821.62, y=-1081.88, z=11.13},
	{x=-1314.820, y=-835.972, z=16.96},
	{x=-660.71, y=-854.06, z=24.48},
	{x=-1109.73, y=-1690.81, z=4.37},
	{x=-1091.5, y=2708.66, z=18.95},
	{x=1171.98, y=2702.55, z=38.18},
	{x=2683.09, y=3286.53, z=55.24},
	{x=89.61, y=2.37, z=68.31},
	{x=-30.3, y=-723.76, z=44.23},
	{x=-28.07, y=-724.61, z=44.23},
	{x=-611.885, y=-704.786, z=31.23},
	{x=-614.602, y=-704.716, z=31.23},
	{x=-618.408, y=-708.917, z=30.05},
	{x=-618.332, y=-706.861, z=30.05},
	{x=-1289.23, y=-226.77, z=42.45},
	{x=-1285.6, y=-224.28, z=42.45},
	{x=-1286.24, y=-213.39, z=42.45},
	{x=-1282.538, y=-210.890, z=42.45}
}

RegisterNetEvent('ArtBank:CurrentBalance')
AddEventHandler('ArtBank:CurrentBalance', function(balance)
	SetNuiFocus(true, true)
	BankAnimation()
	SendNUIMessage({
		openoptions = true,
		balance = balance,
		player = GetPlayerName()
	})
end)

RegisterNetEvent('ArtBank:BankResponse')
AddEventHandler('ArtBank:BankResponse', function(status, message)
	TriggerServerEvent('ArtBank:Balance')
	SendNUIMessage({bankresponse = true, message = message, status = status})
end)

RegisterNetEvent('ArtBank:SetMoney')
AddEventHandler('ArtBank:SetMoney', function(amount, operation)
    local pedId = PlayerPedId()
	local currentMoney = GetPedMoney(pedId)
	if operation == 'inc' then
		SetPedMoney(pedId, currentMoney + amount);
	else
		SetPedMoney(pedId, currentMoney - amount);
	end
	exports.functions:ShowMoneyHud(operation, amount, 5)
end)

RegisterNUICallback('nuifocusoff', function()
    BankAnimation()
	SetNuiFocus(false, false)
end)

RegisterNUICallback('withdraw', function(data)
	TriggerServerEvent('ArtBank:WithdrawMoney', tonumber(data.amount))
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('ArtBank:DepositMoney', tonumber(data.amount), GetPedMoney(PlayerPedId()))
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if nearAtm ~= false and nearAtm ~= nil then
			exports.functions:ShowMoneyHud(false, nil, false)
			exports.functions:Draw3DText('~r~[E]~w~ para acessar o caixa.', nearAtm.x, nearAtm.y, nearAtm.z)
			if IsControlJustPressed(1, 38) then
				TriggerServerEvent('ArtBank:Balance')
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		coord = GetEntityCoords(PlayerPedId())
		nearAtm = NearCashRegister(coord)
	end
end)

function NearCashRegister(coord)
	for k = 1, #cashRegister do
		local v = cashRegister[k];
		if GetDistanceBetweenCoords(coord, v.x, v.y, v.z, true) < 1 then
			return {x=v.x, y=v.y, z=v.z}
		end
	end
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 

function BankAnimation()
	local pedId = PlayerPedId()
	if (DoesEntityExist(pedId) and not IsEntityDead(pedId)) then 
        LoadAnimDict('amb@prop_human_atm@male@enter')
        LoadAnimDict('amb@prop_human_atm@male@exit')
        LoadAnimDict('amb@prop_human_atm@male@idle_a')
        if atmInUse then
            ClearPedTasks(pedId)
            TaskPlayAnim(pedId, 'amb@prop_human_atm@male@exit', 'exit', 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
            atmInUse = false
            exports['art-taskbar']:taskBar(3000, 'Removendo Cartão')
            ClearPedTasks(pedId)
		else
			atmInUse = true
			TaskPlayAnim(pedId, 'amb@prop_human_atm@male@enter', 'enter', 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
			TaskPlayAnim(pedId, 'amb@prop_human_atm@male@idle_a', 'idle_b', 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
			exports['art-taskbar']:taskBar(3000, 'Colocando Cartão')
		end
    end
end