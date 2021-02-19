
local pooch = false


RegisterServerEvent('sell:sellDrugs')
AddEventHandler('sell:sellDrugs', function()
	local _source = source
	local weedqty = 100
	local weedqtySingle =100
	local methqty = 100
	local methqtySingle = 100
	local cokeqty = 100
	local cokeqtySingle = 100
	local opiuqty = 100
	local opiuqtySingle = 100
	local pcpqty = 100
	local pcpqtySingle = 100
	local lsdqty = 100
	local lsdqtySingle = 100
	local x = 0
	local playerMoney = 0
	local drugType

	--get player inventory 
	if Config.SellWeed and weedqty > 0 or weedqtySingle > 0 then
		if weedqty > 0 and Config.SellPooch then
		drugType = "weedpooch"
			if weedqty == 1 then
				x = 1
			elseif weedqty == 2 then
				x = math.random(1,2)
			elseif weedqty == 3 then
				x = math.random(1,3)
			elseif weedqty == 4 then
				x = math.random(1,4)
			elseif weedqty >= 5 then
				x = math.random(1,5)
			end
		--xPlayer.removeInventoryItem('weed_pooch', x)
		elseif weedqtySingle > 0 and Config.SellSingle then
		drugType = "weed"
			if weedqtySingle == 1 then
				x = 1
			elseif weedqtySingle == 2 then
				x = math.random(1,2)
			elseif weedqtySingle == 3 then
				x = math.random(1,3)
			elseif weedqtySingle == 4 then
				x = math.random(1,4)
			elseif weedqtySingle >= 5 then
				x = math.random(1,5)
			end
		--xPlayer.removeInventoryItem('weed', x)
		end
	elseif Config.SellMeth and methqty > 0 or methqtySingle > 0 then
			if methqty > 0 and Config.SellPooch then
		drugType = "methpooch"
			if methqty == 1 then
				x = 1
			elseif methqty == 2 then
				x = math.random(1,2)
			elseif methqty == 3 then
				x = math.random(1,3)
			elseif methqty == 4 then
				x = math.random(1,4)
			elseif methqty >= 5 then
				x = math.random(1,5)
			end
		--xPlayer.removeInventoryItem('meth_pooch', x)
		elseif methqtySingle > 0 and Config.SellSingle then
		drugType = "meth"
			if methqtySingle == 1 then
				x = 1
			elseif methqtySingle == 2 then
				x = math.random(1,2)
			elseif methqtySingle == 3 then
				x = math.random(1,3)
			elseif methqtySingle == 4 then
				x = math.random(1,4)
			elseif methqtySingle >= 5 then
				x = math.random(1,5)
			end
	--	xPlayer.removeInventoryItem('meth', x)
		end
	elseif Config.SellCoke and cokeqty > 0 or cokeqtySingle > 0 then
			if cokeqty > 0 and Config.SellPooch then
		drugType = "cokepooch"
			if cokeqty == 1 then
				x = 1
			elseif cokeqty == 2 then
				x = math.random(1,2)
			elseif cokeqty == 3 then
				x = math.random(1,3)
			elseif cokeqty == 4 then
				x = math.random(1,4)
			elseif cokeqty >= 5 then
				x = math.random(1,5)
			end
	--	xPlayer.removeInventoryItem('coke_pooch', x)
		elseif cokeqtySingle > 0 and Config.SellSingle then
		drugType = "coke"
			if cokeqtySingle == 1 then
				x = 1
			elseif cokeqtySingle == 2 then
				x = math.random(1,2)
			elseif cokeqtySingle == 3 then
				x = math.random(1,3)
			elseif cokeqtySingle == 4 then
				x = math.random(1,4)
			elseif cokeqtySingle >= 5 then
				x = math.random(1,5)
			end
	--	xPlayer.removeInventoryItem('coke', x)
		end
	elseif Config.SellOpiu and opiuqty > 0 or opiuqtySingle > 0 then
			if opiuqty > 0 and Config.SellPooch then
		drugType = "opiumpooch"
			if opiuqty == 1 then
				x = 1
			elseif opiuqty == 2 then
				x = math.random(1,2)
			elseif opiuqty == 3 then
				x = math.random(1,3)
			elseif opiuqty == 4 then
				x = math.random(1,4)
			elseif opiuqty >= 5 then
				x = math.random(1,5)
			end
	--	xPlayer.removeInventoryItem('opium_pooch', x)
		elseif opiuqtySingle > 0 and Config.SellSingle then
		drugType = "opium"
			if opiuqtySingle == 1 then
				x = 1
			elseif opiuqtySingle == 2 then
				x = math.random(1,2)
			elseif opiuqtySingle == 3 then
				x = math.random(1,3)
			elseif opiuqtySingle == 4 then
				x = math.random(1,4)
			elseif opiuqtySingle >= 5 then
				x = math.random(1,5)
			end
	--	xPlayer.removeInventoryItem('opium', x)
		end
	elseif Config.SellLSD and lsdqty > 0 or lsdqtySingle > 0 then
		if lsdqty > 0 and Config.SellPooch then
			drugType = "lsdsheet"
		if lsdqty == 1 then
			x = 1
		elseif lsdqty == 2 then
			x = math.random(1,2)
		elseif lsdqty == 3 then
			x = math.random(1,3)
		elseif lsdqty == 4 then
			x = math.random(1,4)
		elseif lsdqty >= 5 then
			x = math.random(1,5)
		end
	--	xPlayer.removeInventoryItem('lsd_sheet', x)
		elseif lsdqtySingle > 0 and Config.SellSingle then
			drugType = "lsd"
			if lsdqtySingle == 1 then
				x = 1
			elseif lsdqtySingle == 2 then
				x = math.random(1,2)
			elseif lsdqtySingle == 3 then
				x = math.random(1,3)
			elseif lsdqtySingle == 4 then
				x = math.random(1,4)
			elseif lsdqtySingle >= 5 then
				x = math.random(1,5)
			end
	--	xPlayer.removeInventoryItem('lsd', x)
		end
	elseif Config.SellPCP and pcpqty > 0 or pcpqtySingle > 0 then
		if pcpqty > 0 and Config.SellPooch then
			drugType = "pcpgallon"
		if pcpqty == 1 then
			x = 1
		elseif pcpqty == 2 then
			x = math.random(1,2)
		elseif pcpqty == 3 then
			x = math.random(1,3)
		elseif pcpqty == 4 then
			x = math.random(1,4)
		elseif pcpqty >= 5 then
			x = math.random(1,5)
		end
	--	xPlayer.removeInventoryItem('pcp_gallon', x)
		elseif pcpqtySingle > 0 and Config.SellSingle then
			drugType = "pcp"
			if pcpqtySingle == 1 then
				x = 1
			elseif pcpqtySingle == 2 then
				x = math.random(1,2)
			elseif pcpqtySingle == 3 then
				x = math.random(1,3)
			elseif pcpqtySingle == 4 then
				x = math.random(1,4)
			elseif pcpqtySingle >= 5 then
				x = math.random(1,5)
			end
	--	xPlayer.removeInventoryItem('pcp', x)
		end
	else
		TriggerClientEvent('nomoredrugs', _source)
		return
	end
	if drugType=="weedpooch" then	--pooch
		playerMoney = Config.WeedPrice * 8 * x
		pooch = true
	elseif drugType=="methpooch" then
		playerMoney = Config.MethPrice * 8 * x
		pooch = true
	elseif drugType=="cokepooch" then
		playerMoney = Config.CokePrice * 8 * x
		pooch = true
	elseif drugType=="opiumpooch" then
		playerMoney = Config.OpiuPrice * 8 * x
		pooch = true
	elseif drugType=="lsdsheet" then
		playerMoney = Config.LSDPrice * 8 * x
		pooch = true
	elseif drugType=="pcpgallon" then
		playerMoney = Config.PCPPrice * 8 * x
		pooch = true
	elseif drugType=="weed" then	--single
		playerMoney = Config.WeedPrice * x
	elseif drugType=="meth" then
		playerMoney = Config.MethPrice * x
	elseif drugType=="coke" then
		playerMoney = Config.CokePrice * x
	elseif drugType=="opium" then
		playerMoney = Config.OpiuPrice * x
	elseif drugType=="lsd" then
		playerMoney = Config.LSDPrice * x
	elseif drugType=="pcp" then
		playerMoney = Config.PCPPrice * x
	end
	if pooch then
		--xPlayer.addAccountMoney('black_money', playerMoney)
		pooch = false
	else
		--xPlayer.addMoney(playerMoney)
	end
	Citizen.Wait(100)
	TriggerClientEvent('showSellInfo', _source, x, playerMoney, drugType)
	TriggerClientEvent('sold', _source)
end)


RegisterServerEvent('sell:check')
AddEventHandler('sell:check', function()
	local _source = source
	--local xPlayer = ESX.GetPlayerFromId(_source)
--	local xPlayers = ESX.GetPlayers()
	local weedqty = 100
	local weedqtySingle = 100
	local methqty = 100
	local methqtySingle = 100
	local cokeqty = 100
	local cokeqtySingle = 100
	local opiuqty = 100
	local opiuqtySingle = 100
	local lsdqty = 100
	local lsdqtySingle = 100
	local pcpqty = 100
	local pcpqtySingle = 100
	
	--check cops count on server
	local cops = 0
	--for i=1, #xPlayers, 1 do
 	--	local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 	--	if xPlayer.job.name == 'police' then
	--			cops = cops + 1
	--	end
--	end
	
	local drugsChecker = 0
	if cops >= Config.CopsRequiredToSell then
		if Config.SellPooch or Config.SellSingle then
			if Config.SellWeed then
				if weedqty > 0 or weedqtySingle > 0 then
					TriggerClientEvent('playerhasdrugs', _source)
					drugsChecker = drugsChecker + 1
				end
			end
			if Config.SellMeth then
				if methqty > 0 or methqtySingle > 0 then
					TriggerClientEvent('playerhasdrugs', _source)
					drugsChecker = drugsChecker + 1
				end
			end
			if Config.SellCoke then
				if cokeqty > 0 or cokeqtySingle > 0 then
					TriggerClientEvent('playerhasdrugs', _source)
					drugsChecker = drugsChecker + 1
				end
			end
			if Config.SellOpiu then
				if opiuqty > 0 or opiuqtySingle > 0 then
					TriggerClientEvent('playerhasdrugs', _source)
					drugsChecker = drugsChecker + 1
				end
			end
			if Config.SellLSD then
				if lsdqty > 0 or lsdqtySingle > 0 then
					TriggerClientEvent('playerhasdrugs', _source)
					drugsChecker = drugsChecker + 1
				end
			end
			if Config.SellPCP then
				if pcpqty > 0 or pcpqtySingle > 0 then
					TriggerClientEvent('playerhasdrugs', _source)
					drugsChecker = drugsChecker + 1
				end
			end
			
			--Drugs Checker
			if drugsChecker == 0 then
				TriggerClientEvent('nomoredrugs', _source)
			else
				drugsChecker = 0
			end
		end
	else
		--TriggerClientEvent('esx:showNotification', _source, _U('must_be') .. Config.CopsRequiredToSell .. _U('to_sell_drugs'))
	end
end)


RegisterServerEvent('drugsNotify')
AddEventHandler('drugsNotify', function()
	TriggerClientEvent("drugsEnable", source)
end)

RegisterServerEvent('outlawNotify')
AddEventHandler('outlawNotify', function(input)
SetNotificationTextEntry(‘STRING’)
AddTextComponentString(input)
DrawNotification(false, false)
end)
--if you need you can translate it to your language
RegisterServerEvent('drugsInProgress')
AddEventHandler('drugsInProgress', function(street1, street2, sex)
      --TriggerClientEvent("outlawNotify", -1, "~r~Selling drugs by ~w~"..sex.."~r~near~w~"..street1.."~r~ and ~w~"..street2)
	TriggerClientEvent("outlawNotify", -1, "~r~Drugs being sold by a ~w~"..sex.." ~r~at ~w~"..street1.."~r~ and ~w~"..street2)
end)
--if you need you can translate it to your language too
RegisterServerEvent('drugsInProgressS1')
AddEventHandler('drugsInProgressS1', function(street1, sex)
      --TriggerClientEvent("outlawNotify", -1, "~r~Selling drugs by ~w~"..sex.."~r~near~w~"..street1)
	TriggerClientEvent("outlawNotify", -1, "~r~Drugs being sold by a ~w~"..sex.." ~r~near ~w~"..street1)
end)

RegisterServerEvent('drugsInProgressPos')
AddEventHandler('drugsInProgressPos', function(gx, gy, gz)
	TriggerClientEvent('drugsPlace', -1, gx, gy, gz)
end)
