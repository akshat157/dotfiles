import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import "core"
import "components"

Item {
    id: root
    required property var parentWindow
    property bool hasActiveWindow: Hyprland.activeToplevel && Hyprland.activeToplevel.workspace.id === Hyprland.focusedWorkspace.id

    Layout.preferredWidth: 180
    opacity: hasActiveWindow ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }

    Rectangle {
        id: activeWindowTitle
        visible: Hyprland.activeTopLevel !== null
        implicitWidth: content.width + Theme.padding1
        anchors.fill: parent
        color: Theme.background
        radius: Theme.radius

        TapHandler {
            acceptedButtons: Qt.RightButton
            onTapped: popup.isOpen ? popup.close() : popup.open()
        }
    }

    Text {
        id: content
        anchors.verticalCenter: parent.verticalCenter
        anchors.centerIn: parent
        color: Theme.primary
        text: Hyprland.activeToplevel?.title || "No window"
        font.family: Theme.fontFamily
        elide: Text.ElideRight
        width: parent.width - Theme.padding2
        horizontalAlignment: Text.AlignHCenter
    }

    StyledPopup {
        id: popup
        parentWin: root.parentWindow
        anchorRectX: root.x
        xOffset: 0
        yOffset: 10
        implicitWidth: 200

        ActiveWindowPopup {
            anchors.fill: parent
            lastWindow: Hyprland.activeToplevel

        }
    }
}
