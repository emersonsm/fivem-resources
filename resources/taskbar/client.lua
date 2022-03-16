local lockpos = false
local insidePrompt = false

function openGui(sentLength,taskID,namesent,keepWeapon)
    if not keepWeapon then
        SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
    end
    guiEnabled = true
    SendNUIMessage({runProgress = true, Length = sentLength, Task = taskID, name = namesent})
end
function updateGui(sentLength,taskID,namesent)
    SendNUIMessage({runUpdate = true, Length = sentLength, Task = taskID, name = namesent})
end
local activeTasks = {}
function closeGuiFail()
    guiEnabled = false
    SendNUIMessage({closeFail = true})
    ClearPedTasks(GetPlayerPed(-1))
end
function closeGui()
    guiEnabled = false
    SendNUIMessage({closeProgress = true})
    ClearPedTasks(GetPlayerPed(-1))
end

function closeNormalGui()
    guiEnabled = false
end

RegisterNUICallback('taskCancel', function(data, cb)
  closeGui()
  local taskIdentifier = data.tasknum
  activeTasks[taskIdentifier] = 2
end)

RegisterNUICallback('taskEnd', function(data, cb)
  closeNormalGui()
  
  local taskIdentifier = data.tasknum
  activeTasks[taskIdentifier] = 3
end)


-- command is something we do in the loop if we want to disable more, IE a vehicle engine.
-- return true or false, if false, gives the % completed.
local taskInProcess = false
function taskBar(length,name,runCheck,keepWeapon)
    if taskInProcess then
        return 0
    end
    taskInProcess = true
    local taskIdentifier = "taskid" .. math.random(1000000)
    openGui(length,taskIdentifier,name,keepWeapon)
    activeTasks[taskIdentifier] = 1

    local maxcount = math.ceil(length / 10)

    while activeTasks[taskIdentifier] == 1 do
        Citizen.Wait(1)
        -- maxcount = maxcount - 1
        -- if maxcount == 0 or not guiEnabled then
        --     activeTasks[taskIdentifier] = 2
        -- end
        -- local fuck = 100 - (maxcount / (length / 10) * 100)
        -- updateGui(fuck,taskIdentifier,name)

        if runCheck then
            if IsPedClimbing(GetPlayerPed(-1)) or IsPedJumping(GetPlayerPed(-1)) or IsPedRunning(GetPlayerPed(-1)) or IsPedSwimming(GetPlayerPed(-1)) then
                SetPlayerControl(PlayerId(), 0, 0)
                local totaldone = math.ceil(100 - (maxcount / (length / 10) * 100))
                taskInProcess = false
                closeGuiFail()
                Citizen.Wait(1000)
                SetPlayerControl(PlayerId(), 1, 1)
                Citizen.Wait(1000)
                return totaldone
            end
        end
    end

    local resultTask = activeTasks[taskIdentifier]
    if resultTask == 2 then
        local totaldone = math.ceil(100 - (maxcount / (length / 10) * 100))
        taskInProcess = false
        closeGuiFail()
        return totaldone
    else
        closeGui()
        taskInProcess = false
        return 100
    end 
   
end

-- function CheckCancels()
--     if IsPedRagdoll(GetPlayerPed(-1)) then
--         return true
--     end
--     return false
-- end
-- trigger this way for the timer with out stopping another thread
RegisterNetEvent('hud:taskBar')
AddEventHandler('hud:taskBar', function(length,name)
    taskBar(length,name)
end)

RegisterNetEvent('hud:insidePrompt')
AddEventHandler('hud:insidePrompt', function(bool)
    insidePrompt = bool
end)

local standingstill = false
-- Citizen.CreateThread( function()   
--     while true do 
--         Citizen.Wait(1)
--         if guiEnabled then
            
--             if IsDisabledControlJustReleased(0, 322) or IsDisabledControlJustReleased(0, 22) then
--                 print("cock dicks")
--                closeGuiFail() 
--             end

--         else

--             lockpos = false
--             -- p for phone
--             DisableControlAction(1, 199, true)
--             if IsDisabledControlJustReleased(1, 199) and not insidePrompt then
--                 TriggerEvent("phoneGui") 
--             end
--             -- k for KUNTVENTORY
--             DisableControlAction(1, 311, true)
--             if IsDisabledControlJustReleased(1, 311) and not insidePrompt then
--                 TriggerServerEvent("inv:openUI","playerID")
--             end
            
--         end     
--     end
-- end)
