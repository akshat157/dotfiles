import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
  property bool hasActiveWindow: Hyprland.activeToplevel && Hyprland.activeToplevel.workspace.id === Hyprland.focusedWorkspace.id

  Layout.preferredWidth: 200
  opacity: hasActiveWindow ? 1 : 0
  Rectangle {
    id: activeWindowTitle
    visible: Hyprland.activeToplevel !== null
    anchors.fill: parent
    color: "#F7FFF7"

    Text {
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      color: "#1A535C"
      text: Hyprland.activeToplevel?.title || "No window"
      elide: Text.ElideRight
      width: parent.width - 20
      horizontalAlignment: Text.AlignHCenter
    }
    radius: 16
  }

  Behavior on opacity {
    NumberAnimation { duration: 250 }
  }
}
