-- 获取当前时间的函数
local function getCurrentTime()
    local timestamp = os.time()
    return os.date("%Y-%m-%d %H:%M:%S", timestamp)
end

-- 监听客户端玩家进入游戏事件
Citizen.CreateThread(function()
    Citizen.Wait(5000) -- 等待 5 秒确保游戏初始化完成
    local currentTime = getCurrentTime()
    local playerId = PlayerId()
    local playerName = GetPlayerName(playerId)
    local logMessage = string.format("[%s] 玩家 ID: %s，玩家 %s 登录游戏。", currentTime, playerId, playerName)
    TriggerServerEvent('kook_logger:sendLog', logMessage)
end)

-- 监听客户端事件，例如玩家死亡
AddEventHandler('playerDeath', function(killer, reason)
    local playerId = PlayerId()
    local playerName = GetPlayerName(playerId)
    local killerId = killer
    local killerName = killer and GetPlayerName(killer) or "未知"
    local currentTime = getCurrentTime()
    local logMessage = string.format("[%s] 玩家 ID: %s，玩家 %s 被 玩家 ID: %s，玩家 %s 击杀。原因：%s", 
        currentTime, playerId, playerName, killerId, killerName, reason)
    TriggerServerEvent('kook_logger:sendLog', logMessage)
end)

-- 监听玩家退出游戏事件
AddEventHandler('onClientResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local currentTime = getCurrentTime()
        local playerId = PlayerId()
        local playerName = GetPlayerName(playerId)
        local logMessage = string.format("[%s] 玩家 ID: %s，玩家 %s 离线游戏。", currentTime, playerId, playerName)
        TriggerServerEvent('kook_logger:sendLog', logMessage)
    end
end)