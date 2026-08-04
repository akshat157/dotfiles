import QtQuick
import QtQuick.Layouts

import "components"
import "core"
import "services"

Item {
    id: root
    required property var parentWindow
    implicitWidth: Math.max(64, content.implicitWidth) + Theme.padding2
    implicitHeight: parent.height

    property var sink: Audio.sink

    Rectangle {
        anchors.fill: parent
        radius: Theme.radius
        color: Theme.background

        RowLayout {
            id: content
            anchors.centerIn: parent
            spacing: Theme.spacing1

            VolumeIcon {
                sink: root.sink
                color: Theme.primary
                fontFamily: Theme.fontFamily
                fontSize: 18
            }

            Text {
                Layout.alignment: Qt.AlignVCenter
                text: {
                    let vol = root.sink?.audio?.volume;
                    if (vol === undefined || isNaN(vol)) {
                        return "--%";
                    }

                    return Math.round(vol * 100) + '%';
                }
                color: Theme.primary
                font.pixelSize: Theme.fontSize
                font.family: Theme.fontFamily
                font.bold: true
            }
        }

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true

            onClicked: popup.isOpen ? popup.close() : popup.open()

            onWheel: event => {
                if (!root.sink || !root.sink.audio)
                return;
                let delta = event.angleDelta.y > 0 ? 0.01 : -0.01;
                let newVol = Math.max(0, Math.min(1.5, root.sink.audio.volume + delta));
                root.sink.audio.volume = newVol;
            }
        }
    }

    StyledPopup {
        id: popup
        parentWin: root.parentWindow
        anchorRectX: root.parentWindow.width - width
        xOffset: -10
        yOffset: 10
        implicitWidth: 400
        implicitHeight: 400

        MediaPopup {
            anchors.fill: parent
        }
    }
}
