local nearGarage = {true, true, true, true}

local garage_markers = {
	{id=2, x=-335.634, y=-886.523, z=31.071, h=255.849, r=0, g=157, b=0, help_text='Pressione ~INPUT_CONTEXT~ para retirar um veículo.'},
	{id=2, x=234.606, y=-794.513, z=30.540, h=155.161, r=0, g=157, b=0, help_text='Pressione ~INPUT_CONTEXT~ para retirar um veículo.'},
	{id=2, x=75.481, y=19.831, z=69.159, h=156.191, r=0, g=157, b=0, help_text='Pressione ~INPUT_CONTEXT~ para retirar um veículo.'},
	{id=2, x=290.191, y=-337.562, z=44.962, h=158.842, r=0, g=157, b=0, help_text='Pressione ~INPUT_CONTEXT~ para retirar um veículo.'},
	{id=2, x=-344.844, y=291.051, z=85.200, h=180.688, r=0, g=157, b=0, help_text='Pressione ~INPUT_CONTEXT~ para retirar um veículo.'},
	{id=2, x=-647.422, y=-2206.917, z=5.992, h=227.782, r=0, g=157, b=0, help_text='Pressione ~INPUT_CONTEXT~ para retirar um veículo.'},
	{id=2, x=-764.474, y=-2031.294, z=8.893, h=84.300, r=0, g=157, b=0, help_text='Pressione ~INPUT_CONTEXT~ para retirar um veículo.'},
	{id=2, x=-147.858, y=-2144.447, z=16.704, h=107.597, r=0, g=157, b=0, help_text='Pressione ~INPUT_CONTEXT~ para retirar um veículo.'},
	{id=2, x=-322.172, y=-884.996, z=31.071, r=157, g=50, b=0, help_text='Pressione ~INPUT_CONTEXT~ para guardar o veículo.'},
	{id=2, x=215.971, y=-787.761, z=30.827, r=157, g=50, b=0, help_text='Pressione ~INPUT_CONTEXT~ para guardar o veículo.'},
	{id=2, x=59.516, y=24.813, z=69.749, r=157, g=50, b=0, help_text='Pressione ~INPUT_CONTEXT~ para guardar o veículo.'},
	{id=2, x=274.581, y=-330.289, z=44.923, r=157, g=50, b=0, help_text='Pressione ~INPUT_CONTEXT~ para guardar o veículo.'},
	{id=2, x=-334.720, y=291.335, z=85.803, r=157, g=50, b=0, help_text='Pressione ~INPUT_CONTEXT~ para guardar o veículo.'},
	{id=2, x=-643.255, y=-2201.779, z=5.992, r=157, g=50, b=0, help_text='Pressione ~INPUT_CONTEXT~ para guardar o veículo.'},
	{id=2, x=-770.937, y=-2038.691, z=8.892, r=157, g=50, b=0, help_text='Pressione ~INPUT_CONTEXT~ para guardar o veículo.'},
	{id=2, x=-134.870, y=-2144.773, z=16.704, r=157, g=50, b=0, help_text='Pressione ~INPUT_CONTEXT~ para guardar o veículo.'},
}

local config = {
	controls = {
		{control = {46}, action = 'toggle', alwayslisten = true},
		{control = {172}, action = 'up'},
		{control = {173}, action = 'down'},
		{control = {176}, action = 'enter'},
		{control = {177}, action = 'back'}
	}
}

RegisterNUICallback('getmycarsin', function(data)
	TriggerServerEvent('ArtGarage:ListMyCarsIn')
end)

RegisterNUICallback('getmycarsout', function(data)
	TriggerServerEvent('ArtGarage:ListMyCarsOut')
end)

RegisterNUICallback('spawncar', function(data)
	menuopen = false
	TriggerEvent('ArtGarage:Fee', data)
end)

RegisterNetEvent('ArtGarage:MyVehicles')
AddEventHandler('ArtGarage:MyVehicles', function(car)
	SendNUIMessage({{submenu=true}, car})
end)

RegisterNetEvent('ArtGarage:Fee')
AddEventHandler('ArtGarage:Fee', function(car)
	TriggerServerEvent('ArtGarage:FeeCar', car)
end)

RegisterNetEvent('ArtGarage:SpawnMyCar')
AddEventHandler('ArtGarage:SpawnMyCar', function(car)
	CreateCar(car, nearGarage.x, nearGarage.y, nearGarage.z, nearGarage.h)
	TriggerServerEvent('ArtGarage:UpdateCarStored', 0)
end)

RegisterNetEvent('ArtGarage:DespawnMyCar')
AddEventHandler('ArtGarage:despawnmycar', function()
	DespawnCar(PlayerPedId())
	TriggerServerEvent('ArtGarage:UpdateCarStored', 1)
end)

RegisterNetEvent('ArtGarage:FeePlayer')
AddEventHandler('ArtGarage:FeePlayer', function(car)
	local ped = PlayerPedId()
	local currentMoney = GetPedMoney(ped)
	if currentMoney < 1000 then
		AddTextEntry('ArtNotification', 'Você precisa de ~r~$1000~w~ para recuperar este veículo.')
		BeginTextCommandThefeedPost('ArtNotification')
		EndTextCommandThefeedPostTicker(false, false)
	else
		SetPedMoney(ped, currentMoney - 1000);
		AddTextEntry('ArtNotification', 'Veículo ~g~recuperado~w~ com sucesso.')
		BeginTextCommandThefeedPost('ArtNotification')
		EndTextCommandThefeedPostTicker(false, false)
		TriggerEvent('ArtGarage:SpawnMyCar', car)
		exports.functions:ShowMoneyHud('dec', 1000, 5)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		local sittingVehicle = IsPedSittingInAnyVehicle(PlayerPedId())
		for k = 1, #garage_markers do
			local v = garage_markers[k];
			DrawMarker(v.id, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, v.r, v.g, v.b, 155, 0, 1, 0, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true) < 3 then
				SetTextComponentFormat('STRING')
				AddTextComponentString(v.help_text)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				nearGarage = {x=v.x, y=v.y, z=v.z, h=v.h}
				if v.g == 157 and sittingVehicle == false then
					KeyAction()
				elseif IsControlJustPressed(1, 46) and v.r == 157 then
					if sittingVehicle then
						if CheckCarCrash() == false then
							local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
							local plate = GetVehicleNumberPlateText(vehicle)
							TriggerServerEvent('ArtGarage:StoreMyCar', plate)
						else
							AddTextEntry('ArtNotification', 'O veículo precisa de ~r~reparos~w~.')
							BeginTextCommandThefeedPost('ArtNotification')
							EndTextCommandThefeedPostTicker(false, false)
						end
					end
				end
			else
				local coords = GetEntityCoords(PlayerPedId())
				if menuopen and nearGarage[1] ~= true and GetDistanceBetweenCoords(coords, nearGarage.x, nearGarage.y, nearGarage.z, true) > 3 then
					menuopen = false
					SendNUIMessage({
						hidemenu = true
					})
				end
			end
		end
	end
end)

function SendDataAction(data)
	if data == 'toggle' then
		if not menuopen then
			menuopen = true
			SendNUIMessage({
				showmenu = true
			})
		else
			menuopen = false
			SendNUIMessage({
				hidemenu = true
			})
		end
	elseif data == 'enter' then
		SendNUIMessage({
			menuenter = true
		})
	elseif data == 'back' then
		SendNUIMessage({
			menuback = true
		})
	elseif data == 'up' then
		SendNUIMessage({
			menuup = true
		})
	elseif data == 'down' then
		SendNUIMessage({
			menudown = true
		})
	end
end

function KeyAction()
	for k = 1, #config.controls do
		local data = config.controls[k];
		if menuopen or data.alwayslisten then
			for i = 1, #data.control do
				local control = data.control[i]
				if not IsControlPressed(1, control) then
					break
				end
				if i == #data.control then
					if IsControlJustPressed(1, control) then
						SendDataAction(data.action)
					end
				end
			end
		end
	end
end

function CreateCar(car, x, y, z, heading)
	RequestModel(car.model)
	while not HasModelLoaded(car.model) do
		Citizen.Wait(500)
	end
	local spawned_car = CreateVehicle(car.model, x, y, z, heading, true, false)
    SetVehicleOnGroundProperly(spawned_car)
    SetVehicleNumberPlateText(spawned_car, car.plate)
    SetVehicleDoorsLocked(spawned_car, 1)
	TaskWarpPedIntoVehicle(PlayerPedId(), spawned_car, -1)
	SetModelAsNoLongerNeeded(car.model)
end

function DespawnCar(ped)
	local vehicle = GetVehiclePedIsIn(ped, false)
	SetEntityAsMissionEntity(vehicle, true, true)
	DeleteVehicle(vehicle)
end

function CheckCarCrash()
	local car = GetVehiclePedIsIn(PlayerPedId(),  false)
	local maxHealth = GetEntityMaxHealth(car)
	local health = GetEntityHealth(car)
	local healthPercent = (health / maxHealth) * 100
	if healthPercent < 90 then
		return true
	end
	return false
end