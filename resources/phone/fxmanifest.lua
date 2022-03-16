fx_version 'adamant'
games { 'gta5' }

ui_page 'nui/phone.html'

client_script 'client.lua'

server_scripts {
	'server.lua',
    '@mysql-async/lib/MySQL.lua',
}

files {
	'nui/phone.html',
	'nui/all.min.css',
	'nui/phone.js',
	'nui/phone.css',
	'nui/img/phone.png',
	'nui/img/phone-bg.png',
	'nui/svg/police.svg',
	'nui/fonts/Roboto-Regular.ttf',
	'nui/fonts/Roboto-Medium.ttf',
	'nui/webfonts/fa-brands-400.eot',
	'nui/webfonts/fa-brands-400.svg',
	'nui/webfonts/fa-brands-400.ttf',
	'nui/webfonts/fa-brands-400.woff',
	'nui/webfonts/fa-brands-400.woff2',
	'nui/webfonts/fa-regular-400.eot',
	'nui/webfonts/fa-regular-400.svg',
	'nui/webfonts/fa-regular-400.ttf',
	'nui/webfonts/fa-regular-400.woff',
	'nui/webfonts/fa-regular-400.woff2',
	'nui/webfonts/fa-solid-900.eot',
	'nui/webfonts/fa-solid-900.svg',
	'nui/webfonts/fa-solid-900.ttf',
	'nui/webfonts/fa-solid-900.woff',
	'nui/webfonts/fa-solid-900.woff2',
	'nui/js/jquery-ui.min.js'
}

dependency 'functions'