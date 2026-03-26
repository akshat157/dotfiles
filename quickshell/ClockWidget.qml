import QtQuick
import "services"

Item {
    implicitWidth: timeText.implicitWidth + 16
    implicitHeight: parent.height

    Rectangle {
        anchors.fill: parent
        color: "#F7FFF7"
        radius: 16
        Text {
            id: timeText
            anchors.centerIn: parent
            color: "#1A535C"
            font.family: "0xProto Nerd Font"
            text: Time.time
            font.pixelSize: 14
            font.bold: true
        }
    }
}
