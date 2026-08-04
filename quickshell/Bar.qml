pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import "core"

Scope {
    id: root
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panelWindow

            WlrLayershell.namespace: "quickshell:bar"
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

            color: "#01F7FFF7"

            Item {
                anchors.fill: parent
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                anchors.leftMargin: panelWindow.panelMarginX
                anchors.rightMargin: panelWindow.panelMarginX
                // LEFT
                RowLayout {
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    spacing: Theme.spacing1

                    AppLauncherWidget {
                        parentWindow: panelWindow
                        Layout.fillHeight: true
                    }

                    Workspaces {
                        Layout.fillHeight: true
                    }

                    ActiveWindowWidget {
                        parentWindow: panelWindow
                        Layout.fillHeight: true
                    }
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

                    MediaWidget {
                        parentWindow: panelWindow
                        Layout.fillHeight: true
                    }

                    ControlCenterWidget {
                        parentWindow: panelWindow
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
