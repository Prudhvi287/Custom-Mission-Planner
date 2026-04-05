# AutoPilot GCS
### Custom AI Autonomy Module — Built on QGroundControl

---

## What is AutoPilot GCS?

AutoPilot GCS is a custom drone ground control station built on top of [QGroundControl](https://github.com/mavlink/qgroundcontrol). We compiled QGC from source and added an **AI Intelligence Module** — a new panel that lets operators select autonomous flight algorithms in real time. The system has been verified with a real flight controller via MAVLink protocol.

This is the first module of a larger autonomy product developed for the *Technology, Product & Entrepreneurship* course.

---

## What We Custom Built

| File | What it does |
|---|---|
| `src/AIIntelligenceView.qml` | NEW — Full AI algorithm selection panel |
| `src/FlyViewWidgetLayer.qml` | Added live camera feed overlay widget |
| `src/MainWindow.qml` | Registered AI view + showAIView() function |
| `src/SelectViewDropdown.qml` | Added AI Intelligence toolbar button |
| `src/CMakeLists.txt` | Registered new QML file in build system |

---

## AI Intelligence Panel Features

- Navigation & Sensing — Sensor Fusion / SLAM
- Obstacle Avoidance — Camera Vision / Dynamic Task Allocation
- Path Planning — Real-Time Dynamic / Onboard Computation
- Decision Making — LiDAR + Camera / Depth Awareness / Voxor
- Autonomy Mode — Manual / Assisted / Semi-Auto / AUTONOMOUS
- Live Camera Feed — Embedded drone video overlay on Fly View
- Flight Controller — Verified MAVLink connection with real hardware

---

## How to Install on Your PC

### 1. Clone QGroundControl
```bash
git clone --recursive https://github.com/mavlink/qgroundcontrol.git
cd qgroundcontrol
```

### 2. Install Qt 6.10.2
```bash
pip3 install aqtinstall
aqt install-qt linux desktop 6.10.2 linux_gcc_64 --outputdir ~/Qt \
  --modules qtcharts qtpositioning qtwebchannel qt5compat qtshadertools \
  qtwebengine qtmultimedia qtserialport qtwebsockets qtspeech \
  qtimageformats qthttpserver qtlocation qtconnectivity qtsensors \
  qtserialbus qtremoteobjects qtscxml qtquick3d qtlottie qtnetworkauth
```

### 3. Copy AutoPilot GCS custom files
```bash
cp src/AIIntelligenceView.qml   qgroundcontrol/src/FlyView/
cp src/FlyViewWidgetLayer.qml   qgroundcontrol/src/FlyView/
cp src/MainWindow.qml           qgroundcontrol/src/UI/
cp src/SelectViewDropdown.qml   qgroundcontrol/src/UI/toolbar/
cp src/CMakeLists.txt           qgroundcontrol/src/FlyView/
```

### 4. Build and Run
```bash
cd qgroundcontrol && mkdir build && cd build
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
  -DQt6_DIR=~/Qt/6.10.2/gcc_64/lib/cmake/Qt6
ninja -j$(nproc)
cd Debug && ./QGroundControl
```

---

## Tech Stack

| Component | Technology |
|---|---|
| Base Platform | QGroundControl v5.0.3 compiled from source |
| UI Framework | Qt 6.10.2 + QML + QtMultimedia |
| Protocol | MAVLink 2.0 (PX4 / ArduPilot compatible) |
| Build System | CMake 4.2 + Ninja + ccache + GCC 11.4 |

---

## Roadmap

- Wire algorithm dropdowns to MAVLink parameters
- Real-time telemetry in AI panel
- Full autonomous mission execution from AI stack
- Cloud-based algorithm deployment

---

## Author

Prudhvi — github.com/Prudhvi287
Course: Technology, Product & Entrepreneurship
