pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "core"
import "services"

Item {
    id: root
    property var sink: Audio.sink
    property var sinks: Audio.sinks

    Rectangle {
        anchors.fill: parent
        radius: Theme.radius
        color: Theme.background
    }

    ColumnLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: Theme.padding2

        // Volume slider
        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            VolumeIcon {
                Layout.preferredWidth: 28
                fontFamily: Theme.fontFamily
                fontSize: 24
                color: Theme.primary
            }

            Slider {
                id: slider
                property int currentVolume: root.sink?.audio.volume * 100 ?? 0
                Layout.fillWidth: true
                Layout.fillHeight: true
                from: 0.0
                to: 100.0
                value: currentVolume
                stepSize: 1.0

                Binding {
                    when: !slider.pressed
                    slider.value: slider.currentVolume
                }

                Connections {
                    target: root.sink?.audio ?? null
                    function onVolumeChanged() {
                        if (!slider.pressed)
                            slider.currentVolume = root.sink.audio.volume * 100;
                    }
                }

                readonly property real snapPoint: 100.0
                readonly property real snapThreshold: 4.0
                readonly property real snapPosition: snapPoint / to

                onMoved: {
                    if (!root.sink?.audio)
                        return;

                    let snapped = (Math.abs(value - snapPoint) <= snapThreshold) ? snapPoint : value;

                    if (snapped !== value)
                        value = snapped;

                    currentVolume = value;
                    root.sink.audio.volume = value / 100;
                }

                background: Rectangle {
                    id: sliderBg
                    x: slider.leftPadding
                    y: slider.topPadding + slider.availableHeight / 2 - height / 2
                    implicitWidth: 280
                    implicitHeight: 28
                    width: slider.availableWidth
                    height: implicitHeight

                    radius: Math.min(width, height) / 2
                    color: Theme.primarySubtle

                    Rectangle {
                        id: fill
                        color: Theme.primary
                        width: Math.max(slider.handle.x - slider.leftPadding + radius * 2, radius * 2)
                        height: parent.height
                        radius: Math.min(sliderBg.width, sliderBg.height) / 2
                    }

                    Rectangle {
                        id: snapPointMarker
                        visible: slider.to > 100
                        readonly property int size: 8
                        x: (slider.snapPosition * parent.width) - width / 2
                        y: parent.height / 2 - height / 2
                        width: size
                        height: size
                        radius: size / 2
                        color: Theme.background
                        opacity: 0.6
                        z: 1  // above fill
                    }
                }

                handle: Rectangle {
                    x: slider.leftPadding + Math.max(width / 2, Math.min(slider.visualPosition * slider.availableWidth, slider.availableWidth - width / 2)) - width / 2
                    y: slider.topPadding + slider.availableHeight / 2 - height / 2
                    width: sliderBg.height
                    height: sliderBg.height
                    radius: Math.min(width, height) / 2
                    color: "transparent"
                }
            }
        }
        // Sink selection combobox
        ComboBox {
            id: sinkComboBox
            model: root.sinks
            displayText: currentValue ? currentValue.description : ""
            Layout.fillWidth: true
            valueRole: "modelData"

            onActivated: {
                Audio.setPreferredAudioSinkByName(currentValue.name);
            }

            function syncSelection() {
                const idx = root.sinks.findIndex(s => s.name === Audio.sink?.name);
                if (idx !== -1)
                    currentIndex = idx;
            }
            onModelChanged: syncSelection()

            Connections {
                target: Audio
                function onSinkChanged() {
                    sinkComboBox.syncSelection();
                }
            }

            background: Rectangle {
                id: comboboxBg
                implicitWidth: 280
                implicitHeight: 28
                width: implicitWidth
                height: implicitHeight
                radius: Math.min(width, height) / 2
                color: Theme.primarySubtle
                clip: true
            }

            indicator: Text {
                text: ""
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: width
                color: Theme.primary
                font.pixelSize: 16
            }

            contentItem: Item {
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                width: comboboxBg.width

                clip: true
                Text {
                    width: comboboxBg.implicitWidth
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: Theme.padding1
                    rightPadding: Theme.padding1 + sinkComboBox.indicator.width
                    text: sinkComboBox.displayText
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                    color: Theme.primary
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
            }

            popup: Popup {
                y: sinkComboBox.height + 4
                width: sinkComboBox.width
                padding: 0

                background: Rectangle {
                    radius: Theme.radius
                    color: Theme.background
                    Rectangle {
                        anchors.fill: parent
                        color: Theme.primarySubtle
                        radius: Theme.radius
                    }
                }

                contentItem: ListView {
                    implicitHeight: contentHeight
                    model: sinkComboBox.popup.visible ? sinkComboBox.delegateModel : null
                    clip: true
                }
            }

            delegate: ItemDelegate {
                id: delegateItem
                required property var modelData
                required property int index
                text: modelData.description
                width: sinkComboBox.width
                highlighted: sinkComboBox.highlightedIndex === index

                background: Rectangle {
                    radius: Theme.radius
                    color: delegateItem.highlighted ? Theme.primarySubtle : "transparent"
                }

                contentItem: Text {
                    text: delegateItem.text
                    color: Theme.primary
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                    leftPadding: Theme.padding2
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
            }
        }
    }
}
