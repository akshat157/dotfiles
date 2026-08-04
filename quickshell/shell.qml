//@ pragma UseQApplication

import Quickshell
import QtQuick

import "PowerMenu"
import "Screenshot"

// https://coolors.co/1a535c-4ecdc4-f7fff7-ff6b6b-ffe66d
Scope {
    id: root
    Bar {}
    PowerMenu {}
    ScreenshotOverlay {}
}
