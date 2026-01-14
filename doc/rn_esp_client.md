# Release Notes

## Version 1.0.0 (Initial Release)

Initial release of the ESP8266 client firmware and companion app integration.

### 🚀 Key Features

* **Quad-Relay Support**
  * Control up to 4 independent water valves or electrical devices.

* **Dynamic Switch Types**
  * Support for Binary, Delay, and Interval switches to suit different automation needs.

* **Real-time Status Monitoring**
  * Live MCU status updates directly in the companion app.

* **Effortless WiFi Setup**
  * Built-in Captive Portal for easy network configuration.

### 🔧 Hardware Control

* **Output Pins Support**
  * Supports D1 (GPIO 5), D2 (GPIO 4), D6 (GPIO 12), and D7 (GPIO 13).
  * Active Low Logic compatible with most standard relay modules.

* **One-Touch Reset**
  * Hold button **D3** for 3 seconds to clear WiFi credentials and enter configuration mode.

### 📱 App Integration

* **Switch Control**
  * **Binary Switches**: Standard ON/OFF control for immediate action.
  * **Delay Switches**: Timer-based auto-OFF after a specified duration.
  * **Interval Switches**: Programmable schedules for "Once" or "Daily" operations.

* **Auto-Discovery**
  * MCU boards are automatically listed in the client list for easy setup.

### 📡 Connectivity

* **MQTT Communication**
  * Fast and reliable remote control over the internet.
  * New topic pattern support for multi-device management.

* **LED Indicators**
  * **Fast Blinking**: Connecting to WiFi.
  * **Slow Blinking**: Configuration Mode active.
  * **Solid ON**: Connected and ready.

### 📥 Get Started

* *For more details on how to use these features, refer to the [User Guide](time_tracker.md).*
