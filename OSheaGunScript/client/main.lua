
-------------------------------
------- OShea GunScript -------
-------------------------------

-------------------------
------- Variables -------
-------------------------
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local holstered  = true
local blocked	 = false
local dbtxterr = "Hey - This weapon can only be taken from the trunk of a car."
local dbtxter = "Hey - You are not allowed to swap to a different Heavy Firearm."
local chatMessage = false 
local newWeap
local daw = false
local bigWeaponOut = false
local smallWeaponOut = false
local meleeWeaponOut = false

local bigweaponslist = {	
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_RAYMINIGUN",
	"WEAPON_DIGISCANNER"
}

-- list of weapons for small weapons message

local smallweaponslist = {
	"WEAPON_REVOLVER",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_PROXMINE",
	"WEAPON_BZGAS",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_SNOWBALL",
	"WEAPON_FLARE",
	"WEAPON_BALL",
	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB"
}
local holsterweapons = {
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_FLAREGUN",
	"WEAPON_STUNGUN",
	"WEAPON_REVOLVER",
}
-- list of weapons for melee weapons message

local meleeweaponslist = {
	"WEAPON_KNIFE",
	"WEAPON_KNUCKLE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	--"WEAPON_FLASHLIGHT",
	"WEAPON_SWITCHBLADE",
	"WEAPON_POOLCUE",
	"WEAPON_PIPEWRENCH"
}

-------------------------
-------- Threads --------
-------------------------

 Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		loadAnimDict("rcmjosh4")
		loadAnimDict("reaction@intimidation@cop@unarmed")
		loadAnimDict("reaction@intimidation@1h")
		local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped, false) then
				if GetVehiclePedIsTryingToEnter (ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
					if CheckWeapon(ped) then
						--if IsPedArmed(ped, 4) then
						if holstered then
							blocked   = true
								SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
								TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when removing weapon
								--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
									Citizen.Wait(1200)
								SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
								TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
									Citizen.Wait(400)
								ClearPedTasks(ped)
							holstered = false
						else
							blocked = false
						end
					else
						if not holstered then
					
								TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
									Citizen.Wait(500)
								TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
								--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when holstering weapon
									Citizen.Wait(60)
								ClearPedTasks(ped)
							holstered = true
						end
					end
				else
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				end
			else
				holstered = true
			end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if blocked then
			DisableControlAction(1, 25, true )
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(250)
		local playerPed = GetPlayerPed(-1)
		local weapon
		local vehicle = VehicleInFront()
			if playerPed then --if a player
			 weapon = GetSelectedPedWeapon(playerPed, true) -- get weapon hash

					if isWeaponBig(weapon) then --is player attempting to take out a "big" weapon
						local vehicle = VehicleInFront() -- get vehicle in front of player

						if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and bigWeaponOut == false then -- if player is not in vehicle and there is a vehicle and no weapon is out yet
							newWeap = GetSelectedPedWeapon(playerPed, true)	
							bigWeaponOut = true
							SetVehicleDoorOpen(vehicle, 5, false, false)
							--exports.rprogress:Start('Retrieving Weapon' --[[ string ]], 3000 --[[ number ]])
							Citizen.Wait(2000)
							newWeap = GetSelectedPedWeapon(playerPed, true)	
							SetVehicleDoorShut(vehicle, 5, false)
							Citizen.Wait(6000)
						elseif bigWeaponOut == true and newWeap ~= nil and newWeap ~= weapon and weapon ~= -1569615261 and vehicle == 0 then
							drawNotification("~p~ Cheeky Tactic ~r~".. dbtxter.."")
								SetCurrentPedWeapon(playerPed, newWeap)
							Wait(100)
						elseif GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and bigWeaponOut == true and vehicle ~= 0 then -- if player is not in vehicle and there is a vehicle and no weapon is out yet
									Citizen.Wait(4000)
										newWeap = GetSelectedPedWeapon(playerPed, true)
										weapon = GetSelectedPedWeapon(playerPed, true)
										SetVehicleDoorOpen(vehicle, 5, false, false)
										--exports.rprogress:Start('Swapping Weapon' --[[ string ]], 3000 --[[ number ]])
										newWeap = GetSelectedPedWeapon(playerPed, true)
										weapon = GetSelectedPedWeapon(playerPed, true)
										Citizen.Wait(2000)
										SetVehicleDoorShut(vehicle, 5, false)
										Citizen.Wait(6000)
						else
							if bigWeaponOut == false and GetVehiclePedIsIn(playerPed, false) == 0 then -- male
								drawNotification("~p~Stop the Fail RP ~r~"..dbtxterr.."")
								SetCurrentPedWeapon(playerPed, -1569615261)
							end
						end


					end
			end
			Wait(100)

			playerPed = GetPlayerPed(-1)
			if playerPed then
				if not isWeaponBig(weapon) and bigWeaponOut == true then
					Wait(100)
					bigWeaponOut = false
				end
				if not isWeaponSmall(weapon) and smallWeaponOut == true then
					Wait(100)
					smallWeaponOut = false
				end
				if not isWeaponMelee(weapon) and meleeWeaponOut == true then
					Wait(100)
					meleeWeaponOut = false

				end	
			end
	end
	Wait(100)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(0,21,true)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if handcuff and not IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "mp_arresting", "idle", 3) then
			Citizen.Wait(3000)
			Citizen.Trace("BACKUP CUFFING TRIGGERED")
			TaskPlayAnim(GetPlayerPed(PlayerId()), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
		end

		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "mp_arresting", "idle", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			SetPedPathCanUseLadders(GetPlayerPed(PlayerId()), false)
			if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
				DisableControlAction(0, 59, true)
			end
		end

		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@mugging3", "handsup_standing_base", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
				DisableControlAction(0, 59, true)
			end
		end
	end
end)
-------------------------
------- FUNCTIONS -------
-------------------------

function VehicleInFront()
	local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
	local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

function isWeaponBig(model)
	for _, bigWeapon in pairs(bigweaponslist) do
		if model == GetHashKey(bigWeapon) then
			return true
		end
	end

	return false
end

function isWeaponSmall(model)
	for _, smallWeapon in pairs(smallweaponslist) do
		if model == GetHashKey(smallWeapon) then
			return true
		end
	end

	return false
end

function isWeaponMelee(model)
	for _, meleeWeapon in pairs(meleeweaponslist) do
		if model == GetHashKey(meleeWeapon) then
			return true
		end
	end

	return false
end

function drawNotification(Notification)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(Notification)
	DrawNotification(false, false)
end

function CheckWeapon(ped)
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #holsterweapons do
				if GetHashKey(holsterweapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

--------------------------
------- Net Events -------
--------------------------

--Hands Up Function
RegisterNetEvent("Handsup")
AddEventHandler("Handsup", function()
	local lPed = GetPlayerPed(-1)
	if DoesEntityExist(lPed) then
		if not IsEntityPlayingAnim(lPed, "mp_arresting", "idle", 3) then
			RequestAnimDict("random@mugging3")
			while not HasAnimDictLoaded("random@mugging3") do
				Citizen.Wait(100)
			end
			
			if IsEntityPlayingAnim(lPed, "random@mugging3", "handsup_standing_base", 3) then
				ClearPedSecondaryTask(lPed)
				SetEnableHandcuffs(lPed, false)
				SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
				TriggerEvent("chatMessage", "", {255, 0, 0}, "You have put your hands down")
			else
				TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
				SetEnableHandcuffs(lPed, true)
				SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
				TriggerEvent("chatMessage", "", {255, 0, 0}, "You have put your hands up")
			end
		else
			TriggerEvent("chatMessage", "", {255, 0, 0}, "You can't raise your hands when your handcuffed")
		end
	end
end)

--Hands Up Kneel Down Function
RegisterNetEvent("Handsupknees")
AddEventHandler("Handsupknees", function()
    local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( "random@arrests" )
		loadAnimDict( "random@arrests@busted" )
		if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
			TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (3000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
        else
            TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (4000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
			TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
        end     
    end
end )
