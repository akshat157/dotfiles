import QtQuick 6.0

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "../core"

PanelWindow {
    id: screenshotOverlayRoot
    color: "#55000000"
    visible: Globals.screenshotOverlayOpen
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    WlrLayershell.namespace: "quickshell:screenshotOverlay"
    WlrLayershell.layer: WlrLayer.Overlay
    // WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    // WlrLayershell.exclusiveZone: -1

    Keys.onPressed: event => {
        if (event.key === Qt.Key_Escape) {
            screenshotOverlayRoot.hide();
        }
    }
    function show() {
        Globals.screenshotOverlayOpen = true;
    }

    function hide() {
        // Activating the screenshotOverlay enables a submap with no keybindings to disable the SUPER key keybinds.
        // The line below resets that submap when the screenshotOverlay is hidden.
        Quickshell.execDetached(["hyprctl", "eval", "hl.dispatch(hl.dsp.submap(\"reset\"))"]);
        Globals.screenshotOverlayOpen = false;
    }

    IpcHandler {
        target: "screenshotOverlay"

        function toggle(): void {
            Globals.screenshotOverlayOpen ? screenshotOverlayRoot.hide() : screenshotOverlayRoot.show();
        }
    }
    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }

    Item {
        id: selectionRegion
        anchors.fill: parent
        property point startPoint
        property rect selection
        property bool isSelecting: false

        function begin(p: point) {
            selectionRegion.isSelecting = true;
            selectionRegion.startPoint = p;
            selectionRegion.finalX = p.x;
            selectionRegion.finalY = p.y;
            selectionRegion.finalWidth = 0;
            selectionRegion.finalHeight = 0;
        }

        function update(p: point) {
            const x = Math.min(selectionRegion.startPoint.x, p.x);
            const y = Math.min(selectionRegion.startPoint.y, p.y);

            const width = Math.abs(p.x - selectionRegion.startPoint.x);
            const height = Math.abs(p.y - selectionRegion.startPoint.y);

            selectionRegion.finalX = x;
            selectionRegion.finalY = y;
            selectionRegion.finalWidth = width;
            selectionRegion.finalHeight = height;
        }

        function finish() {
            const x = selectionRegion.finalX;
            const y = selectionRegion.finalY;
            const w = selectionRegion.finalWidth;
            const h = selectionRegion.finalHeight;
            const shotRegion = `${x},${y} ${w}x${h}`;
            const filePath = "$(xdg-user-dir PICTURES)" + "/" + "$(date)" + "%s.png";

            Quickshell.execDetached(["sh", "-c", "grim", "-g", shotRegion, filePath]);
            screenshotOverlayRoot.hide();
        }

        property real startWidth: 0
        property real startHeight: 0

        property real finalX: 0
        property real finalY: 0
        property real finalWidth: 0
        property real finalHeight: 0

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            z: 5

            onPressed: mouse => selectionRegion.begin(Qt.point(mouse.x, mouse.y))

            onPositionChanged: mouse => {
                if (pressed) {
                    selectionRegion.update(Qt.point(mouse.x, mouse.y));
                }
            }

            onReleased: mouse => selectionRegion.finish()
        }

        Rectangle {
            id: overlayLeft
            color: screenshotOverlayRoot.color
            visible: selectionRegion.isSelecting

            x: 0
            y: 0

            width: Math.min(selectionRegion.startPoint.x, selectionRegion.finalX)
            height: parent.height
        }

        Rectangle {
            id: overlayTop
            color: screenshotOverlayRoot.color
            visible: selectionRegion.isSelecting

            x: Math.min(selectionRegion.startPoint.x, selectionRegion.finalX)
            y: 0

            width: parent.width
            height: selectionRegion.finalY
        }

        Rectangle {
            id: overlayRight
            color: screenshotOverlayRoot.color
            visible: selectionRegion.isSelecting

            x: selectionRegion.finalX + selectionRegion.finalWidth
            y: selectionRegion.finalY

            width: parent.width - overlayLeft.width - selectionRegion.finalWidth
            height: parent.height - overlayTop.height
        }

        Rectangle {
            id: overlayBottom
            color: screenshotOverlayRoot.color
            visible: selectionRegion.isSelecting

            x: Math.min(selectionRegion.startPoint.x, selectionRegion.finalX)
            y: selectionRegion.finalY + selectionRegion.finalHeight

            width: selectionRegion.finalWidth
            height: parent.height - overlayTop.height - selectionRegion.finalHeight
        }

        Rectangle {
            x: selectionRegion.finalX
            y: selectionRegion.finalY
            width: selectionRegion.finalWidth
            height: selectionRegion.finalHeight

            color: "transparent"
            radius: Theme.radius

            border {
                color: Theme.background
                width: 2
            }
        }
    }
}
