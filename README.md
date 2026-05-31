# Ctrlable Voice Satellite — ESP32-S3 Touch AMOLED 1.75"

Ctrlable-branded ESPHome voice satellite firmware for the
[Waveshare ESP32-S3 Touch AMOLED 1.75"](https://www.waveshare.com/esp32-s3-touch-amoled-1.75.htm)
board. Built on ESPHome with wake-word detection, voice assistant integration,
and a full set of Ctrlable expression images rendered at native 466×466
AMOLED resolution.

Originally based on
[abramosphere/Home-Assistant-Voice-for-ESP32-S3-Touch-AMOLED-1.75](https://github.com/abramosphere/Home-Assistant-Voice-for-ESP32-S3-Touch-AMOLED-1.75).
See [docs/UPSTREAM.md](docs/UPSTREAM.md) for the divergence history.

---

## Hardware

| Component | Spec |
|-----------|------|
| MCU | ESP32-S3, dual-core 240 MHz |
| Flash | 16 MB |
| PSRAM | 8 MB Octal, 80 MHz |
| Display | 466×466 round AMOLED, CO5300 driver (QSPI) |
| Audio DAC | ES8311 (I2C 0x18, I2S) |
| Audio ADC | ES7210 (I2C 0x40, I2S) |
| Touch | CST9217 capacitive (I2C 0x5A) |

Full pinout and bring-up notes: [docs/HARDWARE.md](docs/HARDWARE.md)

---

## Quick Start

### 1. Drop the YAML into ESPHome

Copy `ctrlable-voice-satellite.yaml` to `/config/esphome/` on your Home
Assistant instance.

### 2. Add WiFi credentials

```bash
cp secrets.yaml.example /config/esphome/secrets.yaml
```

Edit `secrets.yaml` and fill in your `wifi_ssid` and `wifi_password`.

### 3. First flash (USB)

The first firmware install must be done over USB. See
[docs/BRINGUP.md](docs/BRINGUP.md) for the exact procedure, including the
BOOT+RESET dance and the web.esphome.io workflow.

### 4. Subsequent updates (OTA)

Once the device is online, all future updates are pushed wirelessly from the
ESPHome dashboard: **Install → Wirelessly**.

---

## Customization

The `substitutions:` block at the top of the YAML exposes the most common
overrides:

| Key | Default | Notes |
|-----|---------|-------|
| `loading_illustration_file` | `images/ctrlable_loading.png` | URL served from this repo |
| `idle_illustration_file` | `images/ctrlable_idle.png` | |
| `listening_illustration_file` | `images/ctrlable_listening.png` | |
| `thinking_illustration_file` | `images/ctrlable_thinking.png` | |
| `replying_illustration_file` | `images/ctrlable_replying.png` | |
| `timer_finished_illustration_file` | `images/ctrlable_timer_finished.png` | |
| `mute_illustration_file` | `images/ctrlable_mute.png` | |
| `error_illustration_file` | `images/ctrlable_error.png` | |
| `error_no_wifi_file` | `images/ctrlable_error_no_wifi.png` | |
| `error_no_ha_file` | `images/ctrlable_error_no_server.png` | |

To use custom images, host them somewhere accessible and override the URL
substitutions. Images must be 466×466 PNG.

Other substitutions of interest: voice pipeline IDs, font family, and glyph
ranges for the display font.

---

## Re-rendering Images

SVG sources live in `svg_sources/`. To re-render all PNGs:

```bash
./render_svgs.sh
```

Requires `rsvg-convert` (`brew install librsvg` on macOS).

---

## Docs

- [docs/HARDWARE.md](docs/HARDWARE.md) — Pinout, I2C addresses, USB notes
- [docs/BRINGUP.md](docs/BRINGUP.md) — First-time USB flash procedure
- [docs/UPSTREAM.md](docs/UPSTREAM.md) — Upstream credits and backport log
- [CHANGELOG.md](CHANGELOG.md) — What changed from upstream

---

## License

Proprietary — internal Ctrlable use only.
See [LICENSE](LICENSE) for the full notice.
