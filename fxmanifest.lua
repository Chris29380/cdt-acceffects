--[[ Manifest ]]--
fx_version   'cerulean'
use_experimental_fxv2_oal 'no'
lua54        'yes'
games        {'gta5'}

author 'cdtdevfivem'
discord 'https://discord.gg/ae2jAmtQsm'
description 'Accident Effect'
version '1.0.0'

dependencies {
    'cdt-lib',
}

shared_scripts {
    '@es_extended/imports.lua',
    'shared/*.lua'
}
    
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}

-------------------------------------------------------------------
--- CDT Dev Fivem -------------------------------------------------
--- If you have any questions, you can join my discord :
--- https://dicord.gg/ae2jAmtQsm
-------------------------------------------------------------------