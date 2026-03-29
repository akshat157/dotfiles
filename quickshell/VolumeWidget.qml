import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

import "core"

Item {
    id: root
    implicitWidth: Math.max(64, content.implicitWidth) + Theme.padding2
    implicitHeight: parent.height

    property PwNode sink: Pipewire.defaultAudioSink

    Rectangle {
        anchors.fill: parent
        radius: Theme.radius
        color: Theme.background
    }
    RowLayout {
        id: content
        anchors.centerIn: parent
        spacing: Theme.spacing1

        Text {
            Layout.alignment: Qt.AlignVCenter
            text: {
                let audio = root.sink?.audio;
                if (!audio)
                    return "";
                if (audio.muted)
                    return "";   // muted icon
                if (audio.volume < 0.33)
                    return "";
                if (audio.volume < 0.65)
                    return "";
                return "";
            }
            color: Theme.primary
            font.family: Theme.fontFamily
            font.pixelSize: 18

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (root.sink && root.sink.audio)
                        root.sink.audio.muted = !root.sink.audio.muted;
                }
            }
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

        onClicked: event => event.accepted = false

        onWheel: event => {
            if (!root.sink || !root.sink.audio)
                return;
            let delta = event.angleDelta.y > 0 ? 0.01 : -0.01;
            let newVol = Math.max(0, Math.min(1.5, root.sink.audio.volume + delta));
            root.sink.audio.volume = newVol;
        }
    }

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }
}
