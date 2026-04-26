import QtQuick
import Quickshell
import Quickshell.Hyprland

PopupWindow {
    id: root
    default property alias content: container.children
    required property var parentWin
    property int anchorRectX: 0
    property bool isOpen: false
    property bool shown: isOpen
    property int xOffset
    property int yOffset

    property real restY: parentWin.height
    property real currentY: restY

    anchor.window: parentWin
    anchor.rect.x: anchorRectX + xOffset
    anchor.rect.y: currentY + yOffset
    color: "transparent"

    Behavior on currentY {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    visible: isOpen || closeTimer.running

    Item {
        id: container
        anchors.fill: parent
        focus: true
        Keys.onPressed: root.close()
        scale: root.shown ? 1 : 0.90
        opacity: root.shown ? 1 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad
            }
        }
    }

    function open() {
        if (isOpen)
            return;
        isOpen = true;
        currentY = restY;
        shown = true;
    }

    function close() {
        if (!isOpen || closeTimer.running)
            return;
        shown = false;
        currentY = restY - implicitHeight * 0.075;
        // Qt.callLater(() => shown = false);
        closeTimer.restart();
    }

    Timer {
        id: closeTimer
        interval: 250
        onTriggered: {
            root.isOpen = false;
        }
    }

    HyprlandFocusGrab {
        id: focusGrab

        active: root.isOpen

        onCleared: {
            if (root.isOpen)
                root.close();
        }
        windows: [root]
    }
}
