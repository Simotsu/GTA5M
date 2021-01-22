------ MADE BY AMMAR B. ------
------------------------------
isMod = true
isAdmin = true
isEMS = true
--------------------------------------------------
----------------REGISTERING EVENTS----------------
--------------------------------------------------

RegisterServerEvent('DeathScript:AdminReturn')


--------------------------------------------------
---------------REGISTERING  COMMAND---------------
--------------------------------------------------
----------------CIVILIAN  COMMANDS----------------
--------------------------------------------------

RegisterCommand('togds', function(source, args, rawCommand)
    if isAdmin then
    TriggerClientEvent('DeathScript:Toggle', -1)
    end
end, true)

RegisterCommand('revive', function(source, args, rawCommand)
   TriggerClientEvent('DeathScript:Revive', source) 
end, false)

RegisterCommand('respawn', function(source, args, rawCommand)
    TriggerClientEvent('DeathScript:Respawn', source) 
end, false)



--------------------------------------------------
---------------REGISTERING  COMMAND---------------
--------------------------------------------------
------------------ADMIN COMMANDS------------------
--------------------------------------------------

RegisterCommand('adrev', function(source, args, rawCommand)
    if isAdmin or isMod then
    if #args == 1 then
        if tonumber(args[1]) then
            local target = tonumber(args[1])
            if GetPlayerName(target) then
                TriggerClientEvent('DeathScript:Revive', target, true, source, false)
            else
                TriggerClientEvent("DeathScript:ShowNotification", source, "~r~Invalid ID~n~/adrev ID")
            end
        else
            TriggerClientEvent("DeathScript:ShowNotification", source, "~r~Player ID must be a number~n~/adrev ID")
        end
    else
        TriggerClientEvent('DeathScript:Revive', source, true) 
    end
else 
    TriggerEvent("DeathScriptAdminCheck")
end
 end, true)

 RegisterCommand('emsrev', function(source, args, rawCommand)
if isEMS then
    if #args == 1 then
        if tonumber(args[1]) then
            local target = tonumber(args[1])
            if GetPlayerName(target) then
                TriggerClientEvent('DeathScript:Revive', target, true, source, false)
            else
                TriggerClientEvent("DeathScript:ShowNotification", source, "~r~Invalid ID~n~/adrev ID")
            end
        else
            TriggerClientEvent("DeathScript:ShowNotification", source, "~r~Player ID must be a number~n~/adrev ID")
        end
    end
end

 end, true)




 RegisterCommand('adrevall', function(source, args, rawCommand)
    if isAdmin then
    TriggerClientEvent('DeathScript:Revive', -1, true, source, true)
    end
 end, true)

RegisterCommand('adres', function(source, args, rawCommand)
    if isAdmin or isMod then
    if #args == 1 then
        if tonumber(args[1]) then
            local target = tonumber(args[1])
            if GetPlayerName(target) then
                TriggerClientEvent('DeathScript:Respawn', target, true, source, false)
            else
                TriggerClientEvent("DeathScript:ShowNotification", source, "~r~Invalid ID~n~/adres ID")
            end
        else
            TriggerClientEvent("DeathScript:ShowNotification", source, "~r~Player ID must be a number~n~/adres ID")
        end
    else
        TriggerClientEvent('DeathScript:Respawn', source, true) 
    end
end
end, true)

RegisterCommand('adresall', function(source, args, rawCommand)
    if isAdmin then
    TriggerClientEvent('DeathScript:Respawn', -1, true, source, true)
    end
end, true)

RegisterCommand('deathtoggle', function(source, args, rawCommand)
    if isAdmin then
    TriggerClientEvent('DeathScript:Toggle', -1, args[1])
    end
end, true)


AddEventHandler('DeathScript:AdminReturn', function(msg, id)
    TriggerClientEvent("DeathScript:ShowNotification", source, msg)
end)

RegisterServerEvent('DeathScriptAdminCheck')
AddEventHandler('DeathScriptAdminCheck', function()

    local identifier = getPlayerID(source)

    local src = source
    local roles = exports.Badger_Discord_API:GetDiscordRoles(src)
    if not roles then
    else
        for i = 1, #roles do  
        --726501463240605717 MOD
        --726501463240605718 Admin
        --726501463240605719 Senior Admin
            if roles[i] == "726501463240605717" then --mod 
            isMod = true
         --   return isMod
         goto done
            elseif roles[i] == "726501463240605718" or roles[i] == "726501463240605719" or roles[i] == "726501463244931093" or roles[i] == "726501463240605723" then -- admin / sr admin
            isAdmin = true
           -- return isAdmin
           goto done
            else 
                isAdmin = false
                isMod = false
            end
        end
    end
    ::done::
end)

RegisterServerEvent('DeathScriptESCheck')
AddEventHandler('DeathScriptESCheck', function()

    local identifier = getPlayerID(source)

    local src = source
    local roles = exports.Badger_Discord_API:GetDiscordRoles(src)
    if not roles then
    else
        for i = 1, #roles do  
        --726501463240605717 MOD
        --726501463240605718 Admin
        --726501463240605719 Senior Admin
            if roles[i] == "726501463232348170" then --ES
            isEMS = true
         --   return isMod
         goto done
            else 
                isEMS = false
            end
        end
    end
    ::done::
end)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end