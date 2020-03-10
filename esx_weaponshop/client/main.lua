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

ESX = nil
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local ShopOpen = false
local tier = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


--License Menu
function OpenBuyLicenseMenu(zone)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license', {
		title = "Buy a Weapon License",
		align = 'top-left',
		elements = {
			{ label = "Permit to Carry Class: I", value = 'class1' },
			{ label = "Permit to Carry Class: II", value = 'class2' },
			{ label = "Permit to Carry Class: III", value = 'class3' },
		}
	}, function(data2, menu2)
		if data2.current.value == 'class1' then
			--Check to see if you own that license?
			ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
				if hasWeaponLicense then
					ESX.ShowNotification("You already own this license!")
				else
					menu2.close()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license1', {
				title = "Buy a Tier 1 Weapon License",
				align = 'top-left',
				elements = {
					{ label = _U('no'), value = 'no' },
					{ label = _U('yes', ('<span style="color: green;">%s</span>'):format((_U('shop_menu_item', ESX.Math.GroupDigits(Config.LicensePrice))))), value = 'yes' },
				}
			}, function(data3, menu3)
				if data3.current.value == 'yes' then
					--Debit or Cash??

					menu3.close()

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'debit_cash_payment', {
						title    = 'Select Payment Option',
						align    = 'top-left',
						elements = {
									{label = 'Debit', value = 'debit_card'},
									{label = 'Cash',  value = 'cash'},
						}
					}, function(data4, menu4)
						if data4.current.value == 'debit_card' then
							ESX.TriggerServerCallback('esx_weaponshop:buyLicenseBank', function(bought)
								if bought then
									ESX.ShowNotification("You have purchased a Tier 1 Weapon License using your Debit Card")
									menu3.close()
									Citizen.Wait(160)
									OpenShopMenu(zone)
								end
							end)
							menu4.close()
						elseif data4.current.value == 'cash' then
							ESX.TriggerServerCallback('esx_weaponshop:buyLicense', function(bought)
								if bought then
									ESX.ShowNotification("You have purchased a Tier 1 Weapon License")
									menu3.close()
									Citizen.Wait(160)
									OpenShopMenu(zone)
								end
							end)
							menu4.close()
						end
						menu4.close()
					end, function(data4, menu4)
					menu4.close()
					end)
					--end debit or cash
				end
			end, function(data3, menu3)
				menu.close()
			end)
				end
			end, GetPlayerServerId(PlayerId()), 'weapon_tier1')
			
		elseif data2.current.value == 'class2' then
			--Class 2
			ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
				if hasWeaponLicense then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
						if hasWeaponLicense then
							ESX.ShowNotification("You already own this license!")
						else
							menu2.close()
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license2', {
						title = "Buy a Tier 2 Weapon License",
						align = 'top-left',
						elements = {
							{ label = _U('no'), value = 'no' },
							{ label = _U('yes', ('<span style="color: green;">%s</span>'):format((_U('shop_menu_item', ESX.Math.GroupDigits(Config.LicensePrice2))))), value = 'yes' },
						}
					}, function(data3, menu3)
						if data3.current.value == 'yes' then
							--cash or debit

							menu3.close()

							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'debit_cash_payment', {
								title    = 'Select Payment Option',
								align    = 'top-left',
								elements = {
											{label = 'Debit', value = 'debit_card'},
											{label = 'Cash',  value = 'cash'},
								}
							}, function(data4, menu4)
								if data4.current.value == 'debit_card' then
									ESX.TriggerServerCallback('esx_weaponshop:buyLicense2Bank', function(bought)
										if bought then
											ESX.ShowNotification("You have purchased a Tier 2 Weapon License using your Debit Card")
											menu3.close()
											Citizen.Wait(160)
											OpenShopMenu(zone)
										end
									end)
									menu4.close()
								elseif data4.current.value == 'cash' then
									ESX.TriggerServerCallback('esx_weaponshop:buyLicense2', function(bought)
										if bought then
											ESX.ShowNotification("You have purchased a Tier 2 Weapon License")
											menu3.close()
											Citizen.Wait(160)
											OpenShopMenu(zone)
										end
									end)
									menu4.close()
								end
								menu4.close()
							end, function(data4, menu4)
							menu4.close()
							end)
						--endcash or debit
						end
					end, function(data3, menu3)
						menu3.close()
					end)
						end
					end, GetPlayerServerId(PlayerId()), 'weapon_tier2')
				else
					ESX.ShowNotification("You Must Own A Tier 1 Weapon License First!")
				end
			end, GetPlayerServerId(PlayerId()), 'weapon_tier1')
			

			
		elseif data2.current.value == 'class3' then

			ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
				if hasWeaponLicense then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
						if hasWeaponLicense then
							ESX.ShowNotification("You already own this license!")
						else
							menu2.close()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license3', {
				title = "Buy a Tier 3 Weapon License",
				align = 'top-left',
				elements = {
					{ label = _U('no'), value = 'no' },
					{ label = _U('yes', ('<span style="color: green;">%s</span>'):format((_U('shop_menu_item', ESX.Math.GroupDigits(Config.LicensePrice3))))), value = 'yes' },
				}
			}, function(data3, menu3)
				if data3.current.value == 'yes' then
					--cash or debit

					menu3.close()

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'debit_cash_payment', {
						title    = 'Select Payment Option',
						align    = 'top-left',
						elements = {
									{label = 'Debit', value = 'debit_card'},
									{label = 'Cash',  value = 'cash'},
						}
					}, function(data4, menu4)
						if data4.current.value == 'debit_card' then
							ESX.TriggerServerCallback('esx_weaponshop:buyLicense3Bank', function(bought)
								if bought then
									ESX.ShowNotification("You have purchased a Tier 3 Weapon License using your Debit Card")
									menu3.close()
									Citizen.Wait(160)
									OpenShopMenu(zone)
								end
							end)
							menu4.close()
						elseif data4.current.value == 'cash' then
							ESX.TriggerServerCallback('esx_weaponshop:buyLicense3', function(bought)
								if bought then
									ESX.ShowNotification("You have purchased a Tier 3 Weapon License")
									menu3.close()
									Citizen.Wait(160)
									OpenShopMenu(zone)
								end
							end)
							menu4.close()
						end
						menu4.close()
					end, function(data4, menu4)
					menu4.close()
					end)

					--END
					--end cash or debit
				end
			end, function(data3, menu3)
				menu3.close()
			end)	
						end
					end, GetPlayerServerId(PlayerId()), 'weapon_tier3')
				else
					ESX.ShowNotification("You Must Own A Tier 2 Weapon License First!")
				end
			end, GetPlayerServerId(PlayerId()), 'weapon_tier2')

						
		end
	end, function(data2, menu2)
		menu2.close()
	end)
	
end

--Legal Weapons Menu
function OpenShopMenu(zone)
	local elements = {}
	local buyAmmo = {}
	ShopOpen = true
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()

	if Config.LicenseEnable and Config.Zones[CurrentActionData.zone].Legal then

		ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
			if hasWeaponLicense then
				tier = 1
			end
		end, GetPlayerServerId(PlayerId()), 'weapon_tier1')
		Citizen.Wait(100)
		ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
			if hasWeaponLicense then
				tier = 2
			end
		end, GetPlayerServerId(PlayerId()), 'weapon_tier2')
		Citizen.Wait(100)
		ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
			if hasWeaponLicense then
			tier = 3
			end
		end, GetPlayerServerId(PlayerId()), 'weapon_tier3')
	end

	Citizen.Wait(1000)
	if tier == 0 then
		for k,v in ipairs(Config.Zones[zone].Items0) do
			local weaponNum, weapon = ESX.GetWeapon(v.weapon)
			local components, label = {}
			print(weapon.name)
			local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

			if v.components then
				for i=1, #v.components do
					if v.components[i] then

						local component = weapon.components[i]
						local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

						if hasComponent then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_owned'))
						else
							if v.components[i] > 0 then
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_item', ESX.Math.GroupDigits(v.components[i])))
							else
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_free'))
							end
						end

						table.insert(components, {
							label = label,
							componentLabel = component.label,
							hash = component.hash,
							name = component.name,
							price = v.components[i],
							hasComponent = hasComponent,
							componentNum = i
						})
					end
				end
				table.insert(components, {
					label = _U('buy_ammo')..'<span style="color:green;">'..ESX.Math.GroupDigits(v.ammoPrice)..' $ </span>',
					type = 'ammo',
					price = v.ammoPrice,
					weapon = weapon.name,
					ammoNumber = v.AmmoToGive
				})
			end

			if hasWeapon and v.components then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice ~= nil then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice  == nil then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_owned'))
			elseif v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_item', ESX.Math.GroupDigits(v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_free'))
			end
		
			if weapon ~= nil then
			table.insert(elements, {
				label = label,
				weaponLabel = weapon.label,
				name = weapon.name,
				components = components,
				price = v.price,
				ammoPrice = v.ammoPrice,
				ammoNumber = v.AmmoToGive,
				hasWeapon = hasWeapon
			})
			end
		end
	end
	if tier == 1 then
		for k,v in ipairs(Config.Zones[zone].Items1) do
			local weaponNum, weapon = ESX.GetWeapon(v.weapon)
			local components, label = {}
			local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

			if v.components then
				for i=1, #v.components do
					if v.components[i] then
						
						local component = weapon.components[i]
						local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)
						
						if hasComponent then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_owned'))
						else
							if v.components[i] > 0 then
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_item', ESX.Math.GroupDigits(v.components[i])))
							else
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_free'))
							end
						end

						table.insert(components, {
							label = label,
							componentLabel = component.label,
							hash = component.hash,
							name = component.name,
							price = v.components[i],
							hasComponent = hasComponent,
							componentNum = i
						})
					end
				end
				table.insert(components, {
					label = _U('buy_ammo')..'<span style="color:green;">'..ESX.Math.GroupDigits(v.ammoPrice)..' $ </span>',
					type = 'ammo',
					price = v.ammoPrice,
					weapon = weapon.name,
					ammoNumber = v.AmmoToGive
				})
			end

			if hasWeapon and v.components then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice ~= nil then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice  == nil then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_owned'))
			elseif v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_item', ESX.Math.GroupDigits(v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_free'))
			end
	
			if weapon ~= nil then
			table.insert(elements, {
				label = label,
				weaponLabel = weapon.label,
				name = weapon.name,
				components = components,
				price = v.price,
				ammoPrice = v.ammoPrice,
				ammoNumber = v.AmmoToGive,
				hasWeapon = hasWeapon
			})
			end
		end

	end
	if tier == 2 then
		for k,v in ipairs(Config.Zones[zone].Items2) do
			local weaponNum, weapon = ESX.GetWeapon(v.weapon)
			local components, label = {}
			local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

			if v.components then
				for i=1, #v.components do
					if v.components[i] then
						
						local component = weapon.components[i]
						local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

						if hasComponent then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_owned'))
						else
							if v.components[i] > 0 then
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_item', ESX.Math.GroupDigits(v.components[i])))
							else
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_free'))
							end
						end

						table.insert(components, {
							label = label,
							componentLabel = component.label,
							hash = component.hash,
							name = component.name,
							price = v.components[i],
							hasComponent = hasComponent,
							componentNum = i
						})
					end
				end
				table.insert(components, {
					label = _U('buy_ammo')..'<span style="color:green;">'..ESX.Math.GroupDigits(v.ammoPrice)..' $ </span>',
					type = 'ammo',
					price = v.ammoPrice,
					weapon = weapon.name,
					ammoNumber = v.AmmoToGive
				})
			end

			if hasWeapon and v.components then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice ~= nil then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice  == nil then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_owned'))
			elseif v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_item', ESX.Math.GroupDigits(v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_free'))
			end
		
		
			if weapon ~= nil then
			table.insert(elements, {
				label = label,
				weaponLabel = weapon.label,
				name = weapon.name,
				components = components,
				price = v.price,
				ammoPrice = v.ammoPrice,
				ammoNumber = v.AmmoToGive,
				hasWeapon = hasWeapon
			})
			end
		end
	end
	if tier == 3 then
		for k,v in ipairs(Config.Zones[zone].Items3) do
			local weaponNum, weapon = ESX.GetWeapon(v.weapon)
			local components, label = {}
			local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

			if v.components then
				for i=1, #v.components do
					if v.components[i] then

						local component = weapon.components[i]
						local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

						if hasComponent then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_owned'))
						else
							if v.components[i] > 0 then
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_item', ESX.Math.GroupDigits(v.components[i])))
							else
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_free'))
							end
						end

						table.insert(components, {
							label = label,
							componentLabel = component.label,
							hash = component.hash,
							name = component.name,
							price = v.components[i],
							hasComponent = hasComponent,
							componentNum = i
						})
					end
				end
				table.insert(components, {
					label = _U('buy_ammo')..'<span style="color:green;">'..ESX.Math.GroupDigits(v.ammoPrice)..' $ </span>',
					type = 'ammo',
					price = v.ammoPrice,
					weapon = weapon.name,
					ammoNumber = v.AmmoToGive
				})
			end
			if weapon ~= nil then
				if hasWeapon and v.components then
					label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
				elseif hasWeapon and not v.components and v.ammoPrice ~= nil then
					label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
				elseif hasWeapon and not v.components and v.ammoPrice  == nil then
					label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_owned'))
				elseif v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_item', ESX.Math.GroupDigits(v.price)))
				else
					label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_free'))
				end
			end
		
		
			if weapon ~= nil then
			table.insert(elements, {
				label = label,
				weaponLabel = weapon.label,
				name = weapon.name,
				components = components,
				price = v.price,
				ammoPrice = v.ammoPrice,
				ammoNumber = v.AmmoToGive,
				hasWeapon = hasWeapon
			})
			end
		end
	end

	Citizen.Wait(400)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mainmenu', {
		title = "AmmuNation Weapon Shop",
		align = 'top-left',
		elements = {
			{ label = _U('weapon_shop'), value = 'weaponShop' },
			{ label = _U('license_shop'), value = 'licenseShop' },
		}
	}, function(data, menu)
		if data.current.value == "weaponShop" then
			PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
			Citizen.Wait(500)
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weapons_sell', {
				title    = _U('gunshop_weapontitle'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
	
				if data2.current.hasWeapon then
					if #data2.current.components > 0 then
						OpenWeaponComponentShopMenu(data2.current.components, data2.current.name, menu2, zone)
					elseif data2.current.ammoPrice ~= nil then
	
						table.insert(buyAmmo, {
							label = _U('buy_ammo')..'<span style="color:green;">'..ESX.Math.GroupDigits(data2.current.ammoPrice)..' $ </span>',
							price = data2.current.ammoPrice,
							weapon = data2.current.name,
							ammoToBuy = data2.current.ammoNumber
						})
						print(ESX.DumpTable(buyAmmo))
						OpenAmmoShopMenu(buyAmmo,data2.current.name,menu2,zone)
					end
				
				else
					--debit or cash?
					menu2.close()

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'debit_cash_payment', {
						title    = 'Select Payment Option',
						align    = 'top-left',
						elements = {
									{label = 'Debit', value = 'debit_card'},
									{label = 'Cash',  value = 'cash'},
						}
					}, function(data3, menu3)
						if data3.current.value == 'debit_card' then
							ESX.TriggerServerCallback('esx_weaponshop:buyWeaponBank', function(bought)
								if bought then
									print('true')
									if data2.current.price > 0 then
										DisplayBoughtScaleform('weapon',data2.current.name, ESX.Math.GroupDigits(data2.current.price))
									end
									PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
									menu3.close()
									OpenShopMenu(zone)
									ShopOpen = false
								else
								PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
								end
							end, data2.current.name, 1, nil, zone)
						elseif data3.current.value == 'cash' then
							ESX.TriggerServerCallback('esx_weaponshop:buyWeapon', function(bought)
								if bought then
									if data2.current.price > 0 then
										DisplayBoughtScaleform('weapon',data2.current.name, ESX.Math.GroupDigits(data2.current.price))
									end
									PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
									menu3.close()
									OpenShopMenu(zone)
									ShopOpen = false
								else
								PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
								end
							end, data2.current.name, 1, nil, zone)
						end
					end, function(data3, menu3)
					menu3.close()
					end)
					--end debit or cash
				end
	
			end, function(data2, menu2)
			PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
			ShopOpen = false
			menu2.close()
			end)
		elseif data.current.value == "licenseShop" then
			OpenBuyLicenseMenu(zone)
		end
	end, function(data, menu)
	menu.close()
	end)
end--?--------------------------------------------------------------<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



--illegal weapons menu
function OpenShopMenuIllegal(zone)
	local elements = {}
	local buyAmmo = {}
	ShopOpen = true
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()

	Citizen.Wait(1000)
		for k,v in ipairs(Config.Zones[zone].Items0) do
			local weaponNum, weapon = ESX.GetWeapon(v.weapon)
			local components, label = {}
			local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

			if v.components then
				for i=1, #v.components do
					if v.components[i] then

						local component = weapon.components[i]
						local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

						if hasComponent then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_owned'))
						else
							if v.components[i] > 0 then
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_item', ESX.Math.GroupDigits(v.components[i])))
							else
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_free'))
							end
						end

						table.insert(components, {
							label = label,
							componentLabel = component.label,
							hash = component.hash,
							name = component.name,
							price = v.components[i],
							hasComponent = hasComponent,
							componentNum = i
						})
					end
				end
				table.insert(components, {
					label = _U('buy_ammo')..'<span style="color:green;">'..ESX.Math.GroupDigits(v.ammoPrice)..' $ </span>',
					type = 'ammo',
					price = v.ammoPrice,
					weapon = weapon.name,
					ammoNumber = v.AmmoToGive
				})
			end

			if hasWeapon and v.components then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice ~= nil then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice  == nil then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_owned'))
			elseif v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_item', ESX.Math.GroupDigits(v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_free'))
			end
		
			if weapon ~= nil then
			table.insert(elements, {
				label = label,
				weaponLabel = weapon.label,
				name = weapon.name,
				components = components,
				price = v.price,
				ammoPrice = v.ammoPrice,
				ammoNumber = v.AmmoToGive,
				hasWeapon = hasWeapon
			})
			end
		end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'illegal_shop', {
		title = "Buy Illegal Weapons",
		align = 'top-left',
		elements = elements
	}, function(data, menu)
		print('fired2')
		print(data.current.hasWeapon)
		print(data.current.name)
		if data.current.hasWeapon then
			print('fired1')
			if #data.current.components > 0 then
				OpenWeaponComponentShopMenu(data.current.components, data.current.name, menu, zone)
			elseif data.current.ammoPrice ~= nil then

				table.insert(buyAmmo, {
					label = _U('buy_ammo')..'<span style="color:green;">'..ESX.Math.GroupDigits(data.current.ammoPrice)..' $ </span>',
					price = data.current.ammoPrice,
					weapon = data.current.name,
					ammoToBuy = data.current.ammoNumber
				})
				print(ESX.DumpTable(buyAmmo))
				OpenAmmoShopMenu(buyAmmo,data.current.name,menu,zone)
			end
		else
			ESX.TriggerServerCallback('esx_weaponshop:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						DisplayBoughtScaleform('weapon',data.current.name, ESX.Math.GroupDigits(data.current.price))
					end
					PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
					menu.close()
					OpenShopMenu(zone)
					ShopOpen = false
				else
					PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
				end
			end, data.current.name, 1, nil, zone)
		end
		menu.close()
	end)
end


function OpenWeaponComponentShopMenu(components, weaponName, parentShop,zone)
	ShopOpen = true
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gunshop_buy_weapons_components', {
		title    = _U('gunshop_componenttitle'),
		align    = 'top-left',
		elements = components
	}, function(data, menu)

		if data.current.hasComponent and data.current.type ~= 'ammo'then
			ESX.ShowNotification(_U('gunshop_hascomponent'))
		elseif data.current.type ~= 'ammo' then
			--debit or cash??
			menu.close()
			
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'debit_cash', {
				title    = 'Select Payment Option',
				align    = 'top-left',
				elements = {
							{label = 'Debit', value = 'debit_card'},
							{label = 'Cash',  value = 'cash'},
				}
			}, function(data3, menu3)
				if data3.current.value == 'debit_card' then
					menu3.close()
					ESX.TriggerServerCallback('esx_weaponshop:buyWeaponBank', function(bought)
						if bought then
							if data.current.price > 0 then
								DisplayBoughtScaleform('component',data.current.componentLabel, ESX.Math.GroupDigits(data.current.price))
							end
							ShopOpen = false
							menu.close()
							parentShop.close()
							PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
							OpenShopMenu(zone)
						else
							PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
						end
						menu3.close()
					end, weaponName, 2, data.current.componentNum, zone)
				elseif data3.current.value == 'cash' then
					menu3.close()
					ESX.TriggerServerCallback('esx_weaponshop:buyWeapon', function(bought)
						if bought then
							if data.current.price > 0 then
								DisplayBoughtScaleform('component',data.current.componentLabel, ESX.Math.GroupDigits(data.current.price))
							end
							ShopOpen = false
							menu3.close()
							parentShop.close()
							PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
							OpenShopMenu(zone)
						else
							PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
						end
						menu3.close()
					end, weaponName, 2, data.current.componentNum, zone)
				end
				menu3.close()
			end, function(data3, menu3)
			menu3.close()
			end)

			--end debit or cash
		elseif data.current.type == 'ammo' then
			--debit or cash??

			menu.close()
			local ReachedMax = ReachedMaxAmmo(weaponName)
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'debit_cash', {
				title    = 'Select Payment Option',
				align    = 'top-left',
				elements = {
							{label = 'Debit', value = 'debit_card'},
							{label = 'Cash',  value = 'cash'},
				}
			}, function(data3, menu3)
				if data3.current.value == 'debit_card' then
					menu3.close()
					ESX.TriggerServerCallback('esx_weaponshop:buyWeaponBank', function(bought)
						if bought then
							if data.current.price > 0 then
								ESX.ShowNotification(_U('gunshop_bought',_U('ammo'),ESX.Math.GroupDigits(data.current.price)))
								AddAmmoToPed(PlayerPedId(), weaponName, data.current.ammoNumber)
							end
							parentShop.close()
						else
							if ReachedMax then
								ESX.ShowNotification(_U('gunshop_maxammo'))
							end
							PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
						end
					end, weaponName, 3, nil, zone, ReachedMax)
					menu3.close()
				elseif data3.current.value == 'cash' then
					menu3.close()
					ESX.TriggerServerCallback('esx_weaponshop:buyWeapon', function(bought)
						if bought then
							if data.current.price > 0 then
								ESX.ShowNotification(_U('gunshop_bought',_U('ammo'),ESX.Math.GroupDigits(data.current.price)))
								AddAmmoToPed(PlayerPedId(), weaponName, data.current.ammoNumber)
							end
							parentShop.close()
						else
							if ReachedMax then
								ESX.ShowNotification(_U('gunshop_maxammo'))
							end
							PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
						end
					end, weaponName, 3, nil, zone, ReachedMax)
					menu3.close()
				end
				menu3.close()
			end, function(data3, menu3)
			menu3.close()
			end)
			--end debit or cash
		end

	end, function(data, menu)
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
		ShopOpen = false
		menu.close()
	end)
end

function OpenAmmoShopMenu(buyAmmo,weaponName, parentShop,zone)
	ShopOpen = true
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gunshop_buy_weapons_components', {
		title    = _U('gunshop_componenttitle'),
		align    = 'top-left',
		elements = buyAmmo
	}, function(data4, menu4)
		local ReachedMax = ReachedMaxAmmo(weaponName)
		--debit or cash??

		menu4.close()
		local ReachedMax = ReachedMaxAmmo(weaponName)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'debit_cash', {
			title    = 'Select Payment Option',
			align    = 'top-left',
			elements = {
						{label = 'Debit', value = 'debit_card'},
						{label = 'Cash',  value = 'cash'},
			}
		}, function(data5, menu5)
			menu5.close()

			if data5.current.value == 'debit_card' then
				menu5.close()
				ESX.TriggerServerCallback('esx_weaponshop:buyWeaponBank', function(bought)
					if bought then
						if data4.current.price > 0 then
							ESX.ShowNotification(_U('gunshop_bought',_U('ammo'),ESX.Math.GroupDigits(data4.current.price)))
							AddAmmoToPed(PlayerPedId(), weaponName, data4.current.ammoToBuy)
						end
						parentShop.close()
					else
						if ReachedMax then
							ESX.ShowNotification(_U('gunshop_maxammo'))
						end
						PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
					end
					menu4.close()
				end, weaponName, 3, nil, zone, ReachedMax)
				menu5.close()
			elseif data5.current.value == 'cash' then
				menu5.close()
				ESX.TriggerServerCallback('esx_weaponshop:buyWeapon', function(bought)
					if bought then
						if data4.current.price > 0 then
							ESX.ShowNotification(_U('gunshop_bought',_U('ammo'),ESX.Math.GroupDigits(data4.current.price)))
							AddAmmoToPed(PlayerPedId(), weaponName, data4.current.ammoToBuy)
						end
						parentShop.close()
					else
						if ReachedMax then
							ESX.ShowNotification(_U('gunshop_maxammo'))
						end
						PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
					end
					menu4.close()
				end, weaponName, 3, nil, zone, ReachedMax)
			end
			menu5.close()
		end, function(data5, menu5)
		menu5.close()
		end)

		--END
		
--	end debit or cash
	end, function(data4, menu4)
		menu4.close()
	end)
end

function DisplayBoughtScaleform(type, item, price)
	local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
	local sec = 4

	if type == 'component' then
		text = _U('gunshop_bought', item, ESX.Math.GroupDigits(price))
		text2 = nil
		text3 = nil
	elseif type == 'weapon' then
		text2 = ESX.GetWeaponLabel(item)
		text = _U('gunshop_bought', text2, ESX.Math.GroupDigits(price))
		text3 = GetHashKey(item)
	end


	BeginScaleformMovieMethod(scaleform, 'SHOW_WEAPON_PURCHASED')

	PushScaleformMovieMethodParameterString(text)
	if text2 then
		PushScaleformMovieMethodParameterString(text2)
	end
	if text3 then
		PushScaleformMovieMethodParameterInt(text3)
	end
	PushScaleformMovieMethodParameterString('')
	PushScaleformMovieMethodParameterInt(100)

	EndScaleformMovieMethod()

	PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)

	Citizen.CreateThread(function()
		while sec > 0 do
			Citizen.Wait(0)
			sec = sec - 0.01
	
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
	end)
end

AddEventHandler('esx_weaponshop:hasEnteredMarker', function(zone)
	if zone == 'GunShop' then
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('shop_menu_prompt')
		CurrentActionData = { zone = zone }
	elseif zone == 'BlackWeashop' then
		CurrentAction     = 'shop_illegal'
		CurrentActionMsg  = _U('shop_menu_prompt_illegal')
		CurrentActionData = { zone = zone }
	end
end)

AddEventHandler('esx_weaponshop:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if ShopOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		if v.Legal then
			for i = 1, #v.Locations, 1 do
				local blip = AddBlipForCoord(v.Locations[i])

				SetBlipSprite (blip, 110)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, 81)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentSubstringPlayerName(_U('map_blip'))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Create Blips Illegal Weapons
--[[
Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones1) do
		if not v.Legal then
			for i = 1, #v.Locations, 1 do
				local blip = AddBlipForCoord(v.Locations[i])

				SetBlipSprite (blip, 478)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, 75)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentSubstringPlayerName(_U('illegalmap_blip'))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)
]]

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if v.Legal then
				for i = 1, #v.Locations, 1 do
					if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.DrawDistance) then
						DrawMarker(Config.Type, v.Locations[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
					end
				end
			else
				for i = 1, #v.Locations, 1 do
					if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.DrawDistance) then
						DrawMarker(20, v.Locations[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
					end
				end
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker, currentZone = false, nil

		for k,v in pairs(Config.Zones) do
			for i=1, #v.Locations, 1 do
				if GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.Size.x then
					isInMarker, ShopItems, currentZone, LastZone = true, v.Items, k, k
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_weaponshop:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_weaponshop:hasExitedMarker', LastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'shop_menu' then
					OpenShopMenu(CurrentActionData.zone)
				elseif CurrentAction == 'shop_illegal' then
					OpenShopMenuIllegal(CurrentActionData.zone)
				end

				CurrentAction = nil
			end
		end
	end
end)


function ReachedMaxAmmo(weaponName)

	local ammo = GetAmmoInPedWeapon(PlayerPedId(), weaponName)
	local _,maxAmmo = GetMaxAmmo(PlayerPedId(), weaponName)

	if ammo ~= maxAmmo then
		return false
	else
		return true
	end

end