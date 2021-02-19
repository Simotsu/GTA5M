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

local cokeQTE       			= 0
ESX 			    			= nil
local coke_poochQTE 			= 0
local weedQTE					= 0
local weed_poochQTE 			= 0
local methQTE					= 0
local meth_poochQTE 			= 0
local opiumQTE					= 0
local opium_poochQTE 			= 0
local lsdQTE					= 0
local lsd_poochQTE 				= 0
local pcpQTE					= 0
local pcp_poochQTE 				= 0
local myJob 					= nil
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local isInZone                  = false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_drugs:hasEnteredMarker', function(zone)
	if myJob == 'police' or myJob == 'ambulance' then
		return
	end

	ESX.UI.Menu.CloseAll()
	
	if zone == 'exitMarker' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('exit_marker')
		CurrentActionData = {}
	end

	if zone == 'LSDField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_lsd')
		CurrentActionData = {}
	end

	if zone == 'LSDProcessing' then
		if lsdQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_lsd')
			CurrentActionData = {}
		end
	end
--[[
	if zone == 'LSDDealer' then
		if lsd_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_lsd')
			CurrentActionData = {}
		end
	end
]]--
	if zone == 'PCPField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_pcp')
		CurrentActionData = {}
	end

	if zone == 'PCPProcessing' then
		if pcpQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_pcp')
			CurrentActionData = {}
		end
	end
--[[
	if zone == 'PCPDealer' then
		if pcp_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_pcp')
			CurrentActionData = {}
		end
	end
	]]--
	if zone == 'CokeField' then
		print('fire')
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_coke')
		CurrentActionData = {}
	end

	if zone == 'CokeProcessing' then
		if cokeQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_coke')
			CurrentActionData = {}
		end
	end
	--[[
	if zone == 'CokeDealer' then
		if coke_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_coke')
			CurrentActionData = {}
		end
	end
]]--
	if zone == 'MethField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_meth')
		CurrentActionData = {}
	end

	if zone == 'MethProcessing' then
		if methQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_meth')
			CurrentActionData = {}
		end
	end
--[[
	if zone == 'MethDealer' then
		if meth_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_meth')
			CurrentActionData = {}
		end
	end
]]--
	if zone == 'WeedField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_weed')
		CurrentActionData = {}
	end

	if zone == 'WeedProcessing' then
		if weedQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_weed')
			CurrentActionData = {}
		end
	end
--[[
	if zone == 'WeedDealer' then
		if weed_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_weed')
			CurrentActionData = {}
		end
	end
]]--
	if zone == 'OpiumField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_opium')
		CurrentActionData = {}
	end

	if zone == 'OpiumProcessing' then
		if opiumQTE >= 5 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_opium')
			CurrentActionData = {}
		end
	end
--[[
	if zone == 'OpiumDealer' then
		if opium_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_opium')
			CurrentActionData = {}
		end
	end
	]]--
end)

AddEventHandler('esx_drugs:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

	TriggerServerEvent('esx_drugs:stopHarvestCoke')
	TriggerServerEvent('esx_drugs:stopTransformCoke')
	TriggerServerEvent('esx_drugs:stopSellCoke')
	TriggerServerEvent('esx_drugs:stopHarvestMeth')
	TriggerServerEvent('esx_drugs:stopTransformMeth')
	TriggerServerEvent('esx_drugs:stopSellMeth')
	TriggerServerEvent('esx_drugs:stopHarvestWeed')
	TriggerServerEvent('esx_drugs:stopTransformWeed')
	TriggerServerEvent('esx_drugs:stopSellWeed')
	TriggerServerEvent('esx_drugs:stopHarvestOpium')
	TriggerServerEvent('esx_drugs:stopTransformOpium')
	TriggerServerEvent('esx_drugs:stopSellOpium')
	TriggerServerEvent('esx_drugs:stopHarvestLSD')
	TriggerServerEvent('esx_drugs:stopTransformLSD')
	TriggerServerEvent('esx_drugs:stopSellLSD')
	TriggerServerEvent('esx_drugs:stopHarvestPCP')
	TriggerServerEvent('esx_drugs:stopTransformPCP')
	TriggerServerEvent('esx_drugs:stopSellPCP')
end)

-- Weed Effect
RegisterNetEvent('esx_drugs:onPot')
AddEventHandler('esx_drugs:onPot', function()
	local playerPed = PlayerPedId()
	
	if IsPedOnFoot(playerPed) then
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator10")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(60000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	else
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	SetTimecycleModifier("spectator10")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(60000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)

	end

end)

-- Meth Effect
RegisterNetEvent('esx_drugs:onMeth')
AddEventHandler('esx_drugs:onMeth', function()
	local playerPed = PlayerPedId()
	
	if IsPedOnFoot(playerPed) then
		local prop_name = 'prop_cs_crackpipe'
		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 28422)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.9000, 0.9, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('amb@world_human_aa_smoke@male@idle_a', function()
				TaskPlayAnim(playerPed, 'amb@world_human_aa_smoke@male@idle_a', 'idle_a', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	Citizen.Wait(1000)
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	SetPedMotionBlur(GetPlayerPed(-1), false)
	else
		Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	--ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	Citizen.Wait(1000)
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	SetPedMotionBlur(GetPlayerPed(-1), false)
	end
end)

-- Coke Effect
RegisterNetEvent('esx_drugs:onCoke')
AddEventHandler('esx_drugs:onCoke', function()

local playerPed = PlayerPedId()
	
	if IsPedOnFoot(playerPed) then
		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			--local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			----local boneIndex = GetPedBoneIndex(playerPed, 57005)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.54, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('move_p_m_two_idles@generic', function()
				TaskPlayAnim(playerPed, 'move_p_m_two_idles@generic', 'fidget_sniff_fingers', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
			--	IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				--DeleteObject(prop)
			end)
		end)

	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator9")
	SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
	Citizen.Wait(60000)
	ClearTimecycleModifier()
	SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
	ResetScenarioTypesEnabled()
	else
	SetTimecycleModifier("spectator9")
	SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
	Citizen.Wait(60000)
	ClearTimecycleModifier()
	SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
	ResetScenarioTypesEnabled()
	end
end)

-- lsd Effect
RegisterNetEvent('esx_drugs:onLSD')
AddEventHandler('esx_drugs:onLSD', function()


local playerPed = PlayerPedId()
	
	if IsPedOnFoot(playerPed) then
        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
            AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.54, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

            ESX.Streaming.RequestAnimDict('move_p_m_two_idles@generic', function()
                TaskPlayAnim(playerPed, 'move_p_m_two_idles@generic', 'pill_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
                Citizen.Wait(3000)
                ClearPedSecondaryTask(playerPed)

            end)
        end)

    ClearPedTasksImmediately(GetPlayerPed(-1))
    SetTimecycleModifier("ufo_deathray")
    SetRunSprintMultiplierForPlayer(PlayerId(),1.00)
    Citizen.Wait(120000)
    ClearTimecycleModifier()
    SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
    ResetScenarioTypesEnabled()
	else
    SetTimecycleModifier("ufo_deathray")
    SetRunSprintMultiplierForPlayer(PlayerId(),1.00)
    Citizen.Wait(120000)
    ClearTimecycleModifier()
    SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
    ResetScenarioTypesEnabled()
	end

end)
RegisterNetEvent('esx_drugs:onPCP')
AddEventHandler('esx_drugs:onPCP', function()

local playerPed = PlayerPedId()
	
	if IsPedOnFoot(playerPed) then
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(5000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator9")
	SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
	Citizen.Wait(8000)
	ClearTimecycleModifier()
	SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
	ResetScenarioTypesEnabled()
	else
	SetTimecycleModifier("spectator9")
	SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
	Citizen.Wait(8000)
	ClearTimecycleModifier()
	SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
	ResetScenarioTypesEnabled()
	end
end)


-- Opium Effect
RegisterNetEvent('esx_drugs:onOpium')
AddEventHandler('esx_drugs:onOpium', function()

local playerPed = PlayerPedId()
	
	if IsPedOnFoot(playerPed) then
	RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_CLUBHOUSE", 0, true)
	Citizen.Wait(5000)	
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator7")--1-10
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(6000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(7000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(8000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(9000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(10000)
	DoScreenFadeIn(1000)
	Citizen.Wait(30000)
	DoScreenFadeOut(1000)
	Citizen.Wait(3000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(10000)
	DoScreenFadeIn(1000)
	Citizen.Wait(50000)
	DoScreenFadeOut(1000)
	Citizen.Wait(2000)
	DoScreenFadeIn(1000)
	Citizen.Wait(15000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	else
		SetTimecycleModifier("spectator7")--1-10
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(6000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(7000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(8000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(9000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(10000)
	DoScreenFadeIn(1000)
	Citizen.Wait(30000)
	DoScreenFadeOut(1000)
	Citizen.Wait(3000)
	DoScreenFadeIn(1000)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(10000)
	DoScreenFadeIn(1000)
	Citizen.Wait(50000)
	DoScreenFadeOut(1000)
	Citizen.Wait(2000)
	DoScreenFadeIn(1000)
	Citizen.Wait(15000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
	end
end)

--BOOZE EFFECTS--
-----------------

RegisterNetEvent('esx_drugs:onLargeBottle')
AddEventHandler('esx_drugs:onLargeBottle', function(prop_name)

local playerPed = PlayerPedId()
	
	if IsPedOnFoot(playerPed) then
if not IsAnimated then
		prop_name = prop_name or 'prop_vodka_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.06, -0.35, 0.09, 280.0, 175.0, 10.0, true, true, false, true, 1, true)
			--AttachEntityToEntity(prop, playerPed, boneIndex, 0.1, 0.028, .31, 10.0, 180.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)

			Citizen.Wait(0)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetTimecycleModifier("Drunk")
			--SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
			Citizen.Wait(25000)
			ClearTimecycleModifier()
			--SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
			ResetScenarioTypesEnabled()
		end)

	end
	else
			SetTimecycleModifier("Drunk")
			--SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
			Citizen.Wait(25000)
			ClearTimecycleModifier()
			--SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
			ResetScenarioTypesEnabled()
	end
end)

RegisterNetEvent('esx_drugs:onSmallBottle')
AddEventHandler('esx_drugs:onSmallBottle', function(prop_name)

local playerPed = PlayerPedId()
	
	if IsPedOnFoot(playerPed) then
if not IsAnimated then
		prop_name = prop_name or 'prop_vodka_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.01, 0.001, 280.0, 175.0, 10.0, true, true, false, true, 1, true)
			--AttachEntityToEntity(prop, playerPed, boneIndex, 0.1, 0.028, .31, 10.0, 180.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)

			Citizen.Wait(0)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetTimecycleModifier("Drunk")
			--SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
			Citizen.Wait(25000)
			ClearTimecycleModifier()
			--SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
			ResetScenarioTypesEnabled()
		end)

	end
	else
				SetTimecycleModifier("Drunk")
			--SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
			Citizen.Wait(25000)
			ClearTimecycleModifier()
			--SetRunSprintMultiplierForPlayer(PlayerId(),1.01)
			ResetScenarioTypesEnabled()
	end
end)


-- Render markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end

	end
end)

if Config.ShowBlips then
	-- Create blips
	Citizen.CreateThread(function()
		for k,v in pairs(Config.Blips) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)

			SetBlipSprite (blip, v.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.9)
			SetBlipColour (blip, v.color)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.name)
			EndTextCommandSetBlipName(blip)
		end
	end)
end


-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('esx_drugs:ReturnInventory')
AddEventHandler('esx_drugs:ReturnInventory', function(cokeNbr, cokepNbr, methNbr, methpNbr, weedNbr, weedpNbr, opiumNbr, opiumpNbr, lsdNbr, lsdpNbr, pcpNbr, pcppNbr, jobName, currentZone)
	cokeQTE	   = cokeNbr
	coke_poochQTE = cokepNbr
	methQTE 	  = methNbr
	meth_poochQTE = methpNbr
	weedQTE 	  = weedNbr
	weed_poochQTE = weedpNbr
	opiumQTE	   = opiumNbr
	opium_poochQTE = opiumpNbr
	lsdQTE	   = lsdNbr
	lsd_poochQTE = lsdpNbr
	pcpQTE	   = pcpNbr
	pcp_poochQTE = pcppNbr
	myJob		 = jobName
	print(currentZone)
	TriggerEvent('esx_drugs:hasEnteredMarker', currentZone)
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 2) then
				isInMarker  = true
				currentZone = k
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerServerEvent('esx_drugs:GetUserInventory', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_drugs:hasExitedMarker', lastZone)
		end

		if isInMarker and isInZone then
			TriggerEvent('esx_drugs:hasEnteredMarker', 'exitMarker')
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, Keys['E']) then
				isInZone = true -- unless we set this boolean to false, we will always freeze the user
				if CurrentAction == 'exitMarker' then
					isInZone = false -- do not freeze user
					TriggerEvent('esx_drugs:freezePlayer', false)
					TriggerEvent('esx_drugs:hasExitedMarker', lastZone)
					Citizen.Wait(15000)
				elseif CurrentAction == 'CokeField' then
					TriggerServerEvent('esx_drugs:startHarvestCoke')
				elseif CurrentAction == 'CokeProcessing' then
					TriggerServerEvent('esx_drugs:startTransformCoke')
				elseif CurrentAction == 'CokeDealer' then
					TriggerServerEvent('esx_drugs:startSellCoke')
				elseif CurrentAction == 'MethField' then
					TriggerServerEvent('esx_drugs:startHarvestMeth')
				elseif CurrentAction == 'MethProcessing' then
					TriggerServerEvent('esx_drugs:startTransformMeth')
				elseif CurrentAction == 'MethDealer' then
					TriggerServerEvent('esx_drugs:startSellMeth')
				elseif CurrentAction == 'WeedField' then
					TriggerServerEvent('esx_drugs:startHarvestWeed')
				elseif CurrentAction == 'WeedProcessing' then
					TriggerServerEvent('esx_drugs:startTransformWeed')
				elseif CurrentAction == 'WeedDealer' then
					TriggerServerEvent('esx_drugs:startSellWeed')
				elseif CurrentAction == 'OpiumField' then
					TriggerServerEvent('esx_drugs:startHarvestOpium')
				elseif CurrentAction == 'OpiumProcessing' then
					TriggerServerEvent('esx_drugs:startTransformOpium')
				elseif CurrentAction == 'OpiumDealer' then
					TriggerServerEvent('esx_drugs:startSellOpium')
				elseif CurrentAction == 'LSDField' then
					TriggerServerEvent('esx_drugs:startHarvestLSD')
				elseif CurrentAction == 'LSDProcessing' then
					TriggerServerEvent('esx_drugs:startTransformLSD')
				elseif CurrentAction == 'LSDDealer' then
					TriggerServerEvent('esx_drugs:startSellLSD')
				elseif CurrentAction == 'PCPField' then
					TriggerServerEvent('esx_drugs:startHarvestPCP')
				elseif CurrentAction == 'PCPProcessing' then
					TriggerServerEvent('esx_drugs:startTransformPCP')
				elseif CurrentAction == 'PCPDealer' then
					TriggerServerEvent('esx_drugs:startSellPCP')
				else
					isInZone = false -- not a esx_drugs zone
				end
				
				if isInZone then
					TriggerEvent('esx_drugs:freezePlayer', true)
				end
				
				CurrentAction = nil
			end
		end
	end
end)

RegisterNetEvent('esx_drugs:freezePlayer')
AddEventHandler('esx_drugs:freezePlayer', function(freeze)
	FreezeEntityPosition(GetPlayerPed(-1), freeze)
end)
