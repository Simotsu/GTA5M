ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_debitshop:pay')
AddEventHandler('esx_debitshop:pay', function()
	print('fire')
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("debitcard").count > 0 then
		TriggerClientEvent('esx:showNotification', source, '~y~You have a ~b~Debit Card!~s~')
	else
		if xPlayer.getAccount('bank').money >= 15 then
			xPlayer.addInventoryItem('debitcard', 1)
			xPlayer.removeAccountMoney('bank', 15)
			TriggerClientEvent('esx:showNotification', source, '~y~Card ~b~Purchased!~s~')
		else
			TriggerClientEvent('esx:showNotification', source, '~y~Account ~b~Overdraft!~s~')

		end
	end

end)
