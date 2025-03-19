-- 文件路径: e:\FIVEM\txData\QboxProject_DA57D7.base\resources\[qbx]\qbx_ambulancejob\config\client.lua
return {
    useTarget = false, -- 是否使用目标系统
    debugPoly = false, -- 是否启用调试多边形
    minForCheckIn = 2, -- 使用登记系统所需的最低救护车工作人数
    painkillerInterval = 60, -- 止痛药持续的时间（以分钟为单位）
    checkInHealTime = 20, -- 使用登记系统治疗所需的时间（以秒为单位）
    laststandTimer = 300, -- 最后一站计时器持续的时间（以秒为单位）
    aiHealTimer = 20, -- 登记后由AI治疗所需的时间（以秒为单位）

    ---@alias Grade integer 工作等级
    ---@alias VehicleName string 在 QBCore 共享配置中显示的车辆名称
    ---@alias VehicleLabel string 车辆的友好名称
    ---@alias AuthorizedVehicles table<Grade, table<VehicleName, VehicleLabel>>

    ---@type AuthorizedVehicles 汽车的授权车辆
    authorizedVehicles = { -- 根据救护车工作等级，玩家可以使用的车辆
        [0] = { -- 等级 0
            ['ambulance'] = '救护车',
        },
        [1] = { -- 等级 1
            ['ambulance'] = '救护车',
        },
        [2] = { -- 等级 2
            ['ambulance'] = '救护车',
        },
        [3] = { -- 等级 3
            ['ambulance'] = '救护车',
        },
        [4] = { -- 等级 4
            ['ambulance'] = '救护车',
        },
    },

    ---@type AuthorizedVehicles 直升机的授权车辆
    authorizedHelicopters = {
        [0] = { -- 等级 0
            ['polmav'] = '直升机',
        },
        [1] = { -- 等级 1
            ['polmav'] = '直升机',
        },
        [2] = { -- 等级 2
            ['polmav'] = '直升机',
        },
        [3] = { -- 等级 3
            ['polmav'] = '直升机',
        },
        [4] = { -- 等级 4
            ['polmav'] = '直升机',
        },
    },

    vehicleSettings = { -- 从救护车工作车辆生成器中拉取车辆时启用或禁用车辆额外功能
        ['ambulance'] = { -- 模型名称
            extras = {
                ['1'] = false, -- 开/关
                ['2'] = true,
                ['3'] = true,
                ['4'] = true,
                ['5'] = true,
                ['6'] = true,
                ['7'] = true,
                ['8'] = true,
                ['9'] = true,
                ['10'] = true,
                ['11'] = true,
                ['12'] = true,
            },
        },
        ['car2'] = { -- 另一个车辆模型
            extras = {
                ['1'] = false,
                ['2'] = true,
                ['3'] = true,
                ['4'] = true,
                ['5'] = true,
                ['6'] = true,
                ['7'] = true,
                ['8'] = true,
                ['9'] = true,
                ['10'] = true,
                ['11'] = true,
                ['12'] = true,
            },
        },
        ['polmav'] = { -- 直升机模型
            livery = 1, -- 涂装编号
        },
    },
}