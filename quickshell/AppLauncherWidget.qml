import QtQuick
import QtQuick.Layouts

import "core"
import "components"

Item {
    id: root
    required property var parentWindow

    Layout.preferredWidth: 32

    Rectangle {
        id: launcherWidget
        implicitWidth: content.width + Theme.padding1
        anchors.fill: parent
        color: Theme.background
        radius: Theme.radius

        TapHandler {
            acceptedButtons: Qt.LeftButton
            onTapped: function() {
                console.log("clicked!")
            }
        }
    }

    Text {
        id: content
        anchors.verticalCenter: parent.verticalCenter
        anchors.centerIn: parent
        color: Theme.primary
        text: ""
        font.family: Theme.fontFamily
        font.pixelSize: 16
    }
}
