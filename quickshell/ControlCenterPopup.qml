pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io

import "core"
import "components"

Item {
    id: root
    property string uptimeStr: "..."
    property string uptimeSinceStr: "..."

    Rectangle {
        anchors.fill: parent
        radius: Theme.radius
        color: Theme.background
    }

    ColumnLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: Theme.padding2

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            Rectangle {
                implicitWidth: uptime.width + Theme.padding2
                implicitHeight: uptime.height + Theme.padding2

                color: Theme.primaryGhost
                radius: Theme.radius
                Layout.alignment: Qt.AlignLeft

                ColumnLayout {
                    id: uptime
                    anchors.centerIn: parent

                    Text {
                        color: Theme.primary
                        font.pixelSize: 12
                        font.family: Theme.fontFamily
                        Layout.alignment: Qt.AlignLeft

                        text: "Uptime"
                    }

                    Text {
                        color: Theme.primary
                        font.pixelSize: 16
                        font.bold: true
                        font.family: Theme.fontFamily
                        Layout.alignment: Qt.AlignLeft

                        text: root.uptimeStr
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            ControlButton {
                width: 64
                height: 48
                idleColor: Theme.primaryGhost
                labelColor: Theme.textPrimary
                hoverColor: Theme.primarySubtle
                pressedColor: Theme.primary
                text: "󰐥"
                onClicked: () => {
                    Globals.powerMenuOpen = true;
                    Quickshell.execDetached(["hyprctl", "eval", "hl.dispatch(hl.dsp.submap(\"powermenu_submap\"))"]);
                }
            }
        }
    }

    Process {
        id: uptimeProc
        command: ["uptime", "-p"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.uptimeStr = text.replace("up ", "").replace(" hours, ", "hr ").replace(" minutes", "min");
            }
        }
    }

    Process {
        id: uptimeSinceProc
        command: ["uptime", "-s"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.uptimeSinceStr = text.split(" ").reverse().join(" ").replace(" ", ", ");
            }
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: uptimeProc.running = true
    }
}
