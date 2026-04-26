pragma Singleton

import Quickshell
import QtQuick

import "../core"

Singleton {
    readonly property int day: clock.date.getDate()
    readonly property int month: clock.date.getMonth()
    readonly property int year: clock.date.getFullYear()

    readonly property int hours: clock.date.getHours()
    readonly property int minutes: clock.date.getMinutes()
    readonly property int seconds: clock.date.getSeconds()

    readonly property string clockStr: {
        Qt.formatDateTime(clock.date, Formats.timeFormat(Settings.use24h, false));
    }

    readonly property string secondsClockStr: {
        Qt.formatDateTime(secondsClock.date, Formats.timeFormat(Settings.use24h, true));
    }

    readonly property string dateStr: {
        Qt.formatDateTime(clock.date, Formats.dateShort);
    }

    SystemClock {
        id: clock
        precision: Settings.showSeconds ? SystemClock.Seconds : SystemClock.Minutes
    }

    SystemClock {
        id: secondsClock
        precision: SystemClock.Seconds
    }
}
