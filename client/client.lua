local activeSounds = {}
local QBCore = exports['qb-core']:GetCoreObject()

-- Debug-Funktion
local function DebugPrint(msg)
    if Config.debug then
        print(msg)
    end
end


-- Erstelle die qb-target Triggerpunkte
CreateThread(function()
    for _, location in pairs(Config.Locations) do
        local options = {}

        for _, sound in pairs(location.sounds) do
            -- Debugging für args
            DebugPrint(("[DEBUG] Hinzugefügte args: locationId=%s, soundId=%s, playCoords=%s"):format(location.id, sound.id, tostring(sound.playCoords)))

            -- Optionen mit args definieren
            table.insert(options, {
                type = "client",
                event = "sound:trigger",
                icon = "fas fa-volume-up",
                label = sound.label,
                args = {
                    locationId = location.id, -- Standort-ID
                    soundId = sound.id,       -- Sound-ID
                    playCoords = sound.playCoords -- Abspielkoordinaten
                }
            })
        end

        -- Hinzufügen der qb-target-Zone
        exports['qb-target']:AddBoxZone(location.id, location.controlCoords, 1.0, 1.0, {
            name = location.id,
            heading = 0,
            debugPoly = false,
            minZ = location.controlCoords.z - 1.0,
            maxZ = location.controlCoords.z + 1.0,
        }, {
            options = options,
            distance = 2.0
        })

        DebugPrint(("[DEBUG] Target Zone erstellt: %s @ %s"):format(location.id, tostring(location.controlCoords)))
    end
end)


-- Trigger-Event mit Debugging
RegisterNetEvent("sound:trigger", function(data)
    -- Extrahiere die args-Daten aus data
    local args = data.args
    if not args then
        DebugPrint("[ERROR] Keine args-Daten im Trigger-Event erhalten.")
        return
    end

    -- Debug-Ausgabe der extrahierten args
    DebugPrint(("[DEBUG] Extrahierte args: locationId=%s, soundId=%s, playCoords=%s"):format(args.locationId, args.soundId, tostring(args.playCoords)))

    -- Überprüfe die args-Daten
    if not args.locationId or not args.soundId or not args.playCoords then
        DebugPrint("[ERROR] Ungültige args-Daten im Trigger-Event.")
        return
    end

    -- Weitergabe an den Server-Event
    TriggerServerEvent("sound:toggle", args.locationId, args.soundId, args.playCoords)
end)


-- Empfange Server-Event zum Abspielen/Stoppen des Sounds
RegisterNetEvent("sound:client:play", function(soundId, file, coords, volume, range)
    DebugPrint(("[DEBUG] Versuche, Sound zu laden: %s, Datei: %s"):format(soundId, file))
    local src = source

    if not exports.xsound:soundExists(soundId) then
        exports.xsound:PlayUrlPos(soundId, file, volume, coords, true, {
            distance = range
        })

        if exports.xsound:soundExists(soundId) then
            DebugPrint(("[DEBUG] Sound erfolgreich geladen: %s"):format(soundId))
        else
            DebugPrint(("[ERROR] Sound konnte nicht geladen werden: %s"):format(soundId))
        end

        activeSounds[soundId] = true
    else
        DebugPrint(("[DEBUG] Sound %s existiert bereits."):format(soundId))
        TriggerEvent("sound:client:stop", soundId)
    end
end)


RegisterNetEvent("sound:client:stop", function(soundId)
    if exports.xsound:soundExists(soundId) then
        exports.xsound:Destroy(soundId)
        DebugPrint(("[DEBUG] Sound gestoppt: %s"):format(soundId))
        activeSounds[soundId] = nil
    else
        DebugPrint(("[DEBUG] Sound %s existiert nicht."):format(soundId))
    end
end)