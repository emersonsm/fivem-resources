local spawnPoints = {
    [1] =  { ['x'] = -204.93,['y'] = -1010.13,['z'] = 29.55,['h'] = 180.99, ['info'] = ' Altee Street Train Station'},
    [2] =  { ['x'] = 272.16,['y'] = 185.44,['z'] = 104.67,['h'] = 320.57, ['info'] = ' Vinewood Blvd Taxi Stand'},
    [3] =  { ['x'] = -1833.96,['y'] = -1223.5,['z'] = 13.02,['h'] = 310.63, ['info'] = ' The Boardwalk'},
    [4] =  { ['x'] = 145.62,['y'] = 6563.19,['z'] = 32.0,['h'] = 42.83, ['info'] = ' Paleto Gas Station'},
    [5] =  { ['x'] = -214.24,['y'] = 6178.87,['z'] = 31.17,['h'] = 40.11, ['info'] = ' Paleto Bus Stop'},
    [6] =  { ['x'] = 1122.11,['y'] = 2667.24,['z'] = 38.04,['h'] = 180.39, ['info'] = ' Harmony Motel'},
    [7] =  { ['x'] = 453.29,['y'] = -662.23,['z'] = 28.01,['h'] = 5.73, ['info'] = ' LS Bus Station'},
    [8] =  { ['x'] = -1266.53,['y'] = 273.86,['z'] = 64.66,['h'] = 28.52, ['info'] = ' The Richman Hotel'},
}
spawning = false
spawnSelection = 1

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if DoesEntityExist(PlayerPedId()) and NetworkIsSessionStarted() then
            TriggerServerEvent('ArtCharacter:SaveUser')
            return
        end
    end
end)

RegisterNUICallback('InitAfterNUI', function(data, cb)
	TriggerEvent('ArtCharacter:BeginCharacterSelection')
end)

RegisterNUICallback('listmychars', function()
	TriggerServerEvent('ArtCharacter:GetMyCharacters')
end)

RegisterNUICallback('playwithcharacter', function(character)
	TriggerEvent('ArtCharacter:PlayCharacter', character)
end)

RegisterNUICallback('savecharacter', function(data)
    TriggerServerEvent('ArtCharacter:SaveCharacter', data)
end)

RegisterNUICallback('deletecharacter', function(data)
    TriggerServerEvent('ArtCharacter:DeleteCharacter', data)
end)

RegisterNUICallback('switchspawn', function(data)
    TriggerEvent('ArtCharacter:SwitchCameraSpawn', data)
end)

RegisterNUICallback('spawnplayer', function(data)
    TriggerEvent('ArtCharacter:SpawnPlayer', data)
end)

RegisterNetEvent('ArtCharacter:PlayCharacter')
AddEventHandler('ArtCharacter:PlayCharacter', function(character)
    exports['art-base']:SetVar('id', character.id)
    SendNUIMessage({
        step = 3,
        spawns = spawnPoints,
    })
    doCameraSpawn()
end)

RegisterNetEvent('ArtCharacter:GetUpdatedCharacters')
AddEventHandler('ArtCharacter:GetUpdatedCharacters', function()
	TriggerServerEvent('ArtCharacter:GetMyCharacters')
end)

RegisterNetEvent('ArtCharacter:SelectCharacter')
AddEventHandler('ArtCharacter:SelectCharacter', function(characters)
	SetNuiFocus(true, true)
	SendNUIMessage({
		step = 2,
		characters = characters,
	})
end)

RegisterNetEvent('ArtCharacter:BeginCharacterSelection')
AddEventHandler('ArtCharacter:BeginCharacterSelection', function()
	Citizen.CreateThread(function()
        SetNuiFocus(true, false)
        SendNUIMessage({
            step = 1
        })
        ShutdownLoadingScreen()
	end)
end)

RegisterNetEvent('ArtCharacter:SwitchCameraSpawn')
AddEventHandler('ArtCharacter:SwitchCameraSpawn', function(data)
    spawnSelection = tonumber(data.activespawn)
    doCameraSpawn()
end)

RegisterNetEvent('ArtCharacter:SpawnPlayer')
AddEventHandler('ArtCharacter:SpawnPlayer', function()
    Citizen.CreateThread(function()
        local characterId = exports['art-base']:GetVar('id')
        if characterId ~= nil then
            local ped = GetPlayerPed(-1)
            local x = spawnPoints[spawnSelection]['x']
            local y = spawnPoints[spawnSelection]['y']
            local z = spawnPoints[spawnSelection]['z']

            RequestCollisionAtCoord(x, y, z)

            SetEntityCoordsNoOffset(ped, x, y, z, false, false, false, true)
            SetEntityVisible(ped, true)
            FreezeEntityPosition(ped, false)

            ClearPedTasksImmediately(ped)
            RemoveAllPedWeapons(ped)
            ClearPlayerWantedLevel(PlayerId())
            
            local startedCollision = GetGameTimer()

            while not HasCollisionLoadedAroundEntity(ped) do
                if GetGameTimer() - startedCollision > 8000 then break end
                Citizen.Wait(0)
            end

            Citizen.Wait(500)

            DoScreenFadeIn(300)

            while IsScreenFadingIn() do
                Citizen.Wait(0)
            end

            TransitionFromBlurred(300)
            SetPlayerInvincible(PlayerId(), false)
            SetNuiFocus(false)

            DestroyAllCams(true)
            RenderScriptCams(false, true, 1, true, true)
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end)
end)

function doCameraSpawn()
    local camSelection = spawnSelection
    local x = spawnPoints[spawnSelection]['x']
    local y = spawnPoints[spawnSelection]['y']
    local z = spawnPoints[spawnSelection]['z']
    local h = spawnPoints[spawnSelection]['h']
    local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    local camAngle = -90.0
    i = 3200
    
    if spawning then
        return
    end

    Citizen.Wait(1)
    DoScreenFadeOut(1)

    SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)
    DoScreenFadeIn(1500)
    while i > 1 and camSelection == spawnSelection and not spawning do
        local factor = i / 50
        if i < 1 then i = 1 end
        i = i - factor
        SetCamCoord(cam, x, y, z + i)
        if i < 1200 then
            DoScreenFadeIn(600)
        end
        if i < 90.0 then
            camAngle = i - i - i
        end
        SetCamRot(cam, camAngle, 0.0, 0.0)
        Citizen.Wait(1)
    end
end