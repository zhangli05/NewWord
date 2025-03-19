local config = require 'config.client'.securityCameras
local currentCamIndex = 0
local createdCam = 0
local currentScaleform = -1

local function getCurrentTime()
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    if hours < 10 then
        hours = tostring(0 .. GetClockHours())
    end
    if minutes < 10 then
        minutes = tostring(0 .. GetClockMinutes())
    end
    return tostring(hours .. ':' .. minutes)
end

local function createInstructionalScaleform(scaleform)
    scaleform = lib.requestScaleformMovie(scaleform)
    PushScaleformMovieFunction(scaleform, 'CLEAR_ALL')
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, 'SET_CLEAR_SPACE')
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, 'SET_DATA_SLOT')
    PushScaleformMovieFunctionParameterInt(1)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 194, true))
    BeginTextCommandScaleformString('STRING')
    AddTextComponentScaleform(locale('info.close_camera'))
    EndTextCommandScaleformString()
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, 'DRAW_INSTRUCTIONAL_BUTTONS')
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, 'SET_BACKGROUND_COLOUR')
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

local function changeSecurityCamera(x, y, z, r)
    if createdCam ~= 0 then
        DestroyCam(createdCam, false)
        createdCam = 0
    end

    if currentScaleform ~= -1 then
        SetScaleformMovieAsNoLongerNeeded(currentScaleform)
        currentScaleform = -1
    end

    local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    SetCamCoord(cam, x, y, z)
    SetCamRot(cam, r.x, r.y, r.z, 2)
    RenderScriptCams(true, false, 0, true, true)
    Wait(250)
    createdCam = cam
    currentScaleform = createInstructionalScaleform('instructional_buttons')
end

local function closeSecurityCamera()
    DestroyCam(createdCam, false)
    RenderScriptCams(false, false, 1, true, true)
    createdCam = 0
    SetScaleformMovieAsNoLongerNeeded(currentScaleform)
    currentScaleform = -1
    ClearTimecycleModifier()
    SetFocusEntity(cache.ped)
    if config.hideRadar then
        DisplayRadar(true)
    end
    FreezeEntityPosition(cache.ped, false)
end

RegisterNetEvent('police:client:ActiveCamera', function(camId)
    if GetInvokingResource() then return end
    if config.cameras[camId] then
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        SendNUIMessage({
            type = 'enablecam',
            label = config.cameras[camId].label,
            id = camId,
            connected = config.cameras[camId].isOnline,
            time = getCurrentTime(),
        })
        local firstCamX = config.cameras[camId].coords.x
        local firstCamY = config.cameras[camId].coords.y
        local firstCamZ = config.cameras[camId].coords.z
        local firstCamR = config.cameras[camId].r
        SetFocusArea(firstCamX, firstCamY, firstCamZ, firstCamX, firstCamY, firstCamZ)
        changeSecurityCamera(firstCamX, firstCamY, firstCamZ, firstCamR)
        currentCamIndex = camId
        DoScreenFadeIn(250)
    elseif camId == 0 then
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        closeSecurityCamera()
        SendNUIMessage({
            type = 'disablecam',
        })
        DoScreenFadeIn(250)
    else
        exports.qbx_core:Notify(locale('error.no_camera'), 'error')
    end
end)

RegisterNetEvent('police:client:DisableAllCameras', function()
    if GetInvokingResource() then return end
    for i = 1, #config.cameras do
        config.cameras[i].isOnline = false
    end
end)

RegisterNetEvent('police:client:EnableAllCameras', function()
    if GetInvokingResource() then return end
    for i = 1, #config.cameras do
        config.cameras[i].isOnline = true
    end
end)

RegisterNetEvent('police:client:SetCamera', function(key, isOnline)
    if GetInvokingResource() then return end
    if type(key) == 'table' and table.type(key) == 'array' then
        for i = 1, #key do
            config.cameras[key[i]].isOnline = isOnline
        end
    elseif type(key) == 'number' then
        config.cameras[key].isOnline = isOnline
    else
        error('police:client:SetCamera did not receive the right type of key\nreceived type: ' .. type(key) .. '\nreceived value: ' .. key)
    end
end)

local function listenForCamControls()
    DrawScaleformMovieFullscreen(currentScaleform, 255, 255, 255, 255, 0)
    SetTimecycleModifier('scanline_cam_cheap')
    SetTimecycleModifierStrength(1.0)

    if config.hideRadar then
        DisplayRadar(false)
    end

    -- CLOSE CAMERAS
    if IsControlJustPressed(1, 177) then
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        closeSecurityCamera()
        SendNUIMessage({
            type = 'disablecam',
        })
        DoScreenFadeIn(250)
    end

    ---------------------------------------------------------------------------
    -- CAMERA ROTATION CONTROLS
    ---------------------------------------------------------------------------
    if config.cameras[currentCamIndex].canRotate then
        local getCamRot = GetCamRot(createdCam, 2)

        -- ROTATE UP
        if IsControlPressed(0, 32) then
            if getCamRot.x <= 0.0 then
                SetCamRot(createdCam, getCamRot.x + 0.7, 0.0, getCamRot.z, 2)
            end
        end

        -- ROTATE DOWN
        if IsControlPressed(0, 8) then
            if getCamRot.x >= -50.0 then
                SetCamRot(createdCam, getCamRot.x - 0.7, 0.0, getCamRot.z, 2)
            end
        end

        -- ROTATE LEFT
        if IsControlPressed(0, 34) then
            SetCamRot(createdCam, getCamRot.x, 0.0, getCamRot.z + 0.7, 2)
        end

        -- ROTATE RIGHT
        if IsControlPressed(0, 9) then
            SetCamRot(createdCam, getCamRot.x, 0.0, getCamRot.z - 0.7, 2)
        end
    end
end

CreateThread(function()
    while true do
        if createdCam == 0 or currentScaleform == -1 then
            Wait(2000)
        else
            listenForCamControls()
            Wait(0)
        end
    end
end)
