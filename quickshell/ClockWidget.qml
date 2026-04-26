import QtQuick
import "services"
import "components"
import "core"

Item {
    id: root

    required property var parentWindow
    implicitWidth: timeText.implicitWidth + Theme.padding2
    implicitHeight: parent.height

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        radius: Theme.radius

        Text {
            id: timeText
            anchors.centerIn: parent
            color: Theme.primary
            font.family: Theme.fontFamily
            text: `${DateTime.clockStr} ${DateTime.dateStr}`
            font.pixelSize: Theme.fontSize
            font.bold: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: popup.isOpen ? popup.close() : popup.open()
        }
    }

    StyledPopup {
        id: popup
        parentWin: root.parentWindow
        anchorRectX: root.parentWindow.width / 2 - width / 2
        yOffset: 10
        implicitWidth: 600
        implicitHeight: 400

        ClockPopup {
            anchors.fill: parent
        }
    }
}
