# Changelog

## v0.1.0 — 2026-05-30

Initial Ctrlable release. Based on
[abramosphere/Home-Assistant-Voice-for-ESP32-S3-Touch-AMOLED-1.75](https://github.com/abramosphere/Home-Assistant-Voice-for-ESP32-S3-Touch-AMOLED-1.75);
divergences from upstream:

- **Ctrlable branding**: Replaced all Home Assistant Casita illustrations with
  Ctrlable-branded expression images at 466×466 native AMOLED resolution.
  Images are sourced from in-repo SVGs under `svg_sources/` and rendered via
  `rsvg-convert` (see `render_svgs.sh`).

- **ESPHome 2026.4.0+ timer API fix**: Updated three scripts to match the new
  `voice_assistant` timer API (`on_timer_*` callbacks pass iterators directly
  rather than maps):
  - `fetch_first_active_timer`: `timers.begin()->second` → `*timers.begin()`,
    `iterable_timer.second` → `iterable_timer`
  - `check_if_timers_active`: same iterator dereference fix
  - `fetch_first_timer`: same iterator dereference fix

- **Touchscreen driver swap**: Replaced `cst816` platform with the `cst9217`
  external component (`github://fuzzybear62/esphome-cst9217`). The actual
  hardware uses a CST9217 IC; the cst816 driver caused erratic touch
  registration on this board revision.

- **API encryption disabled pending re-key**: The `encryption:` block is
  commented out. Re-enable it by generating a fresh key with
  `openssl rand -base64 32`, storing it in `secrets.yaml`, and OTA-flashing
  the change (see `docs/BRINGUP.md`).

- **I2C scan enabled**: Added `scan: true` to the I2C bus configuration for
  diagnostic convenience during bring-up.

- **Native-resolution images**: Removed `resize: 466x466` from all 10 `image:`
  entries. Source PNGs are already at native AMOLED resolution, so runtime
  resizing is unnecessary. This reduces boot time and avoids any interpolation
  softness.

- **ESP32 config updated**: `board: esp32-s3-devkitc-1`, `flash_size: 16MB`,
  `psram: { mode: octal, speed: 80MHz }` to match actual Waveshare hardware.
