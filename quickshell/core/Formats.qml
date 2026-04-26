pragma Singleton

import QtQuick

QtObject {
    function timeFormat(use24h: bool, showSeconds: bool): string {
        if (use24h) {
            return showSeconds ? "HH:mm:ss" : "HH:mm";
        } else {
            return showSeconds ? "hh:mm:ss AP" : "hh:mm AP";
        }
    }
    readonly property string dateShort: "ddd, MMM d"
    readonly property string dateLong: "dddd, MMMM d yyyy"
}
