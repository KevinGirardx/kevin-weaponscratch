
fx_version 'cerulean'

author 'KevinGirardx'

game 'gta5'

shared_script {
	'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua',
}

lua54 'yes'

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/app.js',
    'html/images/*.png',
    'html/images/*.jpg'
}
escrow_ignore { 
    'client/*.lua',
    'server/*.lua',
    'config.lua',
}