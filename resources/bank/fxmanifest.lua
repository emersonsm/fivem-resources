fx_version 'adamant'
games { 'gta5' }

ui_page 'nui/bank.html'

client_script 'client.lua'

server_scripts {
	'server.lua',
    '@mysql-async/lib/MySQL.lua',
}

files {
	'nui/bank.html',
	'nui/bank.js',
	'nui/bank.css',
	'nui/img/logo-top.png',
	'nui/fonts/Bitter-Regular.ttf',
	'nui/fonts/ChaletComprime-CologneEighty.otf',
}

dependency 'functions'
dependency 'art-taskbar'