-- 替换为你的 KOOK Webhook 地址
local KOOK_WEBHOOK_URL = "https://www.kookapp.cn/api/v3/message/send-pipemsg?access_token=x_X7040e_WPcmhCiV9Hs_9pA"

-- 获取当前时间的函数
local function getCurrentTime()
    local timestamp = os.time()
    return os.date("%Y-%m-%d %H:%M:%S", timestamp)
end

-- 发送日志到 KOOK 的函数
local function sendLogToKook(message)
    PerformHttpRequest(KOOK_WEBHOOK_URL, function(err, text, headers)
        if err ~= 200 then
            print("Failed to send log to KOOK: " .. tostring(err))
        end
    end, 'POST', json.encode({
        content = message
    }), {
        ['Content-Type'] = 'application/json'
    })
end

-- 监听玩家连接事件
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local currentTime = getCurrentTime()
    local logMessage = string.format("[%s] %s 已连接到服务器。", currentTime, name)
    sendLogToKook(logMessage)
end)

-- 监听玩家断开连接事件
AddEventHandler('playerDropped', function(reason)
    local currentTime = getCurrentTime()
    local playerId = source
    local identifiers = GetPlayerIdentifiers(playerId)
    local steamId = ""
    for _, id in ipairs(identifiers) do
        if string.find(id, "steam:") then
            steamId = id:gsub("steam:", "")
            local steamDec = tostring(tonumber(steamId, 16))
            steamId = "https://steamcommunity.com/profiles/" .. steamDec
            break
        end
    end

    local logMessage = string.format("[%s] 玩家 ID: %s，玩家 %s 已断开连接，原因：%s，Steam ID：%s", 
        currentTime, playerId, GetPlayerName(playerId), reason, steamId)
    -- 调用日志机器人发送日志的函数
    sendLogToKook(logMessage)
end)

-- 监听资源启动事件
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local currentTime = getCurrentTime()
        local debugMessage = string.format("[%s] 脚本已启动，开始监听玩家事件。", currentTime)
        sendLogToKook(debugMessage)
    end
end)

-- 监听玩家选择人物完成事件
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    local currentTime = getCurrentTime()
    local identifiers = GetPlayerIdentifiers(playerId)
    local steamId = ""
    for _, id in ipairs(identifiers) do
        if string.find(id, "steam:") then
            steamId = id:gsub("steam:", "")
            break
        end
    end

    local firstName = xPlayer.get('firstName')
    local lastName = xPlayer.get('lastName')
    local dateOfBirth = xPlayer.get('dateofbirth')
    local sex = xPlayer.get('sex')
    local height = xPlayer.get('height')

    local logMessage = string.format("[%s] 玩家 %s %s 选择人物完成，角色信息如下：\n出生日期：%s\n性别：%s\n身高：%s\nSteam ID：%s",
        currentTime, firstName, lastName, dateOfBirth, sex, height, steamId)
    sendLogToKook(logMessage)
end)

-- 接收客户端发送的日志信息
RegisterServerEvent('kook_logger:sendLog')
AddEventHandler('kook_logger:sendLog', function(message)
    sendLogToKook(message)
end)