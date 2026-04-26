pragma Singleton

import QtQuick

QtObject {
    // Surfaces
    property color background: MyPalette.mint50
    property color surfaceSubtle: Qt.rgba(0.10, 0.33, 0.36, 0.13)  // teal @ 8% — barely-there tint

    // Primary
    property color primary: MyPalette.teal900
    property color primaryHover: Qt.alpha(MyPalette.teal900, 0.67)  // ~AA alpha
    property color primarySubtle: Qt.alpha(MyPalette.teal900, 0.27)  // ~44 alpha
    property color primaryGhost: Qt.alpha(MyPalette.teal900, 0.13)  // ~22 alpha

    // Interactive states (for buttons, tabs, items)
    property color itemActive: MyPalette.teal900              // fully opaque
    property color itemActiveHover: Qt.alpha(MyPalette.teal900, 0.80)
    property color itemOccupied: Qt.alpha(MyPalette.teal900, 0.67)  // hasWindows
    property color itemOccupiedHover: Qt.alpha(MyPalette.teal900, 1.0)
    property color itemInactive: Qt.alpha(MyPalette.teal900, 0.27)
    property color itemInactiveHover: Qt.alpha(MyPalette.teal900, 0.13)  // barely visible

    // Semantic / Status
    property color secondary: MyPalette.cyan400
    property color danger: MyPalette.red400
    property color warn: MyPalette.yellow300

    // Typography Colors
    property color textPrimary: MyPalette.teal900
    property color textMuted: Qt.alpha(MyPalette.teal900, 0.50)

    // Geometry
    property int radius: 16
    property int padding1: 8
    property int padding2: 16
    property int spacing1: 4
    property int spacing2: 6

    // Typography
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 14
}
