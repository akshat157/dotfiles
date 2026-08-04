import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import "../core"
import "./components"

PanelWindow {
    id: powerMenuRoot
    color: "#55f7fff7"
    visible: Globals.powerMenuOpen
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    WlrLayershell.namespace: "quickshell:powermenu"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.exclusiveZone: -1

    function hide() {
        // Activating the powermenu enables a submap with no keybindings to disable the SUPER key keybinds.
        // The line below resets that submap when the powermenu is hidden.
        Quickshell.execDetached(["hyprctl", "eval", "hl.dispatch(hl.dsp.submap(\"reset\"))"]);
        Globals.powerMenuOpen = false;
    }

    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }

    TapHandler {
        onTapped: () => powerMenuRoot.hide()
    }

    GridLayout {
        anchors.centerIn: parent
        columns: 3
        columnSpacing: Theme.spacing2 * 2
        rowSpacing: Theme.spacing2 * 2

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                powerMenuRoot.hide();
            }
        }

        PowerMenuButton {
            text: "󰌾"
            focus: powerMenuRoot.visible
            onClicked: () => {
                Quickshell.execDetached(["loginctl", "lock-session"]);
                powerMenuRoot.hide();
            }
        }

        PowerMenuButton {
            text: "󰐥"
            onClicked: () => Quickshell.execDetached(["systemctl", "poweroff"])
        }

        PowerMenuButton {
            text: "󰜉"
            onClicked: () => Quickshell.execDetached(["systemctl", "reboot"])
        }

        PowerMenuButton {
            text: "󰤄"
            onClicked: () => Quickshell.execDetached(["systemctl", "sleep"])
        }

        PowerMenuButton {
            text: "󰍃"
            onClicked: () => console.log("clicked logout")
        }

        PowerMenuButton {
            text: ""
            onClicked: () => console.log("clicked settings")
        }
    }
}
