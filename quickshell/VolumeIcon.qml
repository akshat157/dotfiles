import QtQuick

import "services"

Item {
    id: root
    property var sink: Audio.sink
    required property color color
    required property int fontSize
    required property string fontFamily     // Ideally, a nerd font that supports the speaker icons used below

    implicitWidth: icon.width
    implicitHeight: icon.height

    Text {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        text: {
            let audio = root.sink?.audio;
            if (!audio)
                return "";
            if (audio.muted)
                return "";
            if (audio.volume < 0.33)
                return "";
            if (audio.volume < 0.67)
                return "";
            return "";
        }
        color: root.color
        font.family: root.fontFamily
        font.pixelSize: root.fontSize
    }
    MouseArea {
        anchors.fill: parent
        onClicked: Audio.toggleMute()
    }
}
