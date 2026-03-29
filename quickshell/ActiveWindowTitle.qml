import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import "core"

Item {
    property bool hasActiveWindow: Hyprland.activeToplevel && Hyprland.activeToplevel.workspace.id === Hyprland.focusedWorkspace.id

    Layout.preferredWidth: 200
    opacity: hasActiveWindow ? 1 : 0
    Rectangle {
        id: activeWindowTitle
        visible: Hyprland.activeToplevel !== null
        anchors.fill: parent
        color: Theme.background

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            color: Theme.primary
            text: Hyprland.activeToplevel?.title || "No window"
            font.family: Theme.fontFamily
            elide: Text.ElideRight
            width: parent.width - Theme.padding2
            horizontalAlignment: Text.AlignHCenter
        }
        radius: Theme.radius
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }
}
