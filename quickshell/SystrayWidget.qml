pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.SystemTray

import "core"

Item {
    id: root
    required property var parentWindow
    implicitWidth: content.implicitWidth + Theme.padding2
    implicitHeight: parent.height

    Rectangle {
        anchors.fill: parent
        radius: Theme.radius
        color: Theme.background
    }

    RowLayout {
        id: content
        anchors.centerIn: parent
        spacing: Theme.spacing1

        Repeater {
            model: SystemTray.items

            delegate: Item {
                required property SystemTrayItem modelData
                property int size: 20
                implicitWidth: size
                implicitHeight: size

                Image {
                    anchors.fill: parent
                    source: parent.modelData.icon
                    fillMode: Image.PreserveAspectFit
                }

                TapHandler {
                    onTapped: (eventPoint, button) => {
                        if (button === Qt.LeftButton) {
                            parent.modelData.activate();
                        } else if (button === Qt.MiddleButton) {
                            parent.modelData.secondaryActivate();
                        }
                    }
                }

                TapHandler {
                    acceptedButtons: Qt.RightButton
                    onTapped: eventPoint => {
                        parent.modelData.display(root.parentWindow, Math.round(eventPoint.scenePosition.x), Math.round(eventPoint.scenePosition.y));
                    }
                }

                // ToolTip.visible: hoverHandler.hovered && modelData.tooltipTitle !== ""
                // ToolTip.text: modelData.tooltipTitle

                // HoverHandler {
                //     id: hoverHandler
                // }
            }
        }
    }
}
