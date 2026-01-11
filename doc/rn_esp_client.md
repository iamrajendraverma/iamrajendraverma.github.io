# Release Notes

## [1.0.0] - 2026-01-11

Initial release of the ESP8266 client firmware and companion app integration.

### 🚀 Highlights

- **Quad-Relay Support:** Control up to 4 independent water valves or electrical devices.
- **Dynamic Switch Types:** Support for Binary, Delay, and Interval switches to suit different automation needs.
- **Real-time Status Monitoring:** Live MCU status updates directly in the companion app.
- **Effortless WiFi Setup:** Built-in Captive Portal for easy network configuration.

### ✨ New Features

#### 🔧 Hardware Control

- Support for 4 Output Pins: **D1 (GPIO 5)**, **D2 (GPIO 4)**, **D6 (GPIO 12)**, and **D7 (GPIO 13)**.
- **Active Low Logic:** Compatible with most standard relay modules.
- **One-Touch Reset:** Hold button **D3** for 3 seconds to clear WiFi credentials and enter configuration mode.

#### 📱 ESP Buttons App Integration

- **Binary Switches:** Standard ON/OFF control for immediate action.
- **Delay Switches:** Set a timer to automatically turn a valve OFF after a specified duration.
- **Interval Switches:** Programmable schedules for "Once" or "Daily" operations with configurable intervals and delays.
- **Auto-Discovery:** MCU boards are automatically listed in the client list for easy setup.

#### 📡 Connectivity & Status

- **MQTT Based Communication:** Fast and reliable remote control over the internet.
- **LED Indicators:**
  - **Fast Blinking:** Connecting to WiFi.
  - **Slow Blinking:** Configuration Mode active.
  - **Solid ON:** Connected and ready.

### 📝 Configuration Patterns

- Integrated support for the new MQTT topic pattern for multi-device management.
- Persistent storage for schedules and configurations.

---
*For more details on how to use these features, refer to the [User Guide](user_guide.md).*
