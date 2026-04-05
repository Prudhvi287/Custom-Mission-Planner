import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QGroundControl
import QGroundControl.Controls

Rectangle {
    id:     aiRoot
    color:  qgcPal.window

    QGCPalette { id: qgcPal; colorGroupEnabled: true }

    ScrollView {
        anchors.fill:   parent
        contentWidth:   parent.width
        clip:           true

        ColumnLayout {
            width:      aiRoot.width
            spacing:    ScreenTools.defaultFontPixelHeight * 0.5

            // ── Header ──────────────────────────────
            Rectangle {
                Layout.fillWidth:   true
                height:             ScreenTools.defaultFontPixelHeight * 3.5
                color:              "#0F3460"

                RowLayout {
                    anchors.fill:           parent
                    anchors.leftMargin:     ScreenTools.defaultFontPixelWidth * 2
                    anchors.rightMargin:    ScreenTools.defaultFontPixelWidth * 2
                    spacing:                ScreenTools.defaultFontPixelWidth

                    QGCLabel {
                        text:               qsTr("AI Intelligence — Algorithm Stack")
                        font.bold:          true
                        font.pixelSize:     ScreenTools.defaultFontPixelHeight * 1.3
                        color:              "white"
                    }
		    
                     QGCButton {
                        text:               qsTr("< Back")
                        onClicked :         mainWindow.showFlyView()
                    }

                    Item { Layout.fillWidth: true }
                    Rectangle {
                        width:              ScreenTools.defaultFontPixelWidth * 16
                        height:             ScreenTools.defaultFontPixelHeight * 1.8
                        color:              flightModeCombo.currentIndex === 3 ? "#00B894" : "#E17055"
                        radius:             4
                        QGCLabel {
                            anchors.centerIn:   parent
                            text:               flightModeCombo.currentIndex === 3 ? qsTr("AUTONOMOUS") : qsTr("MANUAL")
                            color:              "white"
                            font.bold:          true
                        }
                    }
                }
            }

            // ── Status Bar ──────────────────────────
            Rectangle {
                Layout.fillWidth:       true
                Layout.leftMargin:      ScreenTools.defaultFontPixelWidth
                Layout.rightMargin:     ScreenTools.defaultFontPixelWidth
                height:                 ScreenTools.defaultFontPixelHeight * 1.8
                color:                  "#1A3A2A"
                radius:                 4
                RowLayout {
                    anchors.fill:           parent
                    anchors.leftMargin:     ScreenTools.defaultFontPixelWidth
                    anchors.rightMargin:    ScreenTools.defaultFontPixelWidth
                    QGCLabel {
                        text:               "● " + qsTr("Edge-First Decision Making")
                        color:              "#00B894"
                        font.pixelSize:     ScreenTools.defaultFontPixelHeight * 0.85
                    }
                    Item { Layout.fillWidth: true }
                    QGCLabel {
                        text:               "● " + qsTr("CPU AI Loaded")
                        color:              "#00B894"
                        font.pixelSize:     ScreenTools.defaultFontPixelHeight * 0.85
                    }
                }
            }

            // ── Section 1: Navigation ────────────────
            Rectangle {
                Layout.fillWidth:       true
                Layout.leftMargin:      ScreenTools.defaultFontPixelWidth
                Layout.rightMargin:     ScreenTools.defaultFontPixelWidth
                height:                 navCol.implicitHeight + ScreenTools.defaultFontPixelHeight
                color:                  qgcPal.windowShade
                border.color:           "#334466"
                border.width:           1
                radius:                 6

                ColumnLayout {
                    id:                 navCol
                    anchors.fill:       parent
                    anchors.margins:    ScreenTools.defaultFontPixelHeight * 0.5
                    spacing:            ScreenTools.defaultFontPixelHeight * 0.4

                    QGCLabel {
                        text:           qsTr("Navigation & Sensing Suite")
                        font.bold:      true
                        color:          "#64B5F6"
                    }
                    QGCLabel { text: qsTr("Sensor Fusion Mode") }
                    QGCComboBox {
                        id:             navCombo
                        Layout.fillWidth: true
                        model:          [qsTr("Sensor Fusion (Default)"), qsTr("SLAM-Based"), qsTr("Slukier-Based")]
                    }
                    RowLayout {
                        spacing: ScreenTools.defaultFontPixelWidth
                        QGCCheckBox { text: qsTr("GPS Redundancy");      checked: true  }
                        QGCCheckBox { text: qsTr("Barometer Backup");    checked: false }
                    }
                }
            }

            // ── Section 2: Obstacle Avoidance ────────
            Rectangle {
                Layout.fillWidth:       true
                Layout.leftMargin:      ScreenTools.defaultFontPixelWidth
                Layout.rightMargin:     ScreenTools.defaultFontPixelWidth
                height:                 avoidCol.implicitHeight + ScreenTools.defaultFontPixelHeight
                color:                  qgcPal.windowShade
                border.color:           "#334466"
                border.width:           1
                radius:                 6

                ColumnLayout {
                    id:                 avoidCol
                    anchors.fill:       parent
                    anchors.margins:    ScreenTools.defaultFontPixelHeight * 0.5
                    spacing:            ScreenTools.defaultFontPixelHeight * 0.4

                    QGCLabel {
                        text:           qsTr("Obstacle Avoidance")
                        font.bold:      true
                        color:          "#64B5F6"
                    }
                    QGCLabel { text: qsTr("Avoidance Algorithm") }
                    QGCComboBox {
                        id:             avoidCombo
                        Layout.fillWidth: true
                        model:          [qsTr("Sensor Fusion Avoidance"), qsTr("Camera-Based Vision"), qsTr("Traffic + Dynamic Task Allocation")]
                    }
                    QGCLabel { text: qsTr("Sensitivity Level: ") + Math.round(sensitivitySlider.value) }
                    Slider {
                        id:             sensitivitySlider
                        Layout.fillWidth: true
                        from:           1
                        to:             10
                        value:          5
                        stepSize:       1
                    }
                }
            }

            // ── Section 3: Path Planning ─────────────
            Rectangle {
                Layout.fillWidth:       true
                Layout.leftMargin:      ScreenTools.defaultFontPixelWidth
                Layout.rightMargin:     ScreenTools.defaultFontPixelWidth
                height:                 pathCol.implicitHeight + ScreenTools.defaultFontPixelHeight
                color:                  qgcPal.windowShade
                border.color:           "#334466"
                border.width:           1
                radius:                 6

                ColumnLayout {
                    id:                 pathCol
                    anchors.fill:       parent
                    anchors.margins:    ScreenTools.defaultFontPixelHeight * 0.5
                    spacing:            ScreenTools.defaultFontPixelHeight * 0.4

                    QGCLabel {
                        text:           qsTr("Path & Trajectory Planning")
                        font.bold:      true
                        color:          "#64B5F6"
                    }
                    QGCLabel { text: qsTr("Planning Algorithm") }
                    QGCComboBox {
                        id:             pathCombo
                        Layout.fillWidth: true
                        model:          [qsTr("Path Planning + Allocation"), qsTr("Drone Computation (Onboard)"), qsTr("Real-Time Dynamic Allocation")]
                    }
                    QGCLabel { text: qsTr("Max Replanning Speed") }
                    QGCComboBox {
                        Layout.fillWidth: true
                        model:          ["5 m/s", "10 m/s", "15 m/s", "20 m/s", qsTr("Unlimited")]
                        currentIndex:   1
                    }
                }
            }

            // ── Section 4: Decision Making ───────────
            Rectangle {
                Layout.fillWidth:       true
                Layout.leftMargin:      ScreenTools.defaultFontPixelWidth
                Layout.rightMargin:     ScreenTools.defaultFontPixelWidth
                height:                 decCol.implicitHeight + ScreenTools.defaultFontPixelHeight
                color:                  qgcPal.windowShade
                border.color:           "#334466"
                border.width:           1
                radius:                 6

                ColumnLayout {
                    id:                 decCol
                    anchors.fill:       parent
                    anchors.margins:    ScreenTools.defaultFontPixelHeight * 0.5
                    spacing:            ScreenTools.defaultFontPixelHeight * 0.4

                    QGCLabel {
                        text:           qsTr("Decision Making")
                        font.bold:      true
                        color:          "#64B5F6"
                    }
                    QGCLabel { text: qsTr("Mapping Engine") }
                    QGCComboBox {
                        id:             decisionCombo
                        Layout.fillWidth: true
                        model:          [qsTr("LiDAR + Camera Mapping"), qsTr("Depth Awareness Mode"), qsTr("Voxor / LiDAR Supported")]
                    }
                    RowLayout {
                        spacing: ScreenTools.defaultFontPixelWidth
                        QGCCheckBox { text: qsTr("Depth Awareness");  checked: true }
                        QGCCheckBox { text: qsTr("Voxor Supported");  checked: true }
                    }
                }
            }

            // ── Section 5: Autonomy Mode ─────────────
            Rectangle {
                Layout.fillWidth:       true
                Layout.leftMargin:      ScreenTools.defaultFontPixelWidth
                Layout.rightMargin:     ScreenTools.defaultFontPixelWidth
                height:                 autoCol.implicitHeight + ScreenTools.defaultFontPixelHeight
                color:                  qgcPal.windowShade
                border.color:           "#334466"
                border.width:           1
                radius:                 6

                ColumnLayout {
                    id:                 autoCol
                    anchors.fill:       parent
                    anchors.margins:    ScreenTools.defaultFontPixelHeight * 0.5
                    spacing:            ScreenTools.defaultFontPixelHeight * 0.4

                    QGCLabel {
                        text:           qsTr("Autonomy Mode")
                        font.bold:      true
                        color:          "#64B5F6"
                    }
                    QGCLabel { text: qsTr("Flight Mode") }
                    QGCComboBox {
                        id:             flightModeCombo
                        Layout.fillWidth: true
                        model:          [qsTr("Manual"), qsTr("Assisted"), qsTr("Semi-Autonomous"), qsTr("AUTONOMOUS")]
                        currentIndex:   3
                    }
                }
            }

            // ── Apply Button ─────────────────────────
            RowLayout {
                Layout.fillWidth:       true
                Layout.leftMargin:      ScreenTools.defaultFontPixelWidth
                Layout.rightMargin:     ScreenTools.defaultFontPixelWidth
                Layout.bottomMargin:    ScreenTools.defaultFontPixelHeight

                Item { Layout.fillWidth: true }

                QGCButton {
                    text:       qsTr("Apply AI Stack")
                    primary:    true
                    onClicked: {
                        console.log("[aI] Nav:    ", navCombo.currentText)
                        console.log("[aI] Avoid:  ", avoidCombo.currentText)
                        console.log("[aI] Path:   ", pathCombo.currentText)
                        console.log("[aI] Decision:", decisionCombo.currentText)
                        console.log("[aI] Mode:   ", flightModeCombo.currentText)
                        feedbackBox.visible = true
                        feedbackTimer.restart()
                    }
                }
            }

            // ── Success Feedback ─────────────────────
            Rectangle {
                id:                     feedbackBox
                visible:                false
                Layout.fillWidth:       true
                Layout.leftMargin:      ScreenTools.defaultFontPixelWidth
                Layout.rightMargin:     ScreenTools.defaultFontPixelWidth
                height:                 ScreenTools.defaultFontPixelHeight * 2
                color:                  "#00B894"
                radius:                 4
                Timer {
                    id:         feedbackTimer
                    interval:   3000
                    onTriggered: feedbackBox.visible = false
                }
                QGCLabel {
                    anchors.centerIn:   parent
                    text:               qsTr("✔  AI Stack Applied Successfully")
                    color:              "white"
                    font.bold:          true
                }
            }

            Item { height: ScreenTools.defaultFontPixelHeight }
        }
    }
}
