client_scripts { 
    'config.lua',
    'client.lua'
}

server_scripts { 
    'config.lua',
    'server.lua',
    '@mysql-async/lib/MySQL.lua'
}

--server_script '@mysql-async/lib/MySQL.lua'