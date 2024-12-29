-- Debug-Funktion
local function DebugPrint(msg)
    if Config.debug then
        print(msg)
    end
end

RegisterNetEvent("sound:toggle", function(locationId, soundId, playCoords)
    DebugPrint(("[DEBUG] Server hat Event erhalten: locationId=%s, soundId=%s, playCoords=%s"):format(locationId, soundId, tostring(playCoords)))

    if not locationId then
        print("[ERROR] Keine Standort-ID empfangen.")
        return
    end

    local location = GetLocationById(locationId)
    if not location then
        DebugPrint(("[ERROR] Ungültige Standort-ID: %s"):format(locationId))
        return
    end

    local sound = GetSoundById(location.sounds, soundId)
    if not sound then
        DebugPrint(("[ERROR] Ungültige Sound-ID: %s für Standort %s"):format(soundId, locationId))
        return
    end

    local src = source
    TriggerClientEvent('QBCore:Notify', src, "Gestartet/Gestoppt", "success")
    TriggerClientEvent("sound:client:play", -1, soundId, sound.file, playCoords, sound.volume, sound.range)
end)

-- Hilfsfunktionen
function GetLocationById(locationId)
    for _, location in pairs(Config.Locations) do
        if location.id == locationId then
            return location
        end
    end
    return nil
end

function GetSoundById(sounds, soundId)
    for _, sound in pairs(sounds) do
        if sound.id == soundId then
            return sound
        end
    end
    return nil
end
