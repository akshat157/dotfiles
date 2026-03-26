import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    implicitWidth: workspaces.implicitWidth
    Rectangle {
        id: workspaces
        anchors.fill: parent

        color: "#F7FFF7"
        radius: 16
        implicitWidth: rowLayout.implicitWidth + 16

        RowLayout {
            id: rowLayout
            anchors.centerIn: parent
            spacing: 6

            Repeater {
                model: 8

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

                    Layout.preferredWidth: isActive ? 32 : 16
                    Layout.preferredHeight: 16

                    radius: 8

                    color: hoverHandler.hovered ? (isActive ? '#AA1A535C' : (hasWindows ? '#771A535C' : '#221A535C')) : (isActive ? '#1A535C' : (hasWindows ? '#AA1A535C' : '#441A535C'))

                    HoverHandler {
                        id: hoverHandler
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + (index + 1))
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
