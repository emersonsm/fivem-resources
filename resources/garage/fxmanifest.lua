fx_version 'adamant'
games { 'gta5' }

ui_page 'nui/menu.html'

client_script 'client.lua'

server_scripts {
	'server.lua',
    '@mysql-async/lib/MySQL.lua',
}

files {
	'nui/menu.html',
	'nui/menu.js',
	'nui/menu.css',
	'nui/fonts/squada-one-regular.ttf',
	'nui/fonts/SourceSansPro-SemiBold.ttf'
}

dependency 'functions'