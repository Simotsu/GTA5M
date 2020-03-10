-------------------------------------------------
------------Bobby O'Shea Character Menu-----------
-------------------------------------------------
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
local menuHelper = {}
local id = {}
local DragStatus = {}
DragStatus.IsDragged = false
local ZiptieTimer = {}
local ziptieCheck = false
local closestPlayer, closestDistance
local debug = false
local IsZipTied = false
local number = {}
local savedVehicle = 0
local isDead = false
local inAnim = false
local name
local value = ""
ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
  while ESX.GetPlayerData().job == nil do
    Citizen.Wait(10)
end
ESX.PlayerData = ESX.GetPlayerData()
end)


AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)


-------------------------------------------------------------------
------------------------chat command /crime------------------------
-------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustReleased(0, 166) then
			openPersonalMenu()
		end
	end
end)


function openPersonalMenu()
    ESX.UI.Menu.CloseAll()
-------------------------------------------------------------------
------------------------   Open Main Menu   -----------------------
-------------------------------------------------------------------
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'character_menu',
		{
		title    = '👱‍👩Character Menu👩👱‍',
		align    = 'bottom-right',
		elements = {
			{label = 'Personal Menu | 👩‍💼 👨‍💼', value = 'personal'},
			{label = 'Criminal Menu | 💊 💵', value = 'charMenu'},
			{label = 'Animation List | 💃 🕺', value = 'animations'},
			{label = 'Report an Incident | 👩🏼‍💻 👨🏼‍💻', value = 'report'},	
		},
	}, function(data, menu)
		if data.current.value == 'charMenu' then
-------------------------------------------------------------------
------------------------   Open Criminal Menu   -------------------
-------------------------------------------------------------------
			closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'criminal_menu',
        		{
        			title    = '💰💣🔪Criminal Menu🔪💣💰',
        			align    = 'bottom-right',
        			elements = {
            			{label = 'Ziptie', value = 'ziptie'},
            			{label = 'Un-Ziptie', value = 'unziptie'},
            			{label = 'Drag', value = 'drag'},
            			{label = 'Put In Vehicle', value = 'put_in_vehicle'},
            			{label = 'Take Out Of Vehicle', value = 'take_from_vehicle'},           
        					   },
				}, function(data2, menu2)
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						if data2.current.value == 'ziptie' then
                    		ziptieCheck = true
                    		local target = ESX.Game.GetClosestPlayer()
                    		playerheading = GetEntityHeading(GetPlayerPed(-1))
                    		playerlocation = GetEntityForwardVector(PlayerPedId())
                    		playerCoords = GetEntityCoords(GetPlayerPed(-1))
                    		local target_id = GetPlayerServerId(target)
                    		TriggerServerEvent('charMenu:requestarrest', target_id, playerheading, playerCoords, playerlocation)
							TriggerEvent("mythic_progbar:client:progress", {
								name = "arrest_player",
								duration = 5000,
								label = "You're using zipties!",
								useWhileDead = false,
								canCancel = true,
								controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
								},
							}, function(status)
								if not status then
									-- Do Something If Event Wasn't Cancelled
								end
							end)

                		elseif data2.current.value == 'unziptie' then
                    		if ziptieCheck == true then
                        		local target = ESX.Game.GetClosestPlayer()
                        		playerheading = GetEntityHeading(GetPlayerPed(-1))
                        		playerlocation = GetEntityForwardVector(PlayerPedId())
                        		playerCoords = GetEntityCoords(GetPlayerPed(-1))
                        		local target_id = GetPlayerServerId(target)
                        		TriggerServerEvent('charMenu:requestrelease', target_id, playerheading, playerCoords, playerlocation)
								ziptieCheck = false
								TriggerEvent("mythic_progbar:client:progress", {
									name = "unrestrain_player1",
									duration = 5000,
									label = "You're releasing the player!",
									useWhileDead = false,
									canCancel = true,
									controlDisables = {
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								},
						}, function(status)
							if not status then
								-- Do Something If Event Wasn't Cancelled
							end
						end)
                    		else
                        	ESX.ShowNotification('This Player Is Is Not Zip Tied!!')
                    		end
                		elseif data2.current.value == 'drag' then
                    		TriggerServerEvent('charMenu:drag', GetPlayerServerId(closestPlayer))
                		elseif data2.current.value == 'put_in_vehicle' then
                    		TriggerServerEvent('charMenu:putInVehicle', GetPlayerServerId(closestPlayer))
                		elseif data2.current.value == 'take_from_vehicle' then
                    		TriggerServerEvent('charMenu:outVehicle', GetPlayerServerId(closestPlayer))
                		end
            		else
                		ESX.ShowNotification('No Players Nearby!')
					end
				end,
				function(data2, menu2)
					menu2.close()
					end)
-------------------------------------------------------------------
--------------------------OPEN PERSONAL MENU-----------------------
-------------------------------------------------------------------
		elseif data.current.value == 'personal' then
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personal_menu',
			{
			title    = '👩‍💼 👨‍💼Personal Menu👨‍💼 👩‍💼',
			align    = 'bottom-right',
			elements = {
				{label = 'Clothing Options', value = 'clothingoptions'},
				{label = 'Keychains', value = 'keychains'},
				{label = 'My Bills', value = 'mybills'},
				{label = 'Show ID To Player', value = 'showid'},
				{label = 'View ID', value = 'viewid'},
				{label = 'Share Phone Number', value = 'sharephone'},
				},
			}, function(data2, menu2)
				--insert here
					if  data2.current.value == 'clothingoptions' then
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory',
							{
								title = '👓🎩Clothing Options🎩👓',
								align = 'bottom-right',
								elements = {
									{label = 'Hats/Helmets', value = 'Helmet'},
									{label = 'Ears', value = 'Ears'},
									{label = 'Mask', value = 'Mask'},
									{label = 'Glasses', value = 'Glasses'}
								}
							}, function(data3, menu3)
								menu3.close()
								SetUnsetAccessory(data3.current.value)
							end, function(data3, menu3)
								menu3.close()
							end)
					elseif data2.current.value == 'keychains' then
					TriggerServerEvent('charMenu:getKeys')
					Citizen.Wait(300)
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'keychain',
						{
							title    = '🔑 🚗Key Chains🚗 🔑',
							align    = 'bottom-right',
							elements = menuHelper
						}, function(data3, menu3)
							--INSERT HERE
							value = data3.current.value
								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehopts',
									{
										title    = '🚗 🔑Vehicle Options🔑 🚗',
										align    = 'bottom-right',
										elements = {
											{label = 'Give Keys to Nearest Player', value = 'givekeys'},
											},
									}, function(data4, menu4)								
											if data4.current.value == 'givekeys' then
												local player, distance = ESX.Game.GetClosestPlayer()
												player = GetPlayerServerId(player)
												if distance ~= -1 and distance <= 3.0 then
													TriggerServerEvent('charMenu:giveKeys', value, player)
													ESX.ShowNotification('You Hand Over Your Keys.')
												else
													ESX.ShowNotification('No Player\'s Nearby')
												end
											end
									end,
									function(data4, menu4)
										menu4.close()
									end)
							--end here
						end,
						function(data3, menu3)
							menu3.close()
						end)
				elseif data2.current.value == 'mybills' then
					ShowBillsMenu()
				elseif data2.current.value == 'showid' then
					local player, distance = ESX.Game.GetClosestPlayer()
					if distance ~= -1 and distance <= 3.0 then
  						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
					else
  						ESX.ShowNotification('No players nearby')
					end
				elseif data2.current.value == 'viewid' then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
				elseif data2.current.value == 'sharephone' then
					local player, distance = ESX.Game.GetClosestPlayer()				
					if player ~= -1 and distance <= 3.0 then
						TriggerServerEvent('charMenu:getPhone')
					else
						--TriggerServerEvent('charMenu:getPhone')
					end
				end
			end,
			function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'animations' then
				OpenAnimationsMenu()
		elseif data.current.value == 'report' then
			--do this
			--need to change this number if we go over 45 players-------------------------------------------------------------------
			for a = 45, 1, -1 do
				if GetPlayerFromServerId(a) ~= -1 then
					TriggerServerEvent('charMenu:getID', a)
				end	
			end
			Citizen.Wait(2000)
			local char
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'report_names',
			{
				title    = '💩 🤡Report A Player🤡 💩',
				align    = 'bottom-right',
				elements = id
			}, function(data2, menu2)
				char = data2.current.value
				print(char)
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'report',
    			{
        			title = ('Short description of problem')
    			}, function(data3, menu3)
					
					--print(data3.current.value..": fired insde")
					--TriggerEvent('DiscordBot:ToDiscord', 'chat', steam,'******' ..name..'" "'..message, 'logoimageurl', true)
        			if amount == nil then
            			ESX.ShowNotification('Invalid Entry')
					else
						TriggerEvent('DiscordBot:ToDiscord', 'chat', steam,'***TEST***' ..name..'" "'..message, 'logoimageurl', true)
            			menu3.close()
        			end
    			end, function(data3, menu3)
        			menu3.close()
				end)
			end, function(data2, menu2)
			menu2.close()
			end)
		end
	end,function(data, menu)
		menu.close()
	end)
end


-------------------------------------------------------------------
------------------------------DRAG---------------------------------
-------------------------------------------------------------------
RegisterNetEvent('charMenu:drag')
AddEventHandler('charMenu:drag', function(copID)
	if not IsZipTied then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsZipTied then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


-------------------------------------------------------------------
---------------------------PUT IN VEHICLE--------------------------
-------------------------------------------------------------------
RegisterNetEvent('charMenu:putInVehicle')
AddEventHandler('charMenu:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if not IsZipTied then
		return
	end

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end
		end
	end
end)


-------------------------------------------------------------------
-------------------------TAKE FROM VEHICLE-------------------------
-------------------------------------------------------------------
RegisterNetEvent('charMenu:outVehicle')
AddEventHandler('charMenu:outVehicle', function()
    local playerPed = PlayerPedId()

    if not IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    local vehicle = GetVehiclePedIsIn(playerPed, false)
    TaskLeaveVehicle(playerPed, vehicle, 16)

    Citizen.Wait(500)
    ClearPedTasksImmediately(playerPed)
end)


-------------------------------------------------------------------
-----------------------------WAIT TIMER----------------------------
-------------------------------------------------------------------




-------------------------------------------------------------------
--------------------------ZIPTIE(Handcuff)-------------------------
-------------------------------------------------------------------
RegisterNetEvent('charMenu:ziptie')
AddEventHandler('charMenu:ziptie', function()
    --IsZipTied    = not IsZipTied    
	local playerPed = PlayerPedId()
	Citizen.CreateThread(function()
		TriggerEvent("mythic_progbar:client:progress", {
			name = "ziptie_player1",
			duration = 5000,
			label = "You're being ziptied!",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = false,
			},
		}, function(status)
			if not status then
				-- Do Something If Event Wasn't Cancelled
			end
		end)
        if IsZipTied then
			if Config.EnableZiptieTimer then

				if ZiptieTimer.Active then
					ESX.ClearTimeout(ZiptieTimer.Task)
				end

				StartZiptieTimer()
			end

		else

			if Config.EnableZiptieTimer and ZiptieTimer.Active then
				ESX.ClearTimeout(ZiptieTimer.Task)
			end

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
            DisplayRadar(true)

		end
	end)

end)


-------------------------------------------------------------------
------------------------------UNZIPTIE-----------------------------
-------------------------------------------------------------------
RegisterNetEvent('charMenu:unrestrain')
AddEventHandler('charMenu:unrestrain', function()
	TriggerEvent("mythic_progbar:client:progress", {
		name = "unrestrain_player1",
		duration = 5000,
		label = "You're being released!",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = false,
		},
	}, 
	function(status)
		if not status then
			-- Do Something If Event Wasn't Cancelled
		end
	end)
	if IsZipTied then
		local playerPed = PlayerPedId()
		IsZipTied = false
		if Config.EnableZiptieTimer and ZiptieTimer.Active then
			ESX.ClearTimeout(ZiptieTimer.Task)
		end
	end
end)

-------------------------------------------------------------------
------------------------------SET KEYS-----------------------------
-------------------------------------------------------------------

RegisterNetEvent('charMenu:setKeys')
AddEventHandler('charMenu:setKeys', function(plate)
    table.insert(menuHelper, {label = plate, value = plate})
end)

-------------------------------------------------------------------
------------------------------SET NUMBER---------------------------
-------------------------------------------------------------------

RegisterNetEvent('charMenu:setNumber')
AddEventHandler('charMenu:setNumber', function(num)
	print(player)
	TriggerEvent('esx_rpchat:sendProximityMessage', player, "Phone Number:", " "..num,{255, 0, 0})
	--TriggerEvent('esx_rpchat:sendProximityMessage', 10, "Phone Number: ", " "..num,{255, 0, 0})
end)

-------------------------------------------------------------------
------------------------------SET NAME-----------------------------
-------------------------------------------------------------------

RegisterNetEvent('charMenu:setName')
AddEventHandler('charMenu:setName', function(charName, num)
name = charName
table.insert(id, {label = "Steam: "..GetPlayerName(GetPlayerFromServerId(num)).."  || Char: "..name, value = GetPlayerName(GetPlayerFromServerId(num)).." "..name})
end)


-------------------------------------------------------------------
----------------------------DO SEARCHING---------------------------
-------------------------------------------------------------------

RegisterNetEvent('charMenu:dosearching')
AddEventHandler('charMenu:dosearching', function()
	Citizen.Wait(250)
	loadanimdict('creatures@rottweiler@tricks@')
	TaskPlayAnim(GetPlayerPed(-1), 'creatures@rottweiler@tricks@', 'petting_franklin', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

-------------------------------------------------------------------
------------------------ANIMATION TESTING--------------------------
-------------------------------------------------------------------
RegisterNetEvent('charMenu:getarrested')
AddEventHandler('charMenu:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	IsZipTied = true
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('charMenu:doarrested')
AddEventHandler('charMenu:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)

end) 

RegisterNetEvent('charMenu:douncuffing')
AddEventHandler('charMenu:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('charMenu:getuncuffed')
AddEventHandler('charMenu:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsZipTied = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('charMenu:getsearched')
AddEventHandler('charMenu:getsearched', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('anim@heists@prison_heiststation@cop_reactions')
	TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@prison_heiststation@cop_reactions', 'cop_a_reaction', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	--loadanimdict('mp_arresting')
	--TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('charMenu:dosearching')
AddEventHandler('charMenu:dosearching', function()
	Citizen.Wait(250)
	loadanimdict('creatures@rottweiler@tricks@')
	TaskPlayAnim(GetPlayerPed(-1), 'creatures@rottweiler@tricks@', 'petting_franklin', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

-------------------------------------------------------------------
---------------------------FUNCTIONS-------------------------------
-------------------------------------------------------------------

-------------------------------------------------------------------
------------------------ANIMATION MENU-----------------------------
-------------------------------------------------------------------
function OpenAnimationsMenu()				
	local elements = {}			
	table.insert(elements, {
		label = "Stop Animation",
		type = "stopanim",
		value = "stopanim"
	})
	for i=1, #Config.Animations, 1 do
		table.insert(elements, {label = Config.Animations[i].label, value = Config.Animations[i].name})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animations',
	{
		title    = '🕺 💃Animations💃 🕺',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
	if data.current.type == 'stopanim' then
		ClearPedTasksImmediately(GetPlayerPed(-1))
		ClearPedTasks(GetPlayerPed(-1))
		ClearPedSecondaryTask(GetPlayerPed(-1))
	else
		OpenAnimationsSubMenu(data.current.value)
	end
	end, function(data, menu)
		menu.close()
	end)
end
-------------------------------------------------------------------
------------------------ANIMATION SUBMENU--------------------------
-------------------------------------------------------------------

function OpenAnimationsSubMenu(menu)
	local title    = nil
	local elements = {}

	for i=1, #Config.Animations, 1 do
		if Config.Animations[i].name == menu then
			title = Config.Animations[i].label
			for j=1, #Config.Animations[i].items, 1 do
				table.insert(elements, {
					label = Config.Animations[i].items[j].label,
					type  = Config.Animations[i].items[j].type,
					value = Config.Animations[i].items[j].data
				})
			end

			break

		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animations_sub',
	{
		title    = title,
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		local type = data.current.type
		local lib  = data.current.value.lib
		local anim = data.current.value.anim

		if type == 'scenario' then
			startScenario(anim)
		elseif type == 'attitude' then
			startAttitude(lib, anim)
		elseif type == 'anim' then
			startAnim(lib, anim)
		end
	end, function(data, menu)
		menu.close()
	end)
end

-------------------------------------------------------------------
------------------------Show Bills Menu----------------------------
-------------------------------------------------------------------
function ShowBillsMenu()
	ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
		ESX.UI.Menu.CloseAll()
			local elements = {}

		for i=1, #bills, 1 do
			table.insert(elements, {label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>', value = bills[i].id})
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'billing',
			{
				title    = '📜 💸My Invoices💸 📜',
				align    = 'bottom-right',
				elements = elements
			},
			function(data3, menu3)
				local billId = data3.current.value
				ESX.TriggerServerCallback('esx_billing:payBill', function()
					ShowBillsMenu()
				end, billId)
			end,
			function(data3, menu3)
				menu3.close()
			end
		)
	end)
end

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end
-------------------------------------------------------------------
---------------------------HANDCUFF TIMER--------------------------
-------------------------------------------------------------------
function StartZiptieTimer()
	if Config.EnableZiptieTimer and ZiptieTimer.Active then
		ESX.ClearTimeout(ZiptieTimer.Task)
	end

	ZiptieTimer.Active = true

	ZiptieTimer.Task = ESX.SetTimeout(Config.ZiptieTimer, function()
		TriggerEvent('charMenu:unrestrain')
		ZiptieTimer.Active = false
	end)
end

-------------------------------------------------------------------
---------------------------Accessories-----------------------------
-------------------------------------------------------------------
function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == "mask" then
					mAccessory = 0
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			ESX.ShowNotification('No ' .. _accessory)
		end

	end, accessory)
end
-------------------------------------------------------------------
---------------------------ANIMATIONS------------------------------
-------------------------------------------------------------------
function startAttitude(lib, anim)
	ESX.Streaming.RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end

function startScenario(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end


-------------------------------------------------------------------
---------------------------HANDCUFF HELPER-------------------------
-------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsZipTied then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, Keys['L'], true) -- Disable L to lock vehicle while in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)