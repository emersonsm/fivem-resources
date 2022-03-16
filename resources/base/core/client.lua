ARTX = ARTX or {}

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
		SetWeaponDamageModifier(GetHashKey('weapon_unarmed'), 0.1)
		SetWeaponDamageModifier(GetHashKey('weapon_dagger'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_switchblade'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_nightstick'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_wrench'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_knife'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_machete'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_bottle'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_flashlight'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_hatchet'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_battleaxe'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_stone_hatchet'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_hammer'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_crowbar'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_bat'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_golfclub'), 0.2)
		SetWeaponDamageModifier(GetHashKey('weapon_poolcue'), 0.2)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent('artBase:setupUser')
			return
		end
	end
end)

function SetVar(var, data)
    ARTX[var] = data
end

function GetVar(var)
    return ARTX[var]
end