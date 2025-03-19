return {





    -- 检查饥饿/口渴状态的时间间隔（秒），若状态为 0 则扣除生命值
    statusIntervalSeconds = 5,
    -- ox_lib 加载模型的等待时间（毫秒），超时将抛出错误，适用于低配置电脑
    loadingModelsTimeout = 30000,
    -- 按下 ESC 键时地图上方显示的文本。若留空则显示 'FiveM'
    pauseMapText = 'Powered by Qbox',
    characters = {




        -- 是否使用外部角色管理资源。（若为 true，则禁用核心内的角色管理功能）
        useExternalCharacters = false,
        -- 玩家是否能够自行删除角色
        enableDeleteButton = false,
        -- 若设置为 false，则跳过初始公寓选择（若为 true，则需要 qbx_spawn 资源）
        startingApartment = true,
        dateFormat = 'YYYY-MM-DD',





        -- 必须与 dateFormat 配置的格式相同
        dateMin = '1900-01-01',
        -- 必须与 dateFormat 配置的格式相同
        dateMax = '2006-12-31',
        -- 若设置为 false，则允许玩家在国籍字段中输入任意内容（若要编辑国籍列表，请查看 data/nationalities.lua 文件）
        limitNationalities = true,
        profanityWords = {
            ['bad word'] = true
        },


        -- 多角色的生成位置，这些位置将随机选择
        locations = {
            {
                pedCoords = vec4(969.25, 72.61, 116.18, 276.55),
                camCoords = vec4(972.2, 72.9, 116.68, 97.27),
            },
            {
                pedCoords = vec4(1104.49, 195.9, -49.44, 44.22),
                camCoords = vec4(1102.29, 198.14, -48.86, 225.07),
            },
            {
                pedCoords = vec4(-2163.87, 1134.51, -24.37, 310.05),
                camCoords = vec4(-2161.7, 1136.4, -23.77, 131.52),
            },
            {
                pedCoords = vec4(-996.71, -68.07, -99.0, 57.61),
                camCoords = vec4(-999.90, -66.30, -98.45, 241.68),
            },
            {
                pedCoords = vec4(-1023.45, -418.42, 67.66, 205.69),
                camCoords = vec4(-1021.8, -421.7, 68.14, 27.11),
            },
            {
                pedCoords = vec4(2265.27, 2925.02, -84.8, 267.77),
                camCoords = vec4(2268.24, 2925.02, -84.36, 90.88),
            },
            {
                pedCoords = vec4(-1004.5, -478.51, 50.03, 28.19),
                camCoords = vec4(-1006.36, -476.19, 50.50, 210.38),
            }
        },
    },

    discord = {







        -- 是否启用内置的 Discord 丰富状态显示
        enabled = false,
        -- 应用程序 ID（请替换为你自己的 ID）
        appId = '1024981890798731345',
        -- 若要设置此功能，请访问 https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686
        largeIcon = {
            -- 此处需填写 '大' 图标的图像名称
            icon = 'duck',
            -- 此处可添加 '大' 图标的悬停文本
            text = 'Qbox Ducky',
        },

        smallIcon = {



            -- 此处需填写 '小' 图标的图像名称
            icon = 'logo_name',
            -- 此处可添加 '小' 图标的悬停文本
            text = 'This is a small icon with text',
        },

        firstButton = {
            text = 'Qbox Discord',
            link = 'https://discord.gg/Z6Whda5hHA',
        },

        secondButton = {
            text = 'Main Website',
            link = 'https://www.qbox.re/',
        }
    },

    --- Only used by QB bridge
    hasKeys = function(plate, vehicle)
        return exports.qbx_vehiclekeys:HasKeys(vehicle)
    end,
}
