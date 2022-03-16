local phoneOpen = false

local config = {
	controls = {
		{control = {80}, action = 'show', alwayslisten = true}
	}
}

RegisterNetEvent('ArtPhone:RetrievePosts')
AddEventHandler('ArtPhone:RetrievePosts', function(posts)
	SendNUIMessage({ 
		app_yellowpages = true,
		posts = posts
	})
end)

RegisterNetEvent('ArtPhone:GetUpdatedPosts')
AddEventHandler('ArtPhone:GetUpdatedPosts', function()
	TriggerServerEvent('ArtPhone:GetPosts')
end)

RegisterNetEvent('ArtPhone:CurrentBalance')
AddEventHandler('ArtPhone:CurrentBalance', function(balance)
	SendNUIMessage({ 
		app_bank = true,
		balance = balance
	})
end)

RegisterNUICallback('posts', function()
	TriggerServerEvent('ArtPhone:GetPosts')
end)

RegisterNUICallback('savepost', function(post)
	TriggerServerEvent('ArtPhone:SaveMyPost', post.message)
end)

RegisterNUICallback('mybalance', function()
	TriggerServerEvent('ArtPhone:Balance')
end)

RegisterNUICallback('nuifocusoff', function()
	local playerPed = PlayerPedId()
	phoneOpen = false
	SetNuiFocus(false)
	ClearPedTasks(playerPed)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		action()
	end
end)

function send(data)
	if data == 'show' then
		if phoneOpen then
			SetNuiFocus(true, true)
			SendNUIMessage({
				showphone = true
			})
		end
	end
end

function action()
	for k = 1, #config.controls do
		local data = config.controls[k];
		for i = 1, #data.control do
			local control = data.control[i]
			if i == #data.control then
				if IsControlJustPressed(1, control) then
					phoneOpen = not phoneOpen
					send(data.action)
				end
			end
		end
	end
end