fx_version 'cerulean'
game 'gta5'

description 'QBX_Vineyard'
repository 'https://github.com/Qbox-project/qbx_vineyard'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
}

server_scripts {
    'server/main.lua'
}

client_scripts {
    'client/main.lua'
}

files {
    'config/client.lua',
    'config/shared.lua',
    'locales/*.json'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
ox_lib 'locale'