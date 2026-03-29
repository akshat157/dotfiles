pragma Singleton

import QtQuick

QtObject {
    function timeFormat(settings: Settings): string {
        if (settings.use24h) {
            return settings.showSeconds ? "HH:mm:ss" : "HH:mm";
        } else {
            return settings.showSeconds ? "hh:mm:ss AP" : "hh:mm AP";
        }
    }
    readonly property string dateShort: "ddd, MMM d"
    readonly property string dateLong: "dddd, MMMM d yyyy"
}
