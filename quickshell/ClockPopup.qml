pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "core"
import "services"

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        radius: Theme.radius
        color: Theme.background

        ColumnLayout {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: {
                right: Theme.padding2;
            }
            Rectangle {
                implicitWidth: timeAndDate.width + Theme.padding2
                implicitHeight: timeAndDate.height + Theme.padding2
                color: Theme.primaryGhost
                radius: Theme.radius
                Layout.alignment: Qt.AlignLeft
                ColumnLayout {
                    id: timeAndDate
                    anchors.centerIn: parent
                    Text {
                        color: Theme.primary
                        text: DateTime.secondsClockStr
                        font.pixelSize: 32
                        font.bold: true
                        font.family: Theme.fontFamily
                        Layout.alignment: Qt.AlignLeft
                    }

                    Text {
                        color: Theme.primary
                        text: DateTime.dateStr
                        font.pixelSize: 16
                        font.family: Theme.fontFamily
                        Layout.alignment: Qt.AlignLeft
                    }
                }
            }
            Rectangle {
                implicitWidth: calender.width + Theme.padding2
                implicitHeight: calender.height + Theme.padding1
                color: Theme.primaryGhost
                radius: Theme.radius
                Layout.alignment: Qt.AlignLeft
                ColumnLayout {
                    id: calender
                    anchors.centerIn: parent
                    RowLayout {
                        spacing: Theme.spacing2
                        Layout.alignment: Qt.AlignHCenter

                        Button {
                            id: monthBtn
                            implicitHeight: parent.height
                            Layout.fillWidth: true
                            background: Rectangle {
                                color: monthBtn.pressed ? Theme.primarySubtle : monthBtn.hovered ? Theme.primarySubtle : Theme.primaryGhost
                                radius: Theme.radius
                            }

                            Text {
                                anchors.centerIn: parent
                                color: Theme.primary
                                text: grid.currentMonth + " " + DateTime.year
                                font.pixelSize: 12
                                font.family: Theme.fontFamily
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Button {
                            id: btn
                            background: Rectangle {
                                implicitWidth: 32
                                color: btn.pressed ? Theme.primarySubtle : btn.hovered ? Theme.primarySubtle : Theme.primaryGhost
                                radius: Theme.radius
                            }

                            contentItem: Text {
                                color: Theme.primary
                                text: ""
                                font.pixelSize: 16
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                            }

                            onClicked: () => {
                                grid.currentMonth = grid.currentMonth - 1;
                            }
                        }

                        Button {
                            id: btn2
                            background: Rectangle {
                                implicitWidth: 32
                                color: btn2.pressed ? Theme.primarySubtle : btn2.hovered ? Theme.primarySubtle : Theme.primaryGhost
                                radius: Theme.radius
                            }

                            contentItem: Text {
                                color: Theme.primary
                                text: ""
                                font.pixelSize: 16
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                            }

                            onClicked: () => {
                                grid.currentMonth = grid.currentMonth + 1;
                            }
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true

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

                                        color: parent.isToday ? Theme.background : parent.isOfThisMonth ? Theme.primary : Theme.itemInactive
                                        font.family: Theme.fontFamily
                                        font.bold: parent.model.today
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
        }
    }
}
