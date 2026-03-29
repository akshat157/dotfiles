pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "services"
import "core"

Item {
    id: root
    required property bool shown
    Rectangle {
        anchors.fill: parent
        radius: Theme.radius
        color: Theme.background

        scale: root.shown ? 1 : 0.90
        opacity: root.shown ? 1 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuad
            }
        }

        ColumnLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: {
                right: Theme.padding2;
            }

            Text {
                color: Theme.primary
                text: DateTime.timeStr
                font.pixelSize: 32
                font.bold: true
                font.family: Theme.fontFamily
                Layout.alignment: Qt.AlignRight
            }

            Text {
                color: Theme.primary
                text: DateTime.dateStr
                font.pixelSize: 16
                font.family: Theme.fontFamily
                Layout.alignment: Qt.AlignRight
            }

            ColumnLayout {
                DayOfWeekRow {
                    Layout.fillWidth: true
                }

                MonthGrid {
                    id: grid

                    property int currentDate: DateTime.day
                    property int currentMonth: DateTime.month
                    property int currentYear: DateTime.year

                    property int selectedDay: currentDate
                    property int selectedMonth: currentMonth
                    property int selectedYear: currentYear

                    month: currentMonth
                    year: currentYear
                    Layout.fillWidth: true

                    delegate: Rectangle {
                        required property var model
                        property int size: 28
                        width: size
                        height: size
                        radius: size / 2

                        property bool isToday: model.day === grid.currentDate && model.month === grid.currentMonth && model.year === grid.currentYear
                        property bool isSelectedDay: model.day === grid.selectedDay && model.month === grid.selectedMonth && model.year === grid.selectedYear
                        property bool isOfThisMonth: model.month === grid.currentMonth

                        color: isToday ? Theme.primary : "transparent"

                        border.color: isSelectedDay ? Theme.itemOccupied : "transparent"
                        border.width: isSelectedDay ? 2 : 0

                        Text {
                            anchors.centerIn: parent
                            text: parent.model.day

                            color: isToday ? Theme.background : parent.isOfThisMonth ? Theme.primary : Theme.itemInactive
                            font.family: Theme.fontFamily
                            font.bold: parent.isToday
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                grid.selectedDay = parent.model.day;
                                grid.selectedMonth = parent.model.month;
                                grid.selectedYear = parent.model.year;
                            }
                        }
                    }
                }
            }
        }
    }
}
