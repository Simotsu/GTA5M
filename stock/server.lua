---------------------------------------------
------------Bobby O'Shea's Stocks------------
---------------------------------------------
--GLOBAL VARIABLES
ESX                     = nil

--Get Shared ESX Objects
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
    end)

---------------------------------------------
-----------------BuyStocks-------------------
---------------------------------------------

RegisterServerEvent('vn_stocks:buystock')
AddEventHandler('vn_stocks:buystock', function(stockname)
    local hasStock = false --This is used to check if you have the stock currently to prevent multiple entrys of the same name
    local _source = source --I like making a source variable. Seems the only way to "print" it
    local identifier = PlayerIdentifier('steam', source) --Use funtion identifier to get Steam ID of player
    local xPlayer = ESX.GetPlayerFromId(source) --xPlayer variable
    local amountLeft = 0 --Amount of stocks left in stockname
    local priceperstock = 0 --Price per stock of stockname
    local totalPrice = 0 --Not using this yet, but I want to show how much the total stock is

    --Get the stock that corresponds to one selected 'stockname'
    MySQL.Async.fetchAll('SELECT * FROM stocks WHERE name="'..stockname..'" ORDER BY name ASC', {}, function(stock)
        if stock ~= nil then --if there is data continue
            for k,v in pairs(stock) do --for 1 through stocks.limit do +1 after iteration
                priceperstock = stock[k].price_per_stock --get stock price
                amountLeft = stock[k].count --get amount of stocks left to buy
            end
        end
    end)
    Citizen.Wait(190)
    totalPrice = priceperstock * amountLeft
    print(priceperstock)
    if amountLeft > 0 then
        if totalPrice >= 0 then
            local stockowned = {}
            Citizen.Wait(180)
            xPlayer.removeMoney(priceperstock)
            MySQL.Async.fetchAll('SELECT * FROM owned_stocks WHERE owner ="'..identifier..'" ORDER BY stockname ASC', {}, function(stock)
                if stock ~= nil then
                    for k,v in pairs(stock) do
                        stockowned[k] = stock[k].stockname
                    end
                end
            end)
            Citizen.Wait(180)
       
            for k,v in pairs(stockowned) do
                if stockowned[k] == stockname then
                    hasStock = true
                end
            end
            Citizen.Wait(180)
            if hasStock == true then
                MySQL.Async.execute('UPDATE owned_stocks SET amt_owned = amt_owned + 1 WHERE stockname="'..stockname..'" AND owner ="'..identifier..'"', {})
                MySQL.Async.execute('UPDATE stocks SET count = count - 1 WHERE name="'..stockname..'"', {})
            TriggerClientEvent('esx:showNotification', _source, 'You Have Purchased 1 Stock For $'..priceperstock)
            else
                MySQL.Async.execute('INSERT INTO owned_stocks (amt_owned, stockname, owner) VALUES (1,@name,@identity)', {['@name'] = stockname, ['@identity'] = identifier})
                MySQL.Async.execute('UPDATE stocks SET count = count - 1 WHERE name="'..stockname..'"', {})
            TriggerClientEvent('esx:showNotification', _source, 'You Have Purchased 1 Stock For $'..priceperstock)
            end
        else
            TriggerClientEvent('esx:showNotification', _source, 'This stock is bankrupt!')
        end
    else
    TriggerClientEvent('esx:showNotification', _source, 'No Stocks Left!')
    end
end)

---------------------------------------------
-----------------SellStocks------------------
---------------------------------------------
RegisterServerEvent('vn_stocks:sellstock')
AddEventHandler('vn_stocks:sellstock', function(stockname)
    print(stockname)
    local _source = source
    local identifier = PlayerIdentifier('steam', source)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT * FROM stocks WHERE name="'..stockname..'"', {}, function(stock)
        if stock ~= nil then
            if stock[1].price_per_stock > 0 then
                print(stock[1].price_per_stock)
                xPlayer.addMoney(stock[1].price_per_stock)
                MySQL.Async.execute('UPDATE stocks SET count = count + 1 WHERE name="'..stockname..'"', {})
                MySQL.Async.execute('UPDATE owned_stocks SET amt_owned = amt_owned - 1 WHERE owner="'..identifier..'" AND stockname="'..stockname..'"', {})
                TriggerClientEvent('esx:showNotification', _source, 'You sold one '..stockname..' stock for $'..stock[1].price_per_stock)
            else
                TriggerClientEvent('esx:showNotification', _source, 'You cannot sell a stock that has gone negative. Please wait.')
            end
        end
    end)
end)
 
---------------------------------------------
-----------------GetStocks-------------------
---------------------------------------------
RegisterServerEvent('vn_stocks:getStocks')
AddEventHandler('vn_stocks:getStocks', function(source, type)
    local Source = source
    print(type)
    print(source)
    MySQL.Async.fetchAll('SELECT * FROM stocks WHERE stock_type="'..type..'" ORDER BY name ASC', {}, function(stock)
            if stock ~= nil then
                for k,v in pairs(stock) do
                    TriggerClientEvent('vn_stocks:setStock',-1, stock[k].name, stock[k].count, stock[k].price_per_stock)
                end
            end
    end)
end)


---------------------------------------------
-----------------GetStocksForSale------------
---------------------------------------------
RegisterServerEvent('vn_stocks:getStockSale')
AddEventHandler('vn_stocks:getStockSale', function()
    local identifier = PlayerIdentifier('steam', source)
    MySQL.Async.fetchAll('SELECT * FROM owned_stocks WHERE owner ="'..identifier..'" ORDER BY stockname ASC', {}, function(stock)
            if stock ~= nil then
                for k,v in pairs(stock) do
                    TriggerClientEvent('vn_stocks:setStockSale',-1, stock[k].stockname, stock[k].amt_owned)
                end
            end
    end)
end)



---------------------------------------------
--------------GetStockPrices-----------------
---------------------------------------------
RegisterServerEvent('vn_stocks:getStockPrices')
AddEventHandler('vn_stocks:getStockPrices', function(source)
    local Source = source
    MySQL.Async.fetchAll('SELECT * FROM stocks ORDER BY name ASC', {}, function(stock)
            if stock ~= nil then
                for k,v in pairs(stock) do
                    TriggerClientEvent('vn_stocks:setStockPrice',-1, stock[k].name, stock[k].count, stock[k].price_per_stock, k)
                end
            end
    end)
end)
---------------------------------------------
--------------GetStocksOwned-----------------
---------------------------------------------
RegisterServerEvent('vn_stocks:getOwned')
AddEventHandler('vn_stocks:getOwned', function()
    local identifier = PlayerIdentifier('steam', source)
    local name = {}
    local stok = {}
    local amntown = {}
    local pps = {}
    local total = 0 
    MySQL.Async.fetchAll('SELECT * FROM owned_stocks WHERE owner ="'..identifier..'" ORDER BY stockname ASC', {}, function(stock)
            if stock ~= nil then
                for k,v in pairs(stock) do
                    name[k] = stock[k].stockname
                    amntown[k] = stock[k].amt_owned
                end
            end
    end)
    Citizen.Wait(120)
    MySQL.Async.fetchAll('SELECT * FROM stocks', {}, function(stocks)
            if stocks ~= nil then
               for k,v in pairs(stocks) do
                    stok[k] = stocks[k].name
                    pps[k] = stocks[k].price_per_stock
                end
            end
    end)
    Citizen.Wait(120)

    for i,j in pairs(name) do
        for k,v in pairs(stok) do
            if stok[k] == name[i] then
            total = pps[k] * amntown[i]
            TriggerClientEvent('vn_stocks:setStockOwned', -1, name[i], amntown[i], total, k)
            end
        end
    end


end)

---------------------------------------------
-------------BRAINS OF THIS------------------
---------------------------------------------
RegisterServerEvent('vn_stocks:newDay')
AddEventHandler('vn_stocks:newDay', function()
    local high = math.random(-10000.0, 10000.0)
    local high2 = math.random(-10000.0, 10000.0)
    local high3 = math.random(-10000.0, 10000.0)
    local high4 = math.random(-10000.0, 10000.0)
    print(high)
    local midhigh = math.random(-5000.0, 5000.0)
    local midhigh2 = math.random(-5000.0, 5000.0)
    local midhigh3 = math.random(-5000.0, 5000.0)
    local midhigh4 = math.random(-5000.0, 5000.0)
    print(midhigh)
    local midlow = math.random(-1000.0, 1000.0)
    local midlow2 = math.random(-1000.0, 1000.0)
    local midlow3 = math.random(-1000.0, 1000.0)
    local midlow4 = math.random(-1000.0, 1000.0)
    print(midlow)
    local low = math.random(-500.0, 500.0)
    local low2 = math.random(-500.0, 500.0)
    local low3 = math.random(-500.0, 500.0)
    local low4 = math.random(-500.0, 500.0)
    print(low)
    --highend
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..high..' WHERE name="Jet Blue"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..high2..' WHERE name="Binco"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..high3..' WHERE name="Piswasser"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..high4..' WHERE name="Raspberry Pi"', {})
    --midhigh
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..midhigh..' WHERE name="Virgin Air"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..midhigh2..' WHERE name="Suburban"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..midhigh3..' WHERE name="Cluck-N-Bell"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..midhigh4..' WHERE name="Leroys Electrical"', {})
    --midlow
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..midlow..' WHERE name="Delta"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..midlow2..' WHERE name="24/7"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..midlow3..' WHERE name="Burger Shot"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..midlow4..' WHERE name="ThriftEX"', {})
    --low
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..low..' WHERE name="American Air"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..low2..' WHERE name="Ace Liquor"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..low3..' WHERE name="Hearty Taco"', {})
    MySQL.Async.execute('UPDATE stocks SET price_per_stock = price_per_stock + '..low4..' WHERE name="Panoramic"', {})
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