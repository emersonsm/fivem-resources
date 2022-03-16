fx_version 'cerulean'
games { 'gta5' }

ui_page 'nui/character.html'

client_script 'client.lua'

server_scripts {
	'server.lua',
    '@mysql-async/lib/MySQL.lua',
}

files {
	'nui/character.html',
	'nui/character.js',
	'nui/character.css',
	'nui/img/background.png',
	'nui/fonts/Roboto-Regular.ttf',
	'nui/fonts/ConcertOne-Regular.ttf',
	'nui/fonts/stem.ttf'
}

dependencies {
	'functions',
	'art-base'
}