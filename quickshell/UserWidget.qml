import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import "core"
import "components"

Item {
    id: root
    property string username
    required property var parentWindow
    implicitWidth: content.implicitWidth + Theme.padding2
    implicitHeight: parent.height

    Rectangle {
        id: background
        anchors.fill: parent
        radius: Theme.radius
        color: Theme.background

        TapHandler {
            onTapped: popup.isOpen ? popup.close() : popup.open()
        }
    }

    RowLayout {
        id: content
        anchors.centerIn: parent

        Text {
            text: root.username
            font.family: Theme.fontFamily
            font.bold: true
            color: Theme.textPrimary
            font.pixelSize: Theme.fontSize
        }
    }

    StyledPopup {
        id: popup
        parentWin: root.parentWindow
        anchorRectX: root.parentWindow.width - width
        xOffset: -10
        yOffset: 10
        implicitWidth: 300
        implicitHeight: 400

        Rectangle {
            anchors.fill: parent
        }
    }

    Process {
        id: whoamiProc
        command: ["whoami"]
        running: true
        stdout: SplitParser {
            onRead: data => root.username = data.trim()
        }
    }
}
