RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message, who)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  print(who)
  if pid == myId then
    if who == 'isDo' then
      TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.5vw; margin: 0.5vw;background-color: rgba(232, 40, 4, 0.4); border-radius: 3px;"> <i class="fas fa-running"></i> {0}:<br> {1}</div>',
        args = {name, message}
      })
    else
      TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.5vw; margin: 0.5vw;background-color: rgba(232, 126, 4, 0.4); border-radius: 3px;"> <i class="far fa-user"></i> {0}:<br> {1}</div>',
        args = {name, message}
      })
    end

  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) > 0.001 then
    if who == 'isDo' then
      TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.5vw; margin: 0.5vw;background-color: rgba(232, 40, 4, 0.4); border-radius: 3px;"> <i class="fas fa-running"></i> {0}:<br> {1}</div>',
        args = {name, message}
      })
    else
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(232, 126, 4, 0.4); border-radius: 3px;"> <i class="far fa-user"></i> {0}:<br> {1}</div>',
      args = {name, message}
    })
  end
  end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  end
end)

RegisterNetEvent('addMessage')
AddEventHandler('addMessage', function(where)
  print('ok')
  if where == 'isEMT' then
  ShowNotification('~r~You must be a member of the Emergency Services to use that!')
  elseif where == 'ADMIN' then
    ShowNotification('~r~You must be an Admin or a Mod to use that!')
  end
end)

function ShowNotification(message)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(message)
  DrawNotification(true, false)
end