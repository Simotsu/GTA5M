ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_secretshop:buyC4')
AddEventHandler('esx_secretshop:buyC4', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 15000) then
		xPlayer.removeMoney(15000)
		
		xPlayer.addInventoryItem('c4_bank', 1)
		
		notification("You bought C4 Explosives, You didnt get that here! -wink-")
	else
		notification("You do not have enough money?! You trying to insult me?")
	end		
end)


RegisterServerEvent('esx_secretshop:buyBlowtorch')
AddEventHandler('esx_secretshop:buyBlowtorch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 2000) then
		xPlayer.removeMoney(2000)
		
		xPlayer.addInventoryItem('blowtorch', 1)
		
		notification("You bought a Blowtorch, You didnt get that here! -wink-")
	else
		notification("You do not have enough money?! You trying to insult me?")
	end		
end)

RegisterServerEvent('esx_secretshop:buyZiptie')
AddEventHandler('esx_secretshop:buyZiptie', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 5) then
		xPlayer.removeMoney(5)
		
		xPlayer.addInventoryItem('zipties', 1)
		
		notification("You bought Ziptie Handcuffs, You didnt get that here! -wink-")
	else
		notification("You do not have enough money?! You trying to insult me?")
	end		
end)

RegisterServerEvent('esx_secretshop:buyDrill')
AddEventHandler('esx_secretshop:buyDrill', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 400) then
		xPlayer.removeMoney(400)
		
		xPlayer.addInventoryItem('drill', 1)
		
		notification("You bought a Drill, You didnt get that here! -wink-")
	else
		notification("You do not have enough money?! You trying to insult me?")
	end		
end)

RegisterServerEvent('esx_secretshop:buyRaspberry')
AddEventHandler('esx_secretshop:buyRaspberry', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 15000) then
		xPlayer.removeMoney(15000)
		
		xPlayer.addInventoryItem('raspberry', 1)
		
		notification("You bought a Raspberry Pi 3+, You didnt get that here! -wink-")
	else
		notification("You do not have enough money?! You trying to insult me?")
	end		
end)

RegisterServerEvent('esx_secretshop:buyCoke')
AddEventHandler('esx_secretshop:buyCoke', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 2000) then
		xPlayer.removeMoney(2000)
		
		xPlayer.addInventoryItem('coke', 1)
		
		notification("You bought a gram of coke, You didnt get that here! -wink-")
	else
		notification("You do not have enough money?! You trying to insult me?")
	end		
end)
RegisterServerEvent('esx_secretshop:buyWeed')
AddEventHandler('esx_secretshop:buyWeed', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 400) then
		xPlayer.removeMoney(400)
		
		xPlayer.addInventoryItem('weed', 1)
		
		notification("You bought a, 1/8 of weed, You didnt get that here! -wink-")
	else
		notification("You do not have enough money?! You trying to insult me?")
	end		
end)
RegisterServerEvent('esx_secretshop:buyOpium')
AddEventHandler('esx_secretshop:buyOpium', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 1900) then
		xPlayer.removeMoney(1900)
		
		xPlayer.addInventoryItem('opium', 1)
		
		notification("You bought a gram of opium, You didnt get that here! -wink-")
	else
		notification("You do not have enough money?! You trying to insult me?")
	end		
end)
RegisterServerEvent('esx_secretshop:buyMeth')
AddEventHandler('esx_secretshop:buyMeth', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 1200) then
		xPlayer.removeMoney(1200)
		
		xPlayer.addInventoryItem('meth', 1)
		
		notification("You bought a gram of meth, You didnt get that here! -wink-")
	else
		notification("You do not have enough money?! You trying to insult me?")
	end		
end)





function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end