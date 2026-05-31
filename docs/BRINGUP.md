# First-Time Bring-Up Guide

## First Flash (USB)

OTA updates are only available after the device has been flashed at least once
with a Ctrlable firmware build. Follow these steps for the initial flash.

### 1. Build the factory binary

In the ESPHome dashboard, open `ctrlable-voice-satellite.yaml` and choose
**Install → Manual download → Factory format (.bin)**.

Verify the downloaded file is approximately **4 MB**. If it is much smaller
(~1 MB) you have the OTA-only binary, which cannot be used for a first flash.

### 2. Connect via USB-C

Connect the board's **data USB-C port** to your Mac. If macOS does not
enumerate a `cu.usbmodem*` device within a few seconds, unplug and try the
other USB-C port (see `docs/HARDWARE.md` for details).

### 3. Enter download mode

1. Hold the **BOOT** button (GPIO0).
2. While holding BOOT, tap the **RESET** button.
3. Release BOOT.

The board is now in ROM download mode and will remain enumerated as a serial
device.

### 4. Flash with web.esphome.io

1. Open **https://web.esphome.io** in Chrome or Edge (requires Web Serial API).
2. Click **Connect** and select the `cu.usbmodem*` port.
3. **Do NOT click "Prepare for first use"** — that installs generic ESPHome
   onboarding firmware and will overwrite your build.
4. Use the custom install path to upload the `factory.bin` you downloaded.

### 5. esptool fallback

If web.esphome.io is uncooperative, flash directly with esptool:

```bash
esptool.py --chip esp32s3 \
    --port /dev/cu.usbmodemXXXXX \
    --baud 460800 \
    write_flash --erase-all 0x0 path/to/factory.bin
```

Replace `/dev/cu.usbmodemXXXXX` with the actual port (`ls /dev/cu.usbmodem*`).
Install esptool if needed: `pip install esptool`.

---

## Subsequent Updates (OTA)

After a successful first flash the device appears in the ESPHome dashboard.
All future updates can be pushed wirelessly:

**Install → Wirelessly**

No USB connection needed.

---

## Re-enabling API Encryption

The `encryption:` block in the YAML is currently commented out. To re-enable it:

1. Generate a fresh key:
   ```bash
   openssl rand -base64 32
   ```
2. Add the key to `/config/esphome/secrets.yaml`:
   ```yaml
   api_encryption_key: "<output from above>"
   ```
3. Uncomment the `encryption:` block in `ctrlable-voice-satellite.yaml`.
4. OTA-flash the change from the ESPHome dashboard.
5. Re-adopt the device in **Home Assistant → Settings → Devices & Services**
   using the new encryption key when prompted.

> **Note**: After enabling encryption, the device will not be accessible from
> HA until it is re-adopted with the correct key.
