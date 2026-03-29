import QtQuick
import Quickshell
import Quickshell.Hyprland
import "services"
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
            text: `${DateTime.timeStr} ${DateTime.dateStr}`
            font.pixelSize: Theme.fontSize
            font.bold: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: popup.isOpen ? popup.close() : popup.open()
        }
    }

    PopupWindow {
        id: popup
        property bool isOpen: false
        property bool animatingOut: false
        property bool shown: false
        property int yOffset: 10
        property real targetY: root.parentWindow.height + yOffset
        property real currentY: targetY

        anchor.window: root.parentWindow
        anchor.rect.x: root.parentWindow.width / 2 - (width / 2)
        anchor.rect.y: currentY
        implicitWidth: 600
        implicitHeight: 400
        color: "transparent"

        Behavior on currentY {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        visible: isOpen || animatingOut || shown

        ClockPopup {
            anchors.fill: parent
            shown: popup.shown
        }

        function open() {
            if (isOpen)
                return;
            isOpen = true;
            currentY = targetY;
            animatingOut = false;
            shown = true;
        }

        function close() {
            if (!isOpen)
                return;
            isOpen = false;
            animatingOut = true;
            currentY = targetY - implicitHeight * 0.15;
            Qt.callLater(() => shown = false);
            closeTimer.restart();
        }

        Timer {
            id: closeTimer
            interval: 250
            onTriggered: popup.animatingOut = false
        }

        HyprlandFocusGrab {
            id: focusGrab

            active: popup.isOpen

            onCleared: {
                if (popup.isOpen)
                    popup.close();
            }
            windows: [popup]
        }
    }
}
