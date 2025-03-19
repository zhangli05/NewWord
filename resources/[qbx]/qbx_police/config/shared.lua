return {
    timeout = 10000,
    maxSpikes = 5,
    policePlatePrefix = 'LSPD',
    objects = {
        cone = {model = `prop_roadcone02a`, freeze = false},
        barrier = {model = `prop_barrier_work06a`, freeze = true},
        roadsign = {model = `prop_snow_sign_road_06g`, freeze = true},
        tent = {model = `prop_gazebo_03`, freeze = true},
        light = {model = `prop_worklight_03b`, freeze = true},
        chair = {model = `prop_chair_08`, freeze = true},
        chairs = {model = `prop_chair_pile_01`, freeze = true},
        tabe = {model = `prop_table_03`, freeze = true},
        monitor = {model = `des_tvsmash_root`, freeze = true},
    },

    locations = {
        duty = {
            vec3(440.085, -974.924, 30.689),
            vec3(-449.811, 6012.909, 31.815),
        },
        vehicle = {
            vec4(452.0, -996.0, 26.0, 175.0),
            vec4(447.0, -997.0, 26.0, 178.0),
            vec4(463.0, -1019.0, 28.0, 87.0),
            vec4(463.0, -1015.0, 28.0, 87.0),
        },
        stash = { -- Not currently used, use ox_inventory stashes
            -- vec3(453.075, -980.124, 30.889),
        },
        impound = {
            vec3(436.68, -1007.42, 27.32),
            vec3(-436.14, 5982.63, 31.34)
        },
        helicopter = {
            vec4(449.168, -981.325, 43.691, 87.234),
            vec4(-475.43, 5988.353, 31.716, 31.34),
        },
        armory = { -- Not currently used, use ox_inventory shops
            -- vec3(462.23, -981.12, 30.68),
        },
        trash = {
            vec3(439.0907, -976.746, 30.776),
        },
        fingerprint = {
            vec3(460.9667, -989.180, 24.92),
        },
        evidence = { -- Not currently used, use ox_inventory evidence system
        },
        stations = {
            {label = 'Mission Row Police Station', coords = vec3(434.0, -983.0, 30.7)},
            {label = 'Sandy Shores Police Station', coords = vec3(1853.4, 3684.5, 34.3)},
            -- {label = 'Vinewood Police Station', coords = vec3(637.1, 1.6, 81.8)},
            -- {label = 'Vespucci Police Station', coords = vec3(-1092.6, -808.1, 19.3)},
            -- {label = 'Davis Police Station', coords = vec3(368.0, -1618.8, 29.3)},
            -- {label = 'Paleto Bay Police Station', coords = vec3(-448.4, 6011.8, 31.7)},
        },
    },

    radars = {
        -- /! \ maxSpeed（s）需要以递增的顺序 /！
        -- 如果你不想罚款，人们就这样做：'config. speedFines=false'
        -- 如果你的最高速度低于限速就可以
        --（也就是说，如果你的时速是 41 英里，雷达的限制是 35 英里，你就超过了 6 英里，所以罚款 25 美元）
        speedFines = {
            {fine = 25, maxSpeed = 10 },
            {fine = 50, maxSpeed = 30},
            {fine = 250, maxSpeed = 80},
            {fine = 500, maxSpeed = 180},
        }
    }
}
