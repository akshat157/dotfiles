import QtQuick
import QtQuick.Controls

import "../../core"

Button {
    id: root

    property color idleColor: Theme.background
    property color labelColor: Theme.textPrimary
    property color hoverColor: Theme.primaryGhost
    property color pressedColor: Theme.primary

    background: Rectangle {
        implicitWidth: 128
        implicitHeight: 128
        radius: Theme.radius
        color: root.down ? root.pressedColor : root.hovered ? root.hoverColor : root.idleColor
    }

    contentItem: Label {
        color: root.labelColor

        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight

        font.pixelSize: 48

        text: root.text
    }
}
