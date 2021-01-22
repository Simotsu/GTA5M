-------- MADE BY AMMAR B.-------
------ Improved By O'Shea ------
--------------------------------

--------------------------------------------------
----------------STOPS AUTO RESPAWN----------------
--------------------------------------------------

AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer()
	Citizen.Wait(3000)
	exports.spawnmanager:setAutoSpawn(false)
	TriggerServerEvent('DeathScriptAdminCheck')
	TriggerServerEvent('DeathScriptESCheck')
end)

--------------------------------------------------
----------------REGISTERING EVENTS----------------
--------------------------------------------------

RegisterNetEvent("DeathScript:Revive")
RegisterNetEvent("DeathScript:Respawn")
RegisterNetEvent("DeathScript:AdminRevive")
RegisterNetEvent("DeathScript:AdminRespawn")
RegisterNetEvent("DeathScript:SetReviveTime")
RegisterNetEvent("DeathScript:SetRespawnTime")
RegisterNetEvent("DeathScript:Toggle")
RegisterNetEvent("DeathScript:ShowNotification")
RegisterNetEvent("DeathScript:IsPlayerDead")
RegisterNetEvent("DeathScript:AdminCheckClient")
RegisterNetEvent("DeathScript:ModCheckClient")


--------------------------------------------------
----------------DEFINING VARIABLES----------------
--------------------------------------------------
local setRagdoll = false
local pedDied = true
local OriginalReviveTime = 120
local OriginalRespawnTime = 60
local ReviveTime = 120
local RespawnTime = 60
local ReviveAllowed = false
local RespawnAllowed = false
local DeathTime = nil
local DeathScriptToggle = true
local respawnCount = 0
local spawnPoints = {}

--------------------------------------------------
--------------------Ragdoll Loop--------------------
--------------------------------------------------

Citizen.CreateThread(function()
	while true do
	   Citizen.Wait(10)
	   if setRagdoll then
		 SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	   end
	 end
   end)
   
--------------------------------------------------
--------------------Death Loop--------------------
--------------------------------------------------

Citizen.CreateThread(function()

    function createSpawnPoint(x1,x2,y1,y2,z,heading) -- setting spawn point
		local xValue = math.random(x1,x2) + 0.0001
		local yValue = math.random(y1,y2) + 0.0001

		local newObject = {
			x = xValue,
			y = yValue,
			z = z + 0.0001,
			heading = heading + 0.0001
		}
		table.insert(spawnPoints,newObject)
	end

	createSpawnPoint(-448, -448, -340, -329, 35.5, 0)    -- Mount Zonah
	createSpawnPoint(372, 375, -596, -594, 30.0, 0)      -- Pillbox Hill
	createSpawnPoint(335, 340, -1400, -1390, 34.0, 0)    -- Central Los Santos
	createSpawnPoint(1850, 1854, 3700, 3704, 35.0, 0)    -- Sandy Shores
	createSpawnPoint(-247, -245, 6328, 6332, 33.5, 0)    -- Paleto

    while true do
        Citizen.Wait(8000)-- 7 second tick 
		local ped = PlayerPedId() -- get pedID
		if IsEntityDead( ped ) then -- check if ped is dead using native
			if DeathScriptToggle then --if deathscript is on
                DeathTime = GetGameTimer() --set death timer to game timer
				--print(setRagdoll) 	--testing

				
				local reviveMessage = nil --set message to blank
				local respawnMessage = nil --set message to blank

				if ReviveTime >= 11 then --if revive time is greater than 0 
					ReviveTime = ReviveTime - 10 --deduct 5s from timer
					reviveMessage = '~r~Revive in ' .. ReviveTime .. ' seconds' --set new message with new time
				elseif ReviveTime < 11 or ReviveTime <= 10 then  
					ReviveAllowed = true --player can revive
					reviveMessage = '~g~Revive available | /revive' --set message to display respawn command
				end

				if RespawnTime >= 11 then --if respawn time is greater than 0
					RespawnTime = RespawnTime - 10 --deduct 5s from timer
					respawnMessage = '~r~Respawn in ' .. RespawnTime .. ' seconds' --set new message with new time
				elseif RespawnTime < 11 or RespawnTime <= 10 then 
					RespawnAllowed = true --player can revive
					respawnMessage = '~g~Respawn available | /respawn' --set message to display respawn command
				end

				if IsPedOnFoot(PlayerPedId()) and pedDied then --if player is on foot and has died
					revivePed( ped ) --ressurect ped
				--	NetworkResurrectLocalPlayer(GetEntityCoords(ped, true), true, true, false)
					setRagdoll = true --turn on ragdoll
					SetEntityHealth( ped, 0 )
				end
				Wait(1000)
				if pedDied then
					pedDied = false
					setRagdoll = false
				end
				ShowNotification(  respawnMessage .. '\n' .. reviveMessage )
                SetPlayerInvincible( ped, true )
				SetEntityHealth( ped, 1 )
			else 
				setRagdoll = false
				respawnPed( ped, spawnPoints[math.random(1,#spawnPoints)]  )
				pedDied = true
				setRagdoll = false
			end	
		end
	end
end)


--------------------------------------------------
-----------------EVENT  HANDLERS------------------
--------------------------------------------------

AddEventHandler("DeathScript:Revive", function( adrev, admin, all)
	
	local ped = PlayerPedId()
	if adrev then ReviveAllowed = true end
	if all then
		revivePed( ped )
		resetTimers()
		ShowNotification("~g~You have been revived by an admin!")
		return;
	end
	if GetEntityHealth( ped ) <= 1 then --if you are dead
		if ReviveAllowed then -- if timer is complete allow revive --
			pedDied = true
			setRagdoll = false
			revivePed( ped )
			resetTimers()
			if adrev then
				ShowNotification("~g~You have been revived by an admin!")
				TriggerServerEvent('DeathScript:AdminReturn', '~g~Player has been revived', admin)
			end
		else
			ShowNotification("~r~" .. ReviveTime .. ' seconds remaining until revive!')
		end
	else
		if adrev then
			TriggerServerEvent('DeathScript:AdminReturn', '~r~Player is alive', admin)
		else
			ShowNotification("~g~You're alive!")
		end
	end
end)

AddEventHandler("DeathScript:Respawn", function( adres, admin, all)
	local ped = PlayerPedId()
	if adres then RespawnAllowed = true end
	if all then
		respawnPed( ped, spawnPoints[math.random(1,#spawnPoints)] )
		resetTimers()
		ShowNotification("~g~You have been respawned by an admin!")
		return;
	end
	if GetEntityHealth( ped ) <= 1 then --if you are dead
		if RespawnAllowed then -- if timer is complete allow revive --
			pedDied = true
			setRagdoll = false
			respawnPed( ped, spawnPoints[math.random(1,#spawnPoints)] )
			resetTimers()
			if adres then
				ShowNotification("~g~You have been respawned by an admin!")
				TriggerServerEvent('DeathScript:AdminReturn', '~g~Player has been respawned', admin)
			end
		else
			ShowNotification("~r~" .. RespawnTime .. ' seconds remaining until respawn!')
		end
	else
		if adres then
			TriggerServerEvent('DeathScript:AdminReturn', '~r~Player is alive', admin)
		else
			ShowNotification("~g~You're alive!")
		end
	end
end)

AddEventHandler('DeathScript:Toggle', function()
	DeathScriptToggle = not DeathScriptToggle
	if (DeathScriptToggle) then
		ShowNotification("~b~DeathScript was enabled")
	else
		ShowNotification("~r~DeathScript was disabled")
	end
end)

AddEventHandler('DeathScript:ShowNotification', function( str )
	ShowNotification( str )
end)

--------------------------------------------------
--------------------FUNCTIONS---------------------
--------------------------------------------------

function resetTimers()
	ReviveTime = OriginalReviveTime
	RespawnTime = OriginalRespawnTime
	ReviveAllowed = false
	RespawnAllowed = false
end



exports("DSRev",function(target, adrev, admin, all)
	ExecuteCommand('emsrev ' .. target)
	end)