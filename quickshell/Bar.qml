import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            // screen from the screens list will be injected into this property
            required property var modelData
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
                anchors.topMargin: 6
                // LEFT
                RowLayout {
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                        leftMargin: 10
                    }
                    spacing: 4

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
                        anchors.centerIn: parent
                    }
                }

                // RIGHT
                RowLayout {
                    anchors {
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                        rightMargin: 10
                    }
                    spacing: 4

                    VolumeWidget {
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
