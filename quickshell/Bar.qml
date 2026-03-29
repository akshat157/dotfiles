pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

import "core"

Scope {
    id: root
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panelWindow

            // screen from the screens list will be injected into this property
            required property var modelData
            property int panelMarginX: 10       // Expected to be same as the window margin of the window manager
            // Set the window's screen to the injected property
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 32

            color: "transparent"

            Item {
                anchors.fill: parent
                anchors.topMargin: 4
                anchors.leftMargin: panelMarginX
                anchors.rightMargin: panelMarginX
                // LEFT
                RowLayout {
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    spacing: Theme.spacing1

                    Workspaces {
                        Layout.fillHeight: true
                    }

                    // ActiveWindowTitle {
                    //     Layout.fillHeight: true
                    // }
                }

                // CENTER
                Item {
                    anchors.centerIn: parent
                    height: parent.height
                    ClockWidget {
                        id: clock
                        parentWindow: panelWindow
                        anchors.centerIn: parent
                    }
                }

                // RIGHT
                RowLayout {
                    anchors {
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                    }
                    spacing: Theme.spacing1

                    SystrayWidget {
                        parentWindow: panelWindow
                        Layout.fillHeight: true
                    }

                    VolumeWidget {
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
