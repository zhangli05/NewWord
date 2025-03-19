-- 从 'config.shared' 模块中引入 serverName 变量
local serverName = require 'config.shared'.serverName

return {
    --- 玩家在排队等待时断开连接后，从队列中移除该玩家前需要等待的秒数。
    timeoutSeconds = 30,

    --- 玩家在安装服务器数据时断开连接后，从队列中移除该玩家前需要等待的秒数。
    --- 注意，由于 FiveM 处理玩家加入的限制，还会额外等待约 2 分钟。
    joiningTimeoutSeconds = 0,

    ---@class AdaptiveCardTextOptions
    ---@field style? 'default' | 'heading' | 'columnHeader'
    ---@field fontType? 'default' | 'monospace'
    ---@field size? 'small' | 'default' | 'medium' | 'large' | 'extralarge'
    ---@field weight? 'lighter' | 'default' | 'bolder'
    ---@field color? 'default' | 'dark' | 'light' | 'accent' | 'good' | 'warning' | 'attention'
    ---@field isSubtle? boolean

    ---@class SubQueueConfig
    ---@field name string
    ---@field predicate? fun(source: Source): boolean
    ---@field cardOptions? AdaptiveCardTextOptions  Text options used in the adaptive card

    --- 子队列，按优先级从高到低排列。
    --- 第一个没有谓词函数的子队列将被视为默认队列。
    --- 如果玩家未通过任何谓词测试，且不存在没有谓词的子队列，则除非有玩家空位，否则该玩家将无法进入服务器。
    ---@type SubQueueConfig[]
    subQueues = {
        -- 管理员队列，只有具有 'admin' 权限的玩家才能进入，卡片颜色为绿色
        { name = '管理员队列', predicate = function(source) return IsPlayerAceAllowed(source --[[@as string]], 'admin') end, cardOptions = { color = 'good' } },
        -- 普通队列，没有任何限制条件
        { name = '普通队列' },
    },

    --- 排队等待时间旁边显示的装饰性表情符号。
    waitingEmojis = {
        '🕛',
        '🕒',
        '🕕',
        '🕘',
    },

    --- 是否使用下面定义的自适应卡片生成器。
    useAdaptiveCard = true,

    ---@class GenerateCardParams
    ---@field subQueue SubQueue
    ---@field globalPos integer
    ---@field totalQueueSize integer
    ---@field displayTime string

    --- 自适应卡片的生成函数。
    ---@param params GenerateCardParams
    ---@return table
    generateCard = function(params)
        -- 从传入的参数中提取子队列信息
        local subQueue = params.subQueue
        -- 从传入的参数中提取玩家在全局队列中的位置
        local pos = params.globalPos
        -- 从传入的参数中提取队列的总长度
        local size = params.totalQueueSize
        -- 从传入的参数中提取显示的等待时间
        local displayTime = params.displayTime

        -- 获取子队列的卡片选项，如果没有则使用空表
        local cardOptions = subQueue.cardOptions or {}

        -- 队列和服务器之间显示的进度条数量
        local progressAmount = 7 
        -- 计算玩家所在的列位置
        local playerColumn = pos == 1 and progressAmount or (progressAmount - math.ceil(pos / (size / progressAmount)) + 1)

        -- 进度条文本替换配置
        local progressTextReplacements = {
            [1] = {
                text = '队列',
                color = 'good',
            },
            [playerColumn + 1] = {
                text = 'You',
                color = 'good',
            },
            [progressAmount + 2] = {
                text = 'Server',
                color = 'good',
            },
        }

        local progressColumns = {}
        for i = 1, progressAmount + 2 do
            local textBlock = {
                type = 'TextBlock',
                text = '•',
                horizontalAlignment = 'center',
                size = 'extralarge',
                weight = 'lighter',
                color = 'accent',
            }

            local replacements = progressTextReplacements[i]
            if replacements then
                for k, v in pairs(replacements) do
                    textBlock[k] = v
                end
            end

            local column = {
                type = 'Column',
                width = 'stretch',
                verticalContentAlignment = 'center',
                items = {
                    textBlock,
                }
            }

            progressColumns[i] = column
        end

        return {
            type = 'AdaptiveCard',
            version = '1.6',
            body = {
                {
                    type = 'TextBlock',
                    text = 'In Line',
                    horizontalAlignment = 'center',
                    size = 'large',
                    weight = 'bolder',
                },
                {
                    type = 'TextBlock',
                    text = ('Joining %s'):format(serverName),
                    spacing = 'none',
                    horizontalAlignment = 'center',
                    size = 'medium',
                    weight = 'bolder',
                },
                {
                    type = 'ColumnSet',
                    spacing = 'large',
                    columns = progressColumns,
                },
                {
                    type = 'ColumnSet',
                    spacing = 'large',
                    columns = {
                        {
                            type = 'Column',
                            width = 'stretch',
                            items = {
                                {
                                    type = 'TextBlock',
                                    text = subQueue.name,
                                    style = cardOptions.style,
                                    fontType = cardOptions.fontType,
                                    size = cardOptions.size or 'medium',
                                    color = cardOptions.color,
                                    isSubtle = cardOptions.isSubtle,
                                }
                            },
                        },
                        {
                            type = 'Column',
                            width = 'stretch',
                            items = {
                                {
                                    type = 'TextBlock',
                                    text = ('%d/%d'):format(pos, size),
                                    horizontalAlignment = 'center',
                                    color = 'good',
                                    size = 'medium',
                                }
                            },
                        },
                        {
                            type = 'Column',
                            width = 'stretch',
                            items = {
                                {
                                    type = 'TextBlock',
                                    text = displayTime,
                                    horizontalAlignment = 'right',
                                    size = 'medium',
                                }
                            },
                        },
                    },
                },
            },
        }
    end,
}
