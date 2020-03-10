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

local stocktable                = {}
local stocks2                   = {}
local stocks3                   = {}
local stockprices               = {
                                    head = { ('Stock'), ('Price per Stock'), ('------') },
                                    rows = {}
                                  }
local stocksowned               = {
                                    head = { ('Name'), ('Amount Owned'), ('Total') },
                                    rows = {}
                                  }
ESX                             = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

------------------------------------------------------------------
-------------------------------------------------------------------
------------------------chat command /itsanewday-------------------
-------------------------------------------------------------------
RegisterCommand("itsanewday", function(source, args, raw)
TriggerServerEvent('vn_stocks:newDay')
end, false)

-------------------------------------------------------------------
-------------------------------------------------------------------
-----------------------------Blip for MAP--------------------------
-------------------------------------------------------------------
Citizen.CreateThread(function()

		local blip = AddBlipForCoord(144.11, -831.81, 30.16)

		SetBlipSprite (blip, 490)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.2)
		SetBlipColour (blip, 29)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Stock Market')
		EndTextCommandSetBlipName(blip)
end)

local stock_market = {
    {x = 144.11, y = -831.81, z = 31.16},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(stock_market) do
            DrawMarker(29, stock_market[k].x, stock_market[k].y, stock_market[k].z, 0, 0, 0, 2, 2, 2, 1.501, 1.501, 1.5001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(stock_market) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, stock_market[k].x, stock_market[k].y, stock_market[k].z)

            if dist <= 0.5 then
				hintToDisplay('Press ~INPUT_CONTEXT~ to open the ~b~Stock Market~w~')
				
				if IsControlJustPressed(0, Keys['E']) then
                    openMenu()
                    print('hello')
				end			
            end
        end
    end
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
------------------------------------------------------------------
-------------------------------------------------------------------
------------------------chat command /stocks-----------------------
-------------------------------------------------------------------
function openMenu()
--RegisterCommand("stocks", function(source, args, raw)
    local elements = {}
    ESX.UI.Menu.CloseAll()

-------------------------------------------------------------------
------------------------   Open Main Menu   -----------------------
-------------------------------------------------------------------

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'stock_info',
        {
        title    = '💰🔔Stock Market Menu🔔💰',
        align    = 'bottom-right',
        elements = {
            {label = 'Buy Stocks : 💲', value = 'stock_sales'},
            {label = 'Stock Values : 💱', value = 'stock_values'},
            {label = 'Stock Tips : 🔥', value = 'stock_tips'},
            {label = 'View My Stocks : 📰', value = 'stock_owned'},
            {label = 'Sell My Stocks : 📰', value = 'stock_sell'},
            --{label = _U(''), value = '')},
        },
        },
        function(data, menu)
            if data.current.value == 'stock_sales' then

-------------------------------------------------------------------
----------------------- Open Buy Stock Menu -----------------------
-------------------------------------------------------------------

                local elements = {
                    {label = 'Airlines : ✈', value = 'stock_airline'},
                    {label = 'Retail : 🏪', value = 'stock_retail'},
                    {label = 'Food/Drink : 🍴', value = 'stock_food'},
                    {label = 'Electronics : 📡', value = 'stock_electronics'},
                }
                ESX.UI.Menu.Open(
                    'default', GetCurrentResourceName(), 'stock_list',
                    {
                        title    = '💰🔔Stocks For Sale🔔💰',
                        align    = 'bottom-right',
                        elements = elements
                    }, function(data2, menu2)
                        if data2.current.value == 'stock_airline' then
                            local type = 'plane'
                            TriggerServerEvent('vn_stocks:getStocks', type)
                            Citizen.Wait(800)
                            

-------------------------------------------------------------------
-------------------- Open Airplane Stock Menu ---------------------
-------------------------------------------------------------------

                            ESX.UI.Menu.Open(
                                'default', GetCurrentResourceName(), 'stock_air',
                                {
                                    title    = '💰🔔Airline Stocks🔔💰',
                                    align    = 'bottom-right',
                                    elements = stocks2
                                }, function(data3, menu3)
                                    Citizen.Wait(500)
                                    stocks2 = {}
                                    local currentstock = data3.current.label
                                    local currentstockvalue = data3.current.price
                                    local currentstockamount = data3.current.amount
                                    if data3.current.value == 'Jet Blue' or data3.current.value == 'Virgin Air' or
                                    data3.current.value == 'American Air' or data3.current.value == 'Delta' then
                                        Citizen.Wait(500)
                                        local elements = {
                                            {label = 'Buy', value = 'Buy_Stock' },
                                           -- {label = 'Sell', value = 'Sell_Stock' },
                                            {label = 'Close', value = 'Close_Menu' },
                                        }
                                        ESX.UI.Menu.Open(
                                            'default', GetCurrentResourceName(), 'stock_buy_info',
                                            {
                                            title    = currentstock .. ' $'..currentstockvalue..' %'..currentstockamount,
                                            align    = 'bottom-right',
                                            elements = elements
                                            }, function(data4, menu4)
                                            
                                            if data4.current.value == 'Buy_Stock' then
                                               TriggerServerEvent('vn_stocks:buystock',currentstock)
                                               ESX.UI.Menu.CloseAll()  
                                              --Citizen.Wait(500)                                  
                                            elseif data4.current.value == 'Close_Menu' then
                                                ESX.UI.Menu.CloseAll()
                                                --Citizen.Wait(500)
                                            end
                                        end, function(data, menu)
                                            menu.close()
                                            stocks2 = {}
                                        end)
                                    end
                                end, function(data, menu)
                                    menu.close()
                                    stocks2 = {}
                                end)
                         elseif data2.current.value == 'stock_retail' then
-------------------------------------------------------------------
-------------------- Open Retail Stock Menu ---------------------
-------------------------------------------------------------------
                            local type = 'retail'
                            TriggerServerEvent('vn_stocks:getStocks', source, type)
                            Citizen.Wait(800)
                            ESX.UI.Menu.Open(
                                'default', GetCurrentResourceName(), 'stock_retail',
                                {
                                    title    = '💰🔔Retail Stocks🔔💰',
                                    align    = 'bottom-right',
                                    elements = stocks2
                                }, function(data3, menu3)
                                    Citizen.Wait(1000)
                                    stocks2 = {}
                                    local currentstock = data3.current.label
                                    local currentstockvalue = data3.current.price
                                    local currentstockamount = data3.current.amount
                                    if data3.current.value == '24/7' or data3.current.value == 'Ace Liquor' or
                                    data3.current.value == 'Binco' or data3.current.value == 'Suburban' then
                                        Citizen.Wait(1000)
                                        local elements = {
                                            {label = 'Buy', value = 'Buy_Stock' },
                                            {label = 'Close', value = 'Close_Menu' },
                                        }
                                        ESX.UI.Menu.Open(
                                            'default', GetCurrentResourceName(), 'stock_buy_info',
                                            {
                                                title    = currentstock .. ' $'..currentstockvalue..' %'..currentstockamount,
                                                align    = 'bottom-right',
                                                elements = elements
                                            }, function(data4, menu4)
                                            
                                            if data4.current.value == 'Buy_Stock' then
                                               TriggerServerEvent('vn_stocks:buystock',currentstock)
                                               --Citizen.Wait(500)
                                               ESX.UI.Menu.CloseAll()
                                            elseif data4.current.value == 'Close_Menu' then
                                                --Citizen.Wait(500)
                                                ESX.UI.Menu.CloseAll()
                                            end
                                        end, function(data, menu)
                                            menu.close()
                                            stocks2 = {}
                                        end)
                                    end
                                end, function(data, menu)
                                    menu.close()
                                    stocks2 = {}
                                end)
                            elseif data2.current.value == 'stock_food' then
-------------------------------------------------------------------
-------------------- Open Food/Drink Stock Menu ---------------------
-------------------------------------------------------------------
                            
                                local type = 'food'
                                TriggerServerEvent('vn_stocks:getStocks', source, type)
                                Citizen.Wait(1000)
                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stock_food',
                                    {
                                        title    = '💰🔔Food/Drink Stocks🔔💰',
                                        align    = 'bottom-right',
                                        elements = stocks2      
                                    }, function(data3, menu3)
                                Citizen.Wait(1000)
                                local currentstock = data3.current.label
                                local currentstockvalue = data3.current.price
                                local currentstockamount = data3.current.amount
                                if data3.current.value == 'Piswasser' or data3.current.value == 'Cluck-N-Bell' or
                                    data3.current.value == 'Burger Shot' or data3.current.value == 'Hearty Taco' then
                                    Citizen.Wait(1000)
                                    stocks2 = {}
                                    local elements = {
                                        {label = 'Buy', value = 'Buy_Stock' },
                                        {label = 'Close', value = 'Close_Menu' },
                                        }
                                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stock_buy_info',
                                        {
                                        title    = currentstock .. ' $'..currentstockvalue..' %'..currentstockamount,
                                        align    = 'bottom-right',
                                        elements = elements
                                        }, function(data4, menu4)
                                        if data4.current.value == 'Buy_Stock' then
                                            TriggerServerEvent('vn_stocks:buystock',currentstock)
                                            ESX.UI.Menu.CloseAll()                                        
                                        elseif data4.current.value == 'Close_Menu' then
                                            ESX.UI.Menu.CloseAll()
                                        end
                                    end, function(data, menu)
                                        menu.close()
                                        stocks2 = {}
                                    end)
                                end
                            end, function(data, menu)
                                menu.close()
                                stocks2 = {}
                            end)
                        elseif data2.current.value == 'stock_electronics' then
-------------------------------------------------------------------
-------------------- Open Electronics Stock Menu ------------------
-------------------------------------------------------------------
                            
                            local type = 'electronics'
                            TriggerServerEvent('vn_stocks:getStocks', source, type)
                            Citizen.Wait(800)
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stock_electronics',
                                {
                                title    = '💰🔔Electronics Stocks🔔💰',
                                align    = 'bottom-right',
                                elements = stocks2
                                }, function(data3, menu3)
                            Citizen.Wait(1000)
                            local currentstock = data3.current.label
                            local currentstockvalue = data3.current.price
                            local currentstockamount = data3.current.amount
                            if data3.current.value == 'Raspberry Pi' or data3.current.value == 'Leroys Electrical' or
                                data3.current.value == 'ThriftEX' or data3.current.value == 'Panoramic' then
                                Citizen.Wait(1000)
                                stocks2 = {}
                                local elements = {
                                    {label = 'Buy', value = 'Buy_Stock' },
                                    {label = 'Close', value = 'Close_Menu' },
                                    }
                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stock_buy_info',
                                    {
                                    title    = currentstock .. ' $'..currentstockvalue..' %'..currentstockamount,
                                    align    = 'bottom-right',
                                    elements = elements
                                    }, function(data4, menu4)
                
                                    if data4.current.value == 'Buy_Stock' then
                                        TriggerServerEvent('vn_stocks:buystock', currentstock)
                                        Citizen.Wait(500)
                                        ESX.UI.Menu.CloseAll()                                    
                                    elseif data4.current.value == 'Close_Menu' then
                                        Citizen.Wait(500)
                                        ESX.UI.Menu.CloseAll()
                                    end
                                end, function(data, menu)
                                    menu.close()
                                    stocks2 = {}
                                end)
                            end
                        end, function(data, menu)
                            menu.close()
                            stocks2 = {}
                        end)
                    end     
                end, function(data, menu)
                    menu.close()
                    stocks2 ={}
                end)

-------------------------------------------------------------------
-------------------- Open Stock Values ----------------------------
-------------------------------------------------------------------

            elseif data.current.value == 'stock_values' then
                TriggerServerEvent('vn_stocks:getStockPrices')
                Citizen.Wait(500)
                    table.insert(stockprices.rows, {
                        data = "Test4",
                        cols = {
                            " ",
                            " ",
                            '{{' .. ('Back') .. '|button1}} {{' .. ('Quit') .. '|button2}}'
                        }
                    })
                    
                    ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'testmenu', stockprices, function(data2, menu2)
                        if data2.value == 'button1' then
                            stockprices = {
                                head = { ('Stock'), ('Price per Stock'), ('------') },
                                rows = {}
                            }
                            menu2.close()
                        elseif data2.value == 'button2' then
                            stockprices = {
                                head = { ('Stock'), ('Price per Stock'), ('------') },
                                rows = {}
                            }
                            ESX.UI.Menu.CloseAll()
                        end
                    
                    end, function(data2, menu2)
                        menu2.close()
                    end)

-------------------------------------------------------------------
-------------------- Open Stock Tips ------------------------------
-------------------------------------------------------------------
            elseif data.current.value == 'stock_tips' then
                ESX.UI.Menu.CloseAll()

-------------------------------------------------------------------
-------------------- Open Owned Stocks ----------------------------
-------------------------------------------------------------------

            elseif data.current.value == 'stock_owned' then   
                stocksowned = {
                    head = { ('Name'), ('Amount Owned'), ('Total') },
                    rows = {}
                }  
                TriggerServerEvent('vn_stocks:getOwned')                
                Citizen.Wait(1000)
                table.insert(stocksowned.rows, {
                    data = "last",
                    cols = {
                        " ",
                        " ",
                        '{{' .. ('Back') .. '|button1}} {{' .. ('Quit') .. '|button2}}'
                    }
                })
                
                ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'stocksowned', stocksowned, function(data3, menu3)
                    if data3.value == 'button1' then
                        menu3.close()
                        stocksowned = {
                            head = { ('Name'), ('Amount Owned'), ('Total') },
                            rows = {}
                        }
                    elseif data3.value == 'button2' then
                        stocksowned = {
                            head = { ('Name'), ('Amount Owned'), ('Total') },
                            rows = {}
                        }
                        ESX.UI.Menu.CloseAll()
                    end
                end, function(data3, menu3)
                    menu3.close()
                end)

                
            elseif data.current.value == 'stock_sell' then 
                stocks2 = {}
                TriggerServerEvent('vn_stocks:getStockSale')                
                Citizen.Wait(1000)
                
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stock_sales',
                {
                title    = '💰🔔Owned Stocks🔔💰',
                align    = 'bottom-right',
                elements = stocks3
                }, function(data2, menu2)
                    stocks3 = {}
                    ESX.UI.Menu.CloseAll()
                    TriggerServerEvent('vn_stocks:sellstock', data2.current.value)
                end, function(data2, menu2)
                    menu2.close()
                    stocks3 = {}
                end)
            end 
    end, function(data, menu)
        menu.close()
    end)
end
--, false)
                

-------------------------------------------------------------------
-------------------- Set Stock -----------------------------------
-------------------------------------------------------------------
RegisterNetEvent('vn_stocks:setStock')
AddEventHandler('vn_stocks:setStock', function(stockName, stockCount, stockPrice)
    table.insert(stocks2, {label = stockName, value = stockName, amount = stockCount, price = stockPrice})
end)

-------------------------------------------------------------------
-------------------- Set Stock Sale -----------------------------------
-------------------------------------------------------------------
RegisterNetEvent('vn_stocks:setStockSale')
AddEventHandler('vn_stocks:setStockSale', function(stockName, stockNum)
    if stockNum > 0 then 
    table.insert(stocks3, {label = 'Stock: '..stockName..' | Quantity: '..stockNum, value = stockName, amount = stockNum})
    else
        --ESX.ShowNotification()
    end
end)

-------------------------------------------------------------------
-------------------- Set Stock Price------------------------------
-------------------------------------------------------------------
RegisterNetEvent('vn_stocks:setStockPrice')
AddEventHandler('vn_stocks:setStockPrice', function(stockName, stockCount, stockPrice, num)
    table.insert(stockprices.rows, {
        data = "Test"..num,
        cols = {
            stockName,
            stockPrice,
            stockCount
            }
    })
end)

-------------------------------------------------------------------
-------------------- Set Stock Owned------------------------------
-------------------------------------------------------------------
RegisterNetEvent('vn_stocks:setStockOwned')
AddEventHandler('vn_stocks:setStockOwned', function(stockName, stockAmntOwned, total, num)
    if num == nil then
        num = 1
    end

    if stockAmntOwned > 0 then 
        table.insert(stocksowned.rows, {
            data = "Test"..num,
            cols = {
                stockName,
                stockAmntOwned,
                total
                }
        })
    end
end)
