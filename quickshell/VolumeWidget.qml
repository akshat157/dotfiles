import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

Item {
    id: root
    implicitWidth: Math.max(64, content.implicitWidth) + 16
    implicitHeight: parent.height

    property PwNode sink: Pipewire.defaultAudioSink

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: "#F7FFF7"
    }
    RowLayout {
        id: content
        anchors.centerIn: parent
        spacing: 4

        Text {
            Layout.alignment: Qt.AlignVCenter
            text: {
                let audio = root.sink?.audio;
                if (!audio)
                    return "";
                if (audio.muted)
                    return "";   // muted icon
                if (audio.volume < 0.3)
                    return "";
                if (audio.volume < 0.7)
                    return "";
                return "";
            }
            color: "#1A535C"
            font.family: "0xProto Nerd Font"
            font.pixelSize: 18
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
            color: "#1A535C"
            font.pixelSize: 14
            font.family: "0xProto Nerd Font"
            font.bold: true
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (root.sink && root.sink.audio)
                root.sink.audio.muted = !root.sink.audio.muted;
        }

        onWheel: event => {
            if (!root.sink || !root.sink.audio)
                return;
            let delta = event.angleDelta.y > 0 ? 0.05 : -0.05;
            let newVol = Math.max(0, Math.min(1.5, root.sink.audio.volume + delta));
            root.sink.audio.volume = newVol;
        }
    }

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }
}
