ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)


RegisterServerEvent('esx_pawnshop:buyFixkit')
AddEventHandler('esx_pawnshop:buyFixkit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 3000) then
		xPlayer.removeMoney(3000)
		
		xPlayer.addInventoryItem('fixkit', 1)
		
		notification("You bought a ~ g ~ Repair Kit")
	else
		notification("You do not have enough ~r~money")
	end		
end)


RegisterServerEvent('esx_pawnshop:buyBulletproof')
AddEventHandler('esx_pawnshop:buyBulletproof', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 35000) then
		xPlayer.removeMoney(35000)
		
		xPlayer.addInventoryItem('bulletproof', 1)
		
		notification("You bought a ~g~bulletproof vest")
	else
		notification("You do not have enough ~r~money")
	end		
end)


RegisterServerEvent('esx_pawnshop:buyDrill')
AddEventHandler('esx_pawnshop:buyDrill', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 1800) then
		xPlayer.removeMoney(1800)
		
		xPlayer.addInventoryItem('drill', 1)
		
		notification("You bought a ~g~drill")
	else
		notification("You do not have enough ~r~money")
	end		
end)


RegisterServerEvent('esx_pawnshop:buyBlindfold')
AddEventHandler('esx_pawnshop:buyBlindfold', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 50) then
		xPlayer.removeMoney(50)
		
		xPlayer.addInventoryItem('blindfold', 1)
		
		notification("You bought a ~g~blindfold")
	else
		notification("You do not have enough ~r~money")
	end		
end)


RegisterServerEvent('esx_pawnshop:buyFishingrod')
AddEventHandler('esx_pawnshop:buyFishingrod', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 50) then
		xPlayer.removeMoney(50)
		
		xPlayer.addInventoryItem('fishing_rod', 1)
		
		notification("You bought a ~g~fishing rod")
	else
		notification("You do not have enough ~r~money")
	end		
end)

RegisterServerEvent('esx_pawnshop:buyRaspberry')
AddEventHandler('esx_pawnshop:buyRaspberry', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 2000) then
		xPlayer.removeMoney(2000)
		
		xPlayer.addInventoryItem('raspberry', 1)
		
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'You bought a ~g~Raspberry Pi 3+!')
		hintToDisplay('Press ~INPUT_CONTEXT~ to open the ~b~Pawn Shop~w~')
	else
		notification("You do not have enough ~r~money")
	end		
end)

RegisterServerEvent('esx_pawnshop:buyAntibiotika')
AddEventHandler('esx_pawnshop:buyAntibiotika', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 1239) then
		xPlayer.removeMoney(1239)
		
		xPlayer.addInventoryItem('anti', 1)
		
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'You bought ~g~antibiotics')
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have enough money!')
	end		
end)

--RegisterServerEvent('esx_pawnshop:buyPhone')
--AddEventHandler('esx_pawnshop:buyPhone', function()
--	local _source = source
--	local xPlayer = ESX.GetPlayerFromId(_source)
--	
--	if(xPlayer.getMoney() >= 3400) then
--		xPlayer.removeMoney(3400)
--		
--		xPlayer.addInventoryItem('phone', 1)
--		
--		notification("Du köpte en ny ~g~telefon")
--	else
--		notification("You do not have enough ~r~money")
--	end		
--end)


-----Sälj
RegisterServerEvent('esx_pawnshop:sellring')
AddEventHandler('esx_pawnshop:sellring', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local ring = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "ring" then
			ring = item.count
		end
	end
    
    if ring > 0 then
        xPlayer.removeInventoryItem('ring', 1)
        xPlayer.addMoney(400)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have a ring to sell!')
    end
end)

RegisterServerEvent('esx_pawnshop:sellrolex')
AddEventHandler('esx_pawnshop:sellrolex', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local rolex = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "rolex" then
			rolex = item.count
		end
	end
    
    if rolex > 0 then
        xPlayer.removeInventoryItem('rolex', 1)
        xPlayer.addMoney(1000)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have any rolex\'s to sell!')
    end
end)
--changed to speaked
RegisterServerEvent('esx_pawnshop:sellkamera')
AddEventHandler('esx_pawnshop:sellkamera', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local speaker = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "speaker" then
			speaker = item.count
		end
	end
    
    if speaker > 0 then
        xPlayer.removeInventoryItem('speaker', 1)
        xPlayer.addMoney(120)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have any speakers to sell!')
    end
end)

RegisterServerEvent('esx_pawnshop:sellarmband')
AddEventHandler('esx_pawnshop:sellarmband', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local armband = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "armband" then
			armband = item.count
		end
	end
    
    if armband > 0 then
        xPlayer.removeInventoryItem('armband', 1)
        xPlayer.addMoney(450)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have a bracelet to sell!')
    end
end)
--sell raspberry pi
RegisterServerEvent('esx_pawnshop:sellhalsband')
AddEventHandler('esx_pawnshop:sellhalsband', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local raspberry = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "raspberry" then
			raspberry = item.count
		end
	end
    
    if halsband > 0 then
        xPlayer.removeInventoryItem('raspberry', 1)
        xPlayer.addMoney(45)
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have any necklace to sell!')
    end
end)

RegisterServerEvent('esx_pawnshop:sellbottle')
AddEventHandler('esx_pawnshop:sellbottle', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local bottle = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "bottle" then
			bottle = item.count
		end
	end
    
    if bottle > 0 then
        xPlayer.removeInventoryItem('bottle', 1)
        xPlayer.addMoney(1)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have any empty bottles to sell')
    end
end)

RegisterServerEvent('esx_pawnshop:sellfishingrod')
AddEventHandler('esx_pawnshop:sellfishingrod', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local fishingrod = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "fishingrod" then
			fishingrod = item.count
		end
	end
  
    if fishingrod > 0 then
        xPlayer.removeInventoryItem('fishingrod', 1)
        xPlayer.addMoney(10)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have a fishing rod to sell!')
    end
end)

RegisterServerEvent('esx_pawnshop:selldrill')
AddEventHandler('esx_pawnshop:selldrill', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local drill = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "drill" then
			drill = item.count
		end
	end
    
    if drill > 0 then
        xPlayer.removeInventoryItem('drill', 1)
        xPlayer.addMoney(75)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have a drilling machine to sell!')
    end
end)

RegisterServerEvent('esx_pawnshop:sellblindfold')
AddEventHandler('esx_pawnshop:sellblindfold', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local blindfold = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "blindfold" then
			blindfold = item.count
		end
	end
    
    if blindfold > 0 then
        xPlayer.removeInventoryItem('blindfold', 1)
        xPlayer.addMoney(10)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You do not have a blindfold to sell!')
    end
end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end