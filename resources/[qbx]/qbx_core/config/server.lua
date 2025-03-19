return {
    -- 玩家数据更新的时间间隔，单位为分钟
    updateInterval = 5, 

    money = {
        ---@alias MoneyType 'cash' | 'bank' | 'crypto'
        ---@alias Money {cash: number, bank: number, crypto: number}
        ---@type Money
        -- 每种货币类型的初始金额。可根据服务器需求添加或移除货币类型（例如添加 blackmoney = 0），
        -- 注意：一旦添加，该货币类型不会从数据库中移除！
        moneyTypes = { cash = 500, bank = 5000, crypto = 0 }, 
        -- 不允许余额为负的货币类型
        dontAllowMinus = { 'cash', 'crypto' }, 
        -- 发放薪水的时间间隔，单位为分钟
        paycheckTimeout = 10, 
        -- 若为 true，薪水将从玩家所在的社团账户发放
        paycheckSociety = false 
    },

    player = {
        -- 饥饿值下降的速率
        hungerRate = 4.2, 
        -- 口渴值下降的速率
        thirstRate = 3.8, 

        ---@enum BloodType
        -- 玩家的血型类型
        bloodTypes = {
            'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
        },

        ---@alias UniqueIdType 'citizenid' | 'AccountNumber' | 'PhoneNumber' | 'FingerId' | 'WalletId' | 'SerialNumber'
        ---@type table<UniqueIdType, {valueFunction: function}>
        -- 玩家唯一标识符的类型及生成函数
        identifierTypes = {
            citizenid = {
                -- 生成公民 ID 的函数
                valueFunction = function()
                    return lib.string.random('A.......')
                end,
            },
            AccountNumber = {
                -- 生成银行账户号码的函数
                valueFunction = function()
                    return 'US0' .. math.random(1, 9) .. 'QBX' .. math.random(1111, 9999) .. math.random(1111, 9999) .. math.random(11, 99)
                end,
            },
            PhoneNumber = {
                -- 生成电话号码的函数
                valueFunction = function()
                    return math.random(100,999) .. math.random(1000000,9999999)
                end,
            },
            FingerId = {
                -- 生成指纹 ID 的函数
                valueFunction = function()
                    return lib.string.random('...............')
                end,
            },
            WalletId = {
                -- 生成钱包 ID 的函数
                valueFunction = function()
                    return 'QB-' .. math.random(11111111, 99999999)
                end,
            },
            SerialNumber = {
                -- 生成序列号的函数
                valueFunction = function()
                    return math.random(11111111, 99999999)
                end,
            },
        }
    },

    ---@alias TableName string
    ---@alias ColumnName string
    ---@type [TableName, ColumnName][]
    -- 角色数据存储的表名及对应的列名，当角色被删除时，这些表中对应的数据将被删除
    characterDataTables = {
        {'properties', 'owner'},
        {'bank_accounts_new', 'id'},
        {'playerskins', 'citizenid'},
        {'player_mails', 'citizenid'},
        {'player_outfits', 'citizenid'},
        {'player_vehicles', 'citizenid'},
        {'player_groups', 'citizenid'},
        {'players', 'citizenid'},
        {'npwd_calls', 'identifier'},
        {'npwd_darkchat_channel_members', 'user_identifier'},
        {'npwd_marketplace_listings', 'identifier'},
        {'npwd_messages_participants', 'participant'},
        {'npwd_notes', 'identifier'},
        {'npwd_phone_contacts', 'identifier'},
        {'npwd_phone_gallery', 'identifier'},
        {'npwd_twitter_profiles', 'identifier'},
        {'npwd_match_profiles', 'identifier'},
    }, -- 角色被删除时要删除的行

    server = {
        -- 启用或禁用服务器上的 PVP（射击其他玩家的能力）
        pvp = true, 
        -- 设置服务器为关闭状态（除了拥有 'qbadmin.join' ACE 权限的人，其他人无法加入）
        closed = false, 
        -- 当人们无法加入服务器时显示的原因消息
        closedReason = 'Server Closed', 
        -- 启用或禁用服务器的白名单
        whitelist = false, 
        -- 白名单开启时能够进入服务器的权限
        whitelistPermission = 'admin', 
        -- Discord 邀请链接
        discord = '', 
        -- 加入时检查是否有重复的 Rockstar 许可证
        checkDuplicateLicense = true, 
        ---@deprecated 使用 cfg ACE 系统代替
        -- 在 server.cfg 中创建组后，可以在此处添加任意数量的组
        permissions = { 'god', 'admin', 'mod' }, 
    },

    characters = {
        -- 根据 Rockstar 许可证定义玩家角色的最大数量（可以在服务器数据库的玩家表中找到此许可证）
        playersNumberOfCharacters = { 
            ['license2:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'] = 5,
        },

        -- 定义默认角色的最大数量（默认定义最多 3 个角色）
        defaultNumberOfCharacters = 3, 
    },

    -- 此配置仅适用于核心事件。将其他 Webhook 放在此处无效
    logging = {
        webhook = {
            -- 默认 Webhook
            ['default'] = nil, 
            -- 玩家加入/离开事件的 Webhook
            ['joinleave'] = nil, 
            -- OOC 事件的 Webhook
            ['ooc'] = nil, 
            -- 反作弊事件的 Webhook
            ['anticheat'] = nil, 
            -- 玩家金钱事件的 Webhook
            ['playermoney'] = nil, 
        },
        -- 高优先级日志要标记的角色。角色使用 <@%roleid>，用户/频道使用 <@userid/channelid>
        role = {} 
    },

    -- 给玩家车辆钥匙的函数
    giveVehicleKeys = function(src, plate, vehicle)
        return exports.qbx_vehiclekeys:GiveKeys(src, vehicle)
    end,

    -- 获取社团账户的函数
    getSocietyAccount = function(accountName)
        return exports['Renewed-Banking']:getAccountMoney(accountName)
    end,

    -- 从社团账户移除资金的函数
    removeSocietyMoney = function(accountName, payment)
        return exports['Renewed-Banking']:removeAccountMoney(accountName, payment)
    end,

    --- 薪水发放函数
    ---@param player Player 玩家对象
    ---@param payment number 支付金额
    sendPaycheck = function (player, payment)
        -- 给玩家银行账户添加资金
        player.Functions.AddMoney('bank', payment)
        -- 通知玩家收到薪水
        Notify(player.PlayerData.source, locale('info.received_paycheck', payment))
    end,
}
