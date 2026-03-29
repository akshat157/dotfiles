pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    // Clock
    property bool showSeconds: adapter.showSeconds
    property bool use24h: adapter.use24h

    // Workspaces
    property int maxWorkspaces: adapter.maxWorkspaces

    // Animations
    property bool animationsEnabled: adapter.animationsEnabled

    // Local
    property bool isRecentlySaved: false
    function save(): void {
        saveTimer.restart();
        isRecentlySaved = true;
        recentSaveTimer.restart();
    }

    function serializeConfig() {
        return {
            showSeconds: adapter.showSeconds,
            use24h: adapter.use24h,
            maxWorkspaces: adapter.maxWorkspaces,
            animationsEnabled: adapter.animationsEnabled
        };
    }

    Timer {
        id: saveTimer
        interval: 500
        onTriggered: {
            let config = serializeConfig();
            fileView.setText(JSON.stringify(config, null, 2));
        }
    }

    Timer {
        id: recentSaveTimer
        interval: 2000
        onTriggered: isRecentlySaved = false
    }

    FileView {
        id: fileView
        path: Quickshell.shellDir + "/settings.json"
        watchChanges: true
        onFileChanged: {
            if (!isRecentlySaved)
                reload();
        }

        onLoaded: {
            console.debug("Load successful for settings.json");
        }

        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound) {
                // First ever run
                let defaultConfig = serializeConfig();
                fileView.setText(JSON.stringify(defaultConfig, null, 2));
            } else {
                console.error("Failed to load settings.json:", FileViewError.toString(error));
            }
        }

        JsonAdapter { // qmllint disable unresolved-type
            id: adapter

            property bool showSeconds: false
            property bool use24h: false
            property int maxWorkspaces: 8
            property bool animationsEnabled: true
        }
    }
}
