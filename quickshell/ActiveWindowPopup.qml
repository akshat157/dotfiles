import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import "core"

Item {
    id: root
    property var lastWindow: null

    Rectangle {
        anchors.fill: parent
        radius: Theme.radius
        color: Theme.background
    }

    ColumnLayout {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: Theme.padding2
        anchors.topMargin: Theme.padding2
        spacing: Theme.spacing2

        Text {
            text: "Toggle mode"
            color: Theme.textPrimary
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
        }

        Text {
            text: "Close"
            color: Theme.textPrimary
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize

            TapHandler {
                onTapped: {
                    Hyprland.dispatch(`closewindow address:0x${lastWindow.address}`);
                }
            }
        }
    }
}
