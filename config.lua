Config = {}

Config.debug = false

-- Konfiguration für mehrere Standorte mit mehreren Sounds
Config.Locations = {
    {
        id = "radiologie1",
        controlCoords = vector3(331.99, -1430.94, 30.8), -- Triggerposition
        sounds = {
            {
                id = "mri",
                file = "https://www.youtube.com/watch?v=hvXoHU9Cexk", -- Sounddatei
                playCoords = vector3(331.52, -1426.51, 30.79), -- Abspielkoordinaten
                volume = 0.6,
                range = 50.0,
                label = "MRT starten/stoppen"
            },
            {
                id = "xray",
                file = "https://www.youtube.com/watch?v=08VGl8BePfc", -- Sounddatei
                playCoords = vector3(336.21, -1428.27, 30.65), -- Abspielkoordinaten
                volume = 0.6,
                range = 50.0,
                label = "Röntgen starten/stoppen"
            }
        }
    },
}

