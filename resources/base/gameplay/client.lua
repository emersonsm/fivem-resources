local pId = PlayerId()

Citizen.CreateThread(function()
	while true do
		DisableWantedAndAI(pId)
		DisableDefaultHuds()
		Citizen.Wait(1)
	end
end)

function DisableWantedAndAI(playerId)
	SetPlayerWantedLevel(playerId, 0, false)
	SetPlayerWantedLevelNow(playerId, false)
	SetPlayerWantedLevelNoDrop(playerId, 0, false)
	for i = 1, 12 do
		EnableDispatchService(i, false)
	end
end

function DisableDefaultHuds()
    HideHudComponentThisFrame(1)
    HideHudComponentThisFrame(3)
    HideHudComponentThisFrame(4)
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(13)
end