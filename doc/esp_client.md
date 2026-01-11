# 🔌 ESP8266 Client

Welcome to the **ESP8266 Client**! This guide provides everything you need to know to set up, install, and operate your device with our custom firmware.

---

## 🚀 Firmware Installation

Get your device up and running in minutes using our web-based installer.

1. **Get the Firmware**: Request the download link from our support team.
2. **Connect**: Plug your ESP8266 into your computer via a reliable USB cable.
3. **Open Installer**: Navigate to [web.esphome.io](https://web.esphome.io/) in a Chrome or Edge browser.
4. **Link Device**: Click **Connect** and select your ESP8266's COM port.
5. **Flash**: Upload the provided firmware file.
6. **Success**: Once finished, your device is ready for configuration!

---

## 📶 WiFi Configuration

If the device cannot find a saved WiFi network, it will automatically enter **Configuration Mode**.

1. **Connect to AP**: Search for a WiFi network named `ESP8266_Config_Portal` on your smartphone and connect.
2. **Access Portal**: Your browser should open automatically. If not, go to `http://192.168.4.1/`.
3. **Configure**: Enter your local WiFi **SSID** and **Password**.
4. **Save & Restart**: Click **Connect**. The device will save the credentials and reboot to connect to your network.

---

## 🔘 Resetting WiFi Settings

Need to move the device to a new network? You can easily reset the stored credentials.

* **Action**: Press and hold the button connected to **D3 (GPIO 0)** for **3 seconds**.
* **Result**: The status LED will signal the reset, and the device will restart in **Configuration Mode** (AP mode).

---

## 💡 Status Indicators (Built-in LED)

The onboard LED (D4/GPIO 2) provides instant feedback on the system's state:

| LED Pattern | System Status |
| :--- | :--- |
| **Fast Blinking (200ms)** | 📶 Searching for WiFi... |
| **Slow Blinking (1s)** | 🛠️ Configuration Mode (AP) Active |
| **Solid ON** | ✅ Connected to WiFi & MQTT |

---

## 🔌 Relay & Pin Layout

The firmware controls 4 relays. These pins use **Active Low** logic, compatible with standard relay modules.

| Digital Pin | GPIO | Function | Control Topic |
| :--- | :--- | :--- | :--- |
| **D1** | 5 | Relay 1 | `[DeviceID]/command/d1` |
| **D2** | 4 | Relay 2 | `[DeviceID]/command/d2` |
| **D6** | 12 | Relay 3 | `[DeviceID]/command/d6` |
| **D7** | 13 | Relay 4 | `[DeviceID]/command/d7` |

> [!IMPORTANT]
> To trigger a relay **ON**, send the MQTT payload `ON`. To turn it **OFF**, send `OFF`.

---

## 📱 ESP Buttons App Integration

This firmware is designed to work seamlessly with the **ESP Buttons** mobile app.

1. **Find Device ID**: Check the Serial Monitor (115200 baud) or the Config Portal for your unique ID (e.g., `ESP8266-AA:BB:CC`).
2. **Add to App**:
    * Open the **ESP Buttons** app.
    * Your device will appear in the **Client List**.
    * Expand the client entry and tap **Add New Switch**.
    * Assign the output pin (**D1, D2, D6, or D7**) to match your hardware wiring.
3. **Control**: Connect your relay, and you're ready! Toggle your valves or appliances from anywhere.

---

## 📺 Video Demo

> [!TIP]
> Seeing is believing! Watch the video below for a step-by-step walkthrough of the installation and app setup process.

[**▶️ Watch the ESP8266 Water Valve Demo**](https://example.com/demo-video-link)

---

## 🛠️ Summary Reference Table

| Component | Pin | GPIO | Action / Description | Default State |
| :--- | :--- | :--- | :--- | :--- |
| **WiFi Reset** | D3 | 0 | Hold 3s to reset WiFi | Pull-up (High) |
| **Relay 1** | D1 | 5 | Main Valve Control | OFF (High) |
| **Relay 2** | D2 | 4 | Secondary Valve | OFF (High) |
| **Relay 3** | D6 | 12 | Auxiliary Output | OFF (High) |
| **Relay 4** | D7 | 13 | Auxiliary Output | OFF (High) |
| **Status LED** | D4 | 2 | System Connectivity | ON (Connected) |

---

## 💼 Business & Partnership

Are you looking to scale this solution? We offer professional services for:

* **White-labeling:** Custom-branded versions of the firmware and app.
* **Bespoke hardware:** Proprietary relay controllers and IoT nodes.
* **System Integration:** End-to-end automation for hotels, vertical farming, and smart factories.

### Get in Touch

* 📧 **Email:** [rajendrarajaramv@gmail.com](mailto:rajendrarajaramv@gmail.com)
* 🌐 **Portfolio:** [iamrajendraverma.github.io](https://iamrajendraverma.github.io)
* 👔 **LinkedIn:** [Connect on LinkedIn](https://linkedin.com/in/rajendrarajaramv)

---
*Developed with passion for the IoT community.*

**© 2026 Rajendra Verma**
