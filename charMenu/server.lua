ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------------------------------------------
------------Bobby O'Shea Character Menu----------
-------------------------------------------------

RegisterServerEvent('charMenu:drag')
AddEventHandler('charMenu:drag', function(target)
    TriggerClientEvent('charMenu:drag', target, source)
end)

RegisterServerEvent('charMenu:ziptie')
AddEventHandler('charMenu:ziptie', function(target, num)
    local xPlayer = ESX.GetPlayerFromId(source)
    if num == 1 then
            TriggerClientEvent('charMenu:ziptie', target)
    elseif xPlayer.getInventoryItem('ziptie').count >= 1 then
        xPlayer.removeInventoryItem('ziptie', 1)
        TriggerClientEvent('charMenu:ziptie', target)
    else
        TriggerClientEvent('esx:showNotification', source, 'You need zipties to perform this action.') 
    end
end)

RegisterServerEvent('charMenu:putInVehicle')
AddEventHandler('charMenu:putInVehicle', function(target)
		TriggerClientEvent('charMenu:putInVehicle', target)
end)

RegisterServerEvent('charMenu:outVehicle')
AddEventHandler('charMenu:outVehicle', function(target)
		TriggerClientEvent('charMenu:outVehicle', target)
end)

RegisterServerEvent('charMenu:requestarrest')
AddEventHandler('charMenu:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('zipties').count >= 1 then
        xPlayer.removeInventoryItem('zipties', 1)
        TriggerClientEvent('charMenu:ziptie', targetid)
        TriggerClientEvent('charMenu:getarrested', targetid, playerheading, playerCoords, playerlocation)
        TriggerClientEvent('charMenu:doarrested', _source)
    else
        TriggerClientEvent('esx:showNotification', source, 'You need zipties to perform this action.') 
    end
end)

RegisterServerEvent('charMenu:requestrelease')
AddEventHandler('charMenu:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('charMenu:ziptie', targetid)
    TriggerClientEvent('charMenu:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('charMenu:douncuffing', _source)
end)

RegisterServerEvent('charMenu:requestsearch')
AddEventHandler('charMenu:requestsearch', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('charMenu:search', targetid)
    TriggerClientEvent('charMenu:getsearched', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('charMenu:dosearching', _source)
end)

RegisterServerEvent('charMenu:getKeys')
AddEventHandler('charMenu:getKeys', function()
    _source = source
    local identifier = PlayerIdentifier('steam', _source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner ="'..identifier..'" ORDER BY plate ASC', {}, function(veh)
        if veh ~= nil then
            for k,v in pairs(veh) do
                TriggerClientEvent('charMenu:setKeys',-1, veh[k].plate)
            end
        end
    end)
end)   

RegisterServerEvent('charMenu:giveKeys')
AddEventHandler('charMenu:giveKeys', function(value, player)
    _source = source
    local identifier = PlayerIdentifier('steam', _source)
    local identifier2 = PlayerIdentifier('steam', player)
    MySQL.Async.execute('UPDATE owned_vehicles SET owner = "'..identifier2..'" WHERE owner="'..identifier..'" AND plate ="'..value..'"', {})
    MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner="'..identifier..'" AND plate ="'..value..'"', {})
end)   

RegisterServerEvent('charMenu:getPhone')
AddEventHandler('charMenu:getPhone', function()
   local _source = source
    local identifier = PlayerIdentifier('steam', _source)
    MySQL.Async.fetchAll('SELECT phone_number FROM users WHERE identifier ="'..identifier..'"', {}, function(num)
        if num ~= nil then
           -- TriggerClientEvent('charMenu:setNumber',-1, num[1].phone_number)
            TriggerClientEvent('charMenu:setNumber',_source, num[1].phone_number)
        end
    end)
end)  

RegisterServerEvent('charMenu:getID')
AddEventHandler('charMenu:getID', function(number)
   local _source = source
   local first
   local num 

    if number ~= nil then
        num = number
        local identifier = PlayerIdentifier('steam', number)
        local snitch = PlayerIdentifier('steam', _source)
        print(snitch)
        if identifier ~= false then
            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier ="'..identifier..'"', {}, function(name)
                if name[1].firstname ~= nil then
                    first = name[1].firstname.." "..name[1].lastname
                    TriggerClientEvent('charMenu:setName', -1, first, num)
                end
            end)
        end
    end
end)  


---------------------------------------------
------------Get PlayedID Function------------
---------------------------------------------
function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end