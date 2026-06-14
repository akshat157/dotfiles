import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "core"

Item {
    implicitWidth: workspaces.implicitWidth
    Rectangle {
        id: workspaces
        anchors.fill: parent

        color: Theme.background
        radius: Theme.radius
        implicitWidth: rowLayout.implicitWidth + Theme.padding2

        RowLayout {
            id: rowLayout
            anchors.centerIn: parent
            spacing: Theme.spacing1

            Repeater {
                model: Settings.maxWorkspaces
                Rectangle {
                    required property int index
                    property var workspace: {
                        let list = Hyprland.workspaces.values;
                        let id = index + 1;
                        for (let i = 0; i < list.length; i++) {
                            if (list[i].id === id)
                            return list[i];
                        }
                        return null;
                    }

                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                    property bool hasWindows: workspace !== null
                    property int size: 16
                    Layout.preferredWidth: isActive ? size * 2 : size
                    Layout.preferredHeight: size

                    radius: size / 2

                    color: hoverHandler.hovered ? (isActive ? Theme.itemActiveHover : (hasWindows ? Theme.itemOccupiedHover : Theme.itemInactiveHover)) : (isActive ? Theme.itemActive : (hasWindows ? Theme.itemOccupied : Theme.itemInactive))

                    HoverHandler {
                        id: hoverHandler
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace = ${index + 1}})`)
                    }

                    Behavior on Layout.preferredWidth {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
    }
}
