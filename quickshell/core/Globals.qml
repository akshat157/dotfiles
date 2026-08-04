pragma Singleton

import QtQuick

QtObject {
    id: globals
    property bool powerMenuOpen: false
    property bool screenshotOverlayOpen: false
    property bool launcherOpen: false

    function closeAll() {
        powerMenuOpen = false;
        screenshotOverlayOpen = false;
        launcherOpen = false;
    }
}
