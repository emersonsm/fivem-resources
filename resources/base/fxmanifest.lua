fx_version 'cerulean'
games { 'gta5' }

client_scripts {
	'core/client.lua',
	'blips/client.lua',
	'gameplay/client.lua'
}

exports {
	'SetVar',
	'GetVar'
}

server_scripts {
	'core/server.lua',
    '@mysql-async/lib/MySQL.lua'
}

dependency 'functions'