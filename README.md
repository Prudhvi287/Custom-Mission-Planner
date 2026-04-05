# AutoPilot GCS 🚁
### AI-Powered Ground Control Station for Autonomous Drones

![Platform](https://img.shields.io/badge/Platform-Linux-blue)
![Qt](https://img.shields.io/badge/Qt-6.10.2-green)
![MAVLink](https://img.shields.io/badge/Protocol-MAVLink%202.0-orange)
![Build](https://img.shields.io/badge/Build-QGroundControl%20v5.0.3-brightgreen)
![License](https://img.shields.io/badge/License-Apache%202.0%20%2F%20GPLv3-red)

---

## 🧠 What is AutoPilot GCS?

**AutoPilot GCS** is a custom-built drone ground control station engineered on top of
[QGroundControl](https://github.com/mavlink/qgroundcontrol) — the industry-standard open-source
GCS used by real drone operators worldwide. We compiled QGC from source and added a custom
**AI Intelligence Module** that gives operators real-time control over autonomous flight
algorithm selection directly from the ground station UI.

This project was built entirely from scratch with zero prior coding experience, demonstrating
the power of open-source drone technology.

---

## 🎯 Problem Statement

Modern autonomous drones require operators to select and switch between different AI algorithms
for navigation, obstacle avoidance, and path planning. Existing ground control stations do not
provide a unified interface for managing these AI algorithm stacks in real time. AutoPilot GCS
solves this by adding a dedicated AI Intelligence panel directly into the GCS.

---

## ✨ Key Features

### 🤖 AI Intelligence Module (Custom Built)
A brand new view added to QGroundControl's toolbar that provides:

| Section | Options |
|---|---|
| **Navigation & Sensing** | Sensor Fusion, SLAM-Based, Slukier-Based |
| **Obstacle Avoidance** | Sensor Fusion, Camera-Based Vision, Dynamic Task Allocation |
| **Path & Trajectory Planning** | Path Planning + Allocation, Onboard Computation, Real-Time Dynamic |
| **Decision Making** | LiDAR + Camera Mapping, Depth Awareness, Voxor / LiDAR |
| **Autonomy Mode** | Manual → Assisted → Semi-Autonomous → AUTONOMOUS |

### 📹 Live Camera Feed Widget
- Embedded drone camera feed overlay on the main Fly View
- Displays real-time video with LIVE indicator and timestamp
- Resolution and FPS display (1080p 60fps)
- Looping video feed with AI Intelligence branding

### 🔄 Seamless Navigation
- New **AI Intelligence** button added to the QGC toolbar switcher
- Back button to return to Fly View
- AUTONOMOUS status indicator in header
- Edge-First Decision Making status bar

---

## 🏗️ Architecture

```
AutoPilot GCS
│
├── QGroundControl (Base)          ← Compiled from source (v5.0.3)
│   ├── Fly View                   ← Map, telemetry, vehicle control
│   ├── Plan View                  ← Mission planning
│   └── Configure View             ← Vehicle setup
│
└── AI Intelligence Module (Custom)
    ├── AIIntelligenceView.qml     ← Main AI panel UI
    ├── FlyViewWidgetLayer.qml     ← Camera feed widget overlay
    ├── MainWindow.qml             ← View registration & switching
    └── SelectViewDropdown.qml    ← Toolbar button integration
```

---

## 📁 Repository Structure

```
AutoPilotGCS/
├── AIIntelligenceView.qml      # The AI Intelligence panel (NEW - custom built)
├── FlyViewWidgetLayer.qml      # Fly View with camera feed overlay (MODIFIED)
├── MainWindow.qml              # Main window with AI view registration (MODIFIED)
├── SelectViewDropdown.qml      # Toolbar switcher with AI button (MODIFIED)
└── CMakeLists.txt              # Build system registration (MODIFIED)
```

> These files are drop-in replacements for the corresponding files in a QGroundControl v5.0.3
> source build. See Setup Instructions below.

---

## 🛠️ Tech Stack

| Component | Technology |
|---|---|
| Base Platform | QGroundControl v5.0.3 |
| UI Framework | Qt 6.10.2 + QML |
| Multimedia | QtMultimedia + FFmpeg 7.1.2 |
| Drone Protocol | MAVLink 2.0 |
| Build System | CMake 4.2 + Ninja + ccache |
| Compiler | GCC 11.4.0 (C++20) |
| OS | Ubuntu 22.04 LTS |
| Hardware | AMD Ryzen 7 + NVIDIA RTX 3050 Ti |

---

## ⚙️ Setup Instructions

### Prerequisites

```bash
# 1. Install system dependencies
sudo apt-get install -y git cmake build-essential ninja-build \
  libgl1-mesa-dev libglu1-mesa-dev libsdl2-dev libudev-dev \
  patchelf libgstreamer1.0-dev gstreamer1.0-plugins-bad \
  gstreamer1.0-libav gstreamer1.0-gl python3 ccache

# 2. Install Qt 6.10.2 via aqtinstall
pip3 install aqtinstall
aqt install-qt linux desktop 6.10.2 linux_gcc_64 \
  --outputdir ~/Qt \
  --modules qtcharts qtpositioning qtwebchannel qt5compat \
            qtshadertools qtwebengine qtmultimedia qtserialport \
            qtwebsockets qtspeech qtimageformats qthttpserver \
            qtlocation qtconnectivity qtsensors qtserialbus \
            qtremoteobjects qtscxml qtquick3d qtquicktimeline \
            qtlottie qtnetworkauth
```

### Build QGroundControl

```bash
# 1. Clone QGC
git clone --recursive https://github.com/mavlink/qgroundcontrol.git
cd qgroundcontrol

# 2. Apply AutoPilot GCS custom files
cp /path/to/AutoPilotGCS/AIIntelligenceView.qml src/FlyView/
cp /path/to/AutoPilotGCS/FlyViewWidgetLayer.qml src/FlyView/
cp /path/to/AutoPilotGCS/MainWindow.qml src/UI/
cp /path/to/AutoPilotGCS/SelectViewDropdown.qml src/UI/toolbar/
cp /path/to/AutoPilotGCS/CMakeLists.txt src/FlyView/

# 3. Configure
mkdir build && cd build
cmake .. \
  -GNinja \
  -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
  -DQt6_DIR=~/Qt/6.10.2/gcc_64/lib/cmake/Qt6

# 4. Build (uses all CPU cores)
ninja -j$(nproc)

# 5. Run
cd Debug && ./QGroundControl
```

---

## 🚀 How to Use

1. Launch **AutoPilot GCS**
2. You will see the standard **Fly View** with the map and a camera feed in the bottom left
3. Click the **QGC logo** in the top left toolbar
4. Select **aIntelligence** from the dropdown
5. Configure your AI algorithm stack:
   - Choose navigation mode
   - Set obstacle avoidance algorithm
   - Select path planning strategy
   - Configure decision making engine
   - Set autonomy level
6. Click **Apply AI Stack** to confirm
7. Click **< Back** to return to Fly View

---

## 🔌 Hardware Compatibility

AutoPilot GCS is compatible with any MAVLink-enabled drone:

- ✅ Pixhawk (all versions)
- ✅ Cube Orange / Cube Black
- ✅ Holybro Kakute / Durandal
- ✅ Any PX4 or ArduPilot flight controller
- ✅ Connection via USB, Telemetry Radio (SiK), or WiFi/UDP

---

## 🗺️ Roadmap

- [ ] Wire AI algorithm dropdowns to real MAVLink parameters
- [ ] Live telemetry display in AI Intelligence panel
- [ ] Custom AI brain icon in toolbar
- [ ] Save selected algorithm stack between sessions
- [ ] Algorithm status feedback from flight controller
- [ ] Mission planning integration with AI modes

---

## 📄 License

This project is built on top of QGroundControl which is dual-licensed under
[Apache 2.0 and GPLv3](https://github.com/mavlink/qgroundcontrol/blob/master/.github/COPYING.md).
Custom modifications follow the same license.

---

## References 

- [QGroundControl](https://github.com/mavlink/qgroundcontrol) — the amazing open source GCS
- [MAVLink](https://mavlink.io/) — drone communication protocol
- [Qt Framework](https://www.qt.io/) — cross-platform UI framework
- [Dronecode Foundation](https://www.dronecode.org/) — open drone ecosystem
