import QtQuick
import QtQuick.Controls

import "../core"

Button {
    id: root

    property color idleColor
    property color labelColor
    property color hoverColor
    property color pressedColor

    background: Rectangle {
        implicitWidth: root.width || 64
        implicitHeight: root.height || 48
        radius: Theme.radius
        color: root.down ? root.pressedColor : root.hovered ? root.hoverColor : root.idleColor
    }

    contentItem: Label {
        color: root.labelColor

        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight

        font.pixelSize: 20

        text: root.text
    }
}
