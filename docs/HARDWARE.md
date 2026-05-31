# Hardware Reference — Waveshare ESP32-S3 Touch AMOLED 1.75

## Board Overview

| Attribute | Value |
|-----------|-------|
| MCU | Espressif ESP32-S3 (dual-core Xtensa LX7, up to 240 MHz) |
| Flash | 16 MB (Quad SPI) |
| PSRAM | 8 MB Octal (OPI), 80 MHz |
| Display | 466×466 round AMOLED, CO5300 driver, QSPI interface |
| Audio DAC | ES8311 (I2C addr 0x18, I2S) |
| Audio ADC | ES7210 (I2C addr 0x40, I2S) |
| Touch | CST9217 capacitive (I2C addr 0x5A) |
| USB | Two USB-C ports — see note below |

## USB-C Ports

The board has two USB-C ports. **Only one is connected to the ESP32-S3's native
USB (for firmware flashing and serial console)**; the other is power/charging
only on most revisions.

If macOS doesn't enumerate the device (no `cu.usbmodem*` in `/dev/`), unplug
and try the other port. The data port is usually the one closest to the antenna.

## I2C Bus (bus_a)

| Pin | Role |
|-----|------|
| GPIO14 | SCL |
| GPIO15 | SDA |

| Device | Address |
|--------|---------|
| ES8311 (DAC) | 0x18 |
| ES7210 (ADC) | 0x40 |
| CST9217 (touch) | 0x5A |

`scan: true` is enabled in the ESPHome config; check the boot log to confirm
all three devices enumerate at startup.

## QSPI Display (CO5300 driver)

| Signal | GPIO |
|--------|------|
| CLK | 38 |
| D0 | 4 |
| D1 | 5 |
| D2 | 6 |
| D3 | 7 |
| CS | 12 |
| RST | 39 |
| TE (tearing effect, optional) | 13 |

## I2S Audio Bus

| Signal | GPIO |
|--------|------|
| LRCLK (WS) | 45 |
| BCLK | 9 |
| MCLK | 42 |
| DIN (mic → ESP) | 10 |
| DOUT (ESP → speaker) | 8 |

## Touch Controller (CST9217)

| Signal | GPIO |
|--------|------|
| Interrupt | 11 |
| Reset | 40 |

## Other GPIO

| Signal | GPIO | Notes |
|--------|------|-------|
| Speaker amp enable | 46 | Active high |
| BOOT button | 0 | Hold during reset to enter download mode |

## Strapping Pin Warnings

GPIO45 and GPIO46 are strapping pins on the ESP32-S3. The ROM bootloader
samples them during reset:

- **GPIO45** (LRCLK): sampled as a VDD_SPI voltage-select strap. The I2S
  driver drives it after boot — no action needed, but expect a one-time warning
  in the boot log.
- **GPIO46** (speaker amp enable): sampled for ROM boot message output enable.
  Again, driven by firmware after boot. Informational only.

Neither strapping conflict affects normal operation on this board.
