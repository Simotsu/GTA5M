isMod = false
isAdmin = false
isEMT = false

	AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
			args = { name, message }
		})
		--TriggerClientEvent('chat:addMessage', -1, { args = { '**📃OOC: **' .. name, message }, color = { 128, 128, 128 } })
		TriggerEvent('DiscordBot:ToDiscord', 'chat', steam,'**📃OOC: **' ..name..'" "'..message, 'logoimageurl', true)
	end
end)

RegisterCommand('ooc', function(source, args, rawCommand)
    local name = GetPlayerName(source)
    local msg = rawCommand:sub(5)

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-user-minus"></i> {0}:<br> {1}</div>',
		args = { name, msg }
	})
end, false)

RegisterCommand('ad', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	--print(args)
	local name = GetPlayerName(source)
	local steam = GetPlayerName(source)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(214, 168, 0, 1); border-radius: 3px;"><i class="fas fa-ad"></i> Advertisement:<br> {1}<br></div>',
        args = { name, args }
    })
	--TriggerClientEvent('chat:addMessage', -1, { args = { '🛍️Advertisement🛍️ ' .. name, args }, color = { 255, 255, 51 } })
	TriggerEvent('DiscordBot:ToDiscord', 'chat', steam,'**🛍️AD: **' .. args, 'logoimageurl', true)
end, false)

RegisterCommand('adname', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	local steam = GetPlayerName(source)
	local word = args
	local words = {}
	words[1], words[2] = args:match("(%w+)(.+)")	

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(214, 168, 0, 1); border-radius: 3px;"><i class="fas fa-ad"></i> {0}:<br> {1}<br></div>',
        args = { words[1], words[2] }
    })
	--TriggerClientEvent('chat:addMessage', -1, { args = { '🛍️Advertisement🛍️ ' .. words[1].. " ", words[2] }, color = { 255, 255, 51 } })
end, false)

RegisterCommand('esbroadcast', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	TriggerEvent('ESCheck')
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	local steam = GetPlayerName(source)
if isEMT then
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-image: linear-gradient( to bottom, red, blue); border-radius: 3px;"><center><i class="fas fa-bullhorn"></i> <i class="fas fa-shield-alt"></i>   Emergency Services Broadcast   <i class="fas fa-shield-alt"></i> <i class="fas fa-bullhorn"></i></center><br> {0}<br></div>',
        args = { args }
	})
else
	isEMT = 'EMT'
	TriggerClientEvent('addMessage', source, isEMT)
end

end, false)

RegisterCommand('admin', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
TriggerEvent('AdminCheck')
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	local steam = GetPlayerName(source)
if isAdmin or isMod then
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 1); border-radius: 3px;"><center><i class="fas fa-exclamation-triangle"></i>   **SERVER ANNOUNCEMENT**   <i class="fas fa-exclamation-triangle"></i></center><br> {0}<br></div>',
        args = { args }
	})
else
isAdmin = 'ADMIN'
	TriggerClientEvent('addMessage', source, isAdmin)
end

end, false)

RegisterCommand('me2', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	local steam = GetPlayerName(source)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(232, 126, 4, 0.4); border-radius: 3px;"> <i class="far fa-user"></i> {0}:<br> {1}<br></div>',
        args = { name, args }
    })

end, false)

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
isMe = 'isMe'
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	local steam = GetPlayerName(source)

	TriggerClientEvent('sendProximityMessage', -1, source, name, args, isMe)

end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
isDo = 'isDo'
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	local steam = GetPlayerName(source)

	TriggerClientEvent('sendProximityMessage', -1, source, name, args, isDo)
end, false)

RegisterCommand('twt', function(source, args, rawCommand)
	if source == 0 then
	--	print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	local steam = GetPlayerName(source)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
        args = { name, args }
    })
	--TriggerClientEvent('chat:addMessage', -1, { args = { '🐦^4Twitter Alert🐦| @' ..name.. ' ', args }, color = { 135, 64, 153 } })

end, false)

RegisterCommand('twtanon', function(source, args, rawCommand)
	if source == 0 then
	--	print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	local steam = GetPlayerName(source)
	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @Anonymous <i class="fas fa-user-secret"></i>:<br> {1}</div>',
        args = { name, args }
    })
--	TriggerClientEvent('chat:addMessage', -1, { args = { '🐦❓^4Twitter Alert❓🐦| @Anonymous:', args }, color = { 135, 64, 153 } })
end, false)



RegisterServerEvent('AdminCheck')
AddEventHandler('AdminCheck', function()

    local identifier = getPlayerID(source)

    local src = source
    local roles = exports.Badger_Discord_API:GetDiscordRoles(src)
    if not roles then
    else
        for i = 1, #roles do  
        --726501463240605717 MOD
        --726501463240605718 Admin
		--726501463240605719 Senior Admin
		--726501463240605723 
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

RegisterServerEvent('ESCheck')
AddEventHandler('ESCheck', function()

    local identifier = getPlayerID(source)

    local src = source
    local roles = exports.Badger_Discord_API:GetDiscordRoles(src)
    if not roles then
    else
        for i = 1, #roles do  
			--726501463232348170 ES ROLE
            if roles[i] == "726501463232348170" then --EMT 
            isEMT = true
         --   return isEMT
         goto done
            else 
              isEMT = false
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