# phio_sounds
QB-Core FiveM soundskript for xsound

Here’s the README for your script, tailored for GitHub and written in English:

---

# **FiveM Sound Trigger Script**

A flexible **FiveM script** that allows players to start and stop sounds at specific locations using **xsound** and **qb-target**. The script supports custom trigger and playback positions, external URLs for sounds, and client-side notifications for actions.

---

## **Features**
- **Fully configurable sounds:**
  - Assign individual trigger and playback positions for each sound.
  - Supports external URLs (e.g., YouTube) for sounds.

- **Integration with xsound and qb-target:**
  - Utilizes `xsound` exports for sound management.
  - Trigger zones are created using `qb-target`.

- **Debugging:**
  - Debugging can be enabled or disabled via the `config.lua`.

---

## **Requirements**
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [xsound](https://github.com/XTheMan/xsound)
- [qb-target](https://github.com/qbcore-framework/qb-target)

---

## **Installation**

1. **Download the script:**
   Clone or download the repository into your server's resources folder.
   The xsound must be startet before.

---

## **Configuration**

All settings are managed in the `config.lua`.

### **Example Configuration**
```lua
Config = {}

Config.debug = true -- Enable or disable debugging

Config.Locations = {
    {
        id = "radiology1",
        controlCoords = vector3(331.99, -1430.94, 30.8), -- Trigger position
        sounds = {
            {
                id = "mri",
                file = "https://www.youtube.com/watch?v=hvXoHU9Cexk", -- External URL
                playCoords = vector3(331.52, -1426.51, 30.79), -- Playback position
                volume = 0.6,
                range = 50.0,
                label = "Start/Stop MRI"
            },
            {
                id = "xray",
                file = "https://www.youtube.com/watch?v=08VGl8BePfc", -- External URL
                playCoords = vector3(336.21, -1428.27, 30.65), -- Playback position
                volume = 0.6,
                range = 50.0,
                label = "Start/Stop X-Ray"
            }
        }
    }
}
```

### **Parameters**
- **`id`**: A unique ID for the location or sound.
- **`controlCoords`**: The position where the trigger is placed.
- **`file`**: The URL to the sound.
- **`playCoords`**: The position where the sound is played.
- **`volume`**: Maximum volume of the sound (value between `0.0` and `1.0`).
- **`range`**: Distance within which the sound can be heard.
- **`label`**: Text displayed in the qb-target menu.

---

## **Usage**

### **Trigger Points**
- Interact with a trigger point to start or stop a sound.
- The sound plays and stops when triggered again.

### **Debugging**
- Set `Config.debug = true` to enable debugging logs in the console.  
  Example logs:
  ```
  [DEBUG] Target Zone created: radiology1 @ vector3(331.99, -1430.94, 30.8)
  [DEBUG] Sound started: mri, File: https://www.youtube.com/watch?v=hvXoHU9Cexk, Position: vector3(331.52, -1426.51, 30.79)
  [DEBUG] Sound stopped: mri
  ```

---

## **FAQ**

### **1. Does the script support external URLs?**
Yes, it supports external URLs like YouTube links.

### **2. Why can't I hear the sound?**
- Ensure the url is correctly referenced in the `config.lua`.
- Clear the FiveM cache:
  ```
  %localappdata%\FiveM\FiveM.app\data\cache
  ```
- Confirm the URL is valid.

---

## **License**

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

Feel free to open an issue or create a pull request if you encounter any problems or have feature requests. 😊
