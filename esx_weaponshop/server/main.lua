ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_weaponshop:buyLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)
			TriggerEvent('esx_license:addLicense', source, 'weapon_tier1', function()
				cb(true)
			end)
	else
		TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
		cb(false)
	end
end)
ESX.RegisterServerCallback('esx_weaponshop:buyLicense2', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

			TriggerEvent('esx_license:addLicense', source, 'weapon_tier2', function()
				cb(true)
			end)
	else
		TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
		cb(false)
	end
end)
ESX.RegisterServerCallback('esx_weaponshop:buyLicense3', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

			TriggerEvent('esx_license:addLicense', source, 'weapon_tier3', function()
				cb(true)
			end)
	else
		TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
		cb(false)
	end
end)


ESX.RegisterServerCallback('esx_weaponshop:buyLicenseBank', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("debitcard").count > 0 then
		if xPlayer.getAccount('bank').money >= Config.LicensePrice then
			xPlayer.removeAccountMoney('bank', Config.LicensePrice)
				TriggerEvent('esx_license:addLicense', source, 'weapon_tier1', function()
					cb(true)
				end)
		else
			TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
			cb(false)
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'No Debit Card')
	end
end)
ESX.RegisterServerCallback('esx_weaponshop:buyLicense2Bank', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("debitcard").count > 0 then
		if xPlayer.getAccount('bank').money >= Config.LicensePrice then
			xPlayer.removeAccountMoney('bank', Config.LicensePrice)
				TriggerEvent('esx_license:addLicense', source, 'weapon_tier2', function()
					cb(true)
				end)
		else
			TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
			cb(false)
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'No Debit Card')
	end
end)
ESX.RegisterServerCallback('esx_weaponshop:buyLicense3Bank', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("debitcard").count > 0 then
		if xPlayer.getAccount('bank').money >= Config.LicensePrice then
			xPlayer.removeAccountMoney('bank', Config.LicensePrice)
				TriggerEvent('esx_license:addLicense', source, 'weapon_tier3', function()
					cb(true)
				end)
		else
			TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
			cb(false)
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'No Debit Card')
	end
end)

ESX.RegisterServerCallback('esx_weaponshop:buyAmmo1', function(source, cb, itemName, price1)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	-- get price
	local price = 0
	local itemLabel = ''

	price = price1

	-- can the player afford this item?
	if xPlayer.getMoney() >= price then
		-- can the player carry the said amount of x item?
		if sourceItem.limit ~= -1 and (sourceItem.count + 1) > sourceItem.limit then
			TriggerClientEvent('esx:showNotification', _source, 'You cannot carry anymore of these.')
		else
		print(price)
			xPlayer.removeMoney(price)
			xPlayer.addInventoryItem(itemName, 1)
			TriggerClientEvent('esx:showNotification', _source, _U('bought', 1, itemLabel, ESX.Math.GroupDigits(price)))
			cb(true)
		end
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough1', ESX.Math.GroupDigits(missingMoney)))
		cb(false)
	end
	-----------
end)

RegisterServerEvent('esx_weaponshop:buyAmmo')
AddEventHandler('esx_weaponshop:buyAmmo', function(itemName, price1)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	-- get price
	local price = 0
	local itemLabel = ''

	price = price1

	-- can the player afford this item?
	if xPlayer.getMoney() >= price then
		-- can the player carry the said amount of x item?
		if sourceItem.limit ~= -1 and (sourceItem.count + 1) > sourceItem.limit then
			TriggerClientEvent('esx:showNotification', _source, 'You cannot carry anymore of these clips.')
		else
		print(price)
			xPlayer.removeMoney(price)
			xPlayer.addInventoryItem(itemName, 1)
			TriggerClientEvent('esx:showNotification', _source, _U('bought', 1, itemLabel, ESX.Math.GroupDigits(price)))
		end
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough1', ESX.Math.GroupDigits(missingMoney)))
	end
end)

RegisterServerEvent('esx_weaponshop:buyAmmoBank')
AddEventHandler('esx_weaponshop:buyAmmoBank', function(itemName, price1)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	-- get price
	local price = 0
	local itemLabel = ''

	price = price1

	-- can the player afford this item?
	if xPlayer.getAccount('bank').money >= price then
		-- can the player carry the said amount of x item?
		if sourceItem.limit ~= -1 and (sourceItem.count + 1) > sourceItem.limit then
			TriggerClientEvent('esx:showNotification', _source, 'You cannot carry anymore of these clips.')
		else
		print(price)
			xPlayer.removeAccountMoney('bank',price)
			xPlayer.addInventoryItem(itemName, 1)
			TriggerClientEvent('esx:showNotification', _source, _U('bought', 1, itemLabel, ESX.Math.GroupDigits(price)))
		end
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough1', ESX.Math.GroupDigits(missingMoney)))
	end
end)



ESX.RegisterServerCallback('esx_weaponshop:buyWeapon', function(source, cb, weaponName, type, componentNum, zone, max)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.Zones[zone].Items
	
	if zone == "GunShop" then 
		for k,v in ipairs(Config.Zones[zone].Items0) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end

		for k,v in ipairs(Config.Zones[zone].Items1) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end

		for k,v in ipairs(Config.Zones[zone].Items2) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end

		for k,v in ipairs(Config.Zones[zone].Items3) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end
	else
		for k,v in ipairs(Config.Zones[zone].Items0) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end
	end
	if not selectedWeapon then
		print(('esx_weaponshop: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	end

	if zone == 'GunShop' then
		-- Weapon
		if type == 1 then
			print(selectedWeapon.price)
			print(selectedWeapon.name)
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 0)

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)

			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('esx_weaponshop: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end

			--Weapon Ammo
		elseif type == 3 then
			if xPlayer.getMoney() >= selectedWeapon.ammoPrice and not max then
				xPlayer.removeMoney(selectedWeapon.ammoPrice)
				cb(true)
			else
				cb(false)
			end
		end
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getAccount('black_money').money >= selectedWeapon.price then
				xPlayer.removeAccountMoney('black_money', selectedWeapon.price)
				--xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 0)

				cb(true)
			else
				TriggerClientEvent('esx:showNotification', source, "You do not have enough dirty money!")
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)

			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getAccount('black_money').money >= price then
					xPlayer.removeAccountMoney('black_money', price)
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('esx_weaponshop: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end

			--Weapon Ammo
		elseif type == 3 then
		print('Trying to buy ammo')
			if xPlayer.getAccount('black_money').money >= selectedWeapon.ammoPrice and not max then
				xPlayer.removeAccountMoney('black_money', selectedWeapon.ammoPrice)
				cb(true)
			else
				cb(false)
			end
		end
	end
end)


ESX.RegisterServerCallback('esx_weaponshop:buyWeaponBank', function(source, cb, weaponName, type, componentNum, zone, max)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.Zones[zone].Items
	
	if zone == "GunShop" then 
		for k,v in ipairs(Config.Zones[zone].Items0) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end

		for k,v in ipairs(Config.Zones[zone].Items1) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end

		for k,v in ipairs(Config.Zones[zone].Items2) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end

		for k,v in ipairs(Config.Zones[zone].Items3) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end
	else
		for k,v in ipairs(Config.Zones[zone].Items0) do
			if v.weapon == weaponName then
				selectedWeapon = v
				break
			end
		end
	end
	if not selectedWeapon then
		print(('esx_weaponshop: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	end

	if zone == 'GunShop' then
		-- Weapon
		if type == 1 then
			if xPlayer.getInventoryItem("debitcard").count > 0 then
				TriggerClientEvent('esx:showNotification', source, '~y~Card ~b~Swiped!~s~')
				if xPlayer.getAccount('bank').money >= selectedWeapon.price then
					xPlayer.removeAccountMoney('bank', selectedWeapon.price)
					xPlayer.addWeapon(weaponName, 0)
					cb(true)
				else
					TriggerClientEvent('esx:showNotification', source, '~y~No Money in ~b~Account!~s~')
					cb(false)
				end
			else
				TriggerClientEvent('esx:showNotification', source, '~y~No ~b~Debit Card!~s~')
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)

			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getInventoryItem("debitcard").count > 0 then
					TriggerClientEvent('esx:showNotification', source, '~y~Card ~b~Swiped!~s~')
					if xPlayer.getAccount('bank').money >= price then
						xPlayer.removeAccountMoney('bank', price)
						xPlayer.addWeaponComponent(weaponName, component.name)
						cb(true)
					else
						TriggerClientEvent('esx:showNotification', source, '~y~No Money in ~b~Account!~s~')
						cb(false)
					end
				else
					TriggerClientEvent('esx:showNotification', source, '~y~No ~b~Debit Card!~s~')
					cb(false)
				end
			else
				print(('esx_weaponshop: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end

			--Weapon Ammo
		elseif type == 3 then
			if xPlayer.getInventoryItem("debitcard").count > 0 then
				TriggerClientEvent('esx:showNotification', source, '~y~Card ~b~Swiped!~s~')
				if xPlayer.getAccount('bank').money >= selectedWeapon.ammoPrice and not max then
					xPlayer.removeAccountMoney('bank',selectedWeapon.ammoPrice)
					cb(true)
				else
					TriggerClientEvent('esx:showNotification', source, '~y~No Money in ~b~Account!~s~')
					cb(false)
				end
			else
				TriggerClientEvent('esx:showNotification', source, '~y~No ~b~Debit Card!~s~')
				cb(false)
			end
		end
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getAccount('black_money').money >= selectedWeapon.price then
				xPlayer.removeAccountMoney('black_money', selectedWeapon.price)
				--xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 0)

				cb(true)
			else
				TriggerClientEvent('esx:showNotification', source, "You do not have enough dirty money!")
				cb(false)
			end

		-- Weapon Component
	elseif type == 2 then
		local price = selectedWeapon.components[componentNum]
		local weaponNum, weapon = ESX.GetWeapon(weaponName)

		local component = weapon.components[componentNum]

		if component then
			if xPlayer.getAccount('black_money').money >= price then
				xPlayer.removeAccountMoney('black_money', price)
				xPlayer.addWeaponComponent(weaponName, component.name)

				cb(true)
			else
				cb(false)
			end
		else
			print(('esx_weaponshop: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
			cb(false)
		end

			--Weapon Ammo
		elseif type == 3 then
			if xPlayer.getAccount('black_money').money >= selectedWeapon.ammoPrice and not max then
				xPlayer.removeAccountMoney('black_money', selectedWeapon.ammoPrice)
				cb(true)
			else
				cb(false)
			end
		end
	end
end)