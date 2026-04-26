pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

import "../core"

Singleton {
    id: root
    readonly property PwNode sink: Pipewire.preferredDefaultAudioSink ?? Pipewire.defaultAudioSink
    readonly property var sinks: {
        let x = Pipewire.nodes.values.length;
        return Pipewire.nodes.values.filter(n => n.isSink && n.audio !== null && !n.isStream);
    }
    property bool muted: false

    function toggleMute() {
        muted = !muted;

        if (root.sink?.audio)
            root.sink.audio.muted = !root.sink.audio.muted;
    }

    onSinkChanged: {
        if (Pipewire.preferredDefaultAudioSink === null) {
            Pipewire.preferredDefaultAudioSink = Pipewire.defaultAudioSink;
        }
    }

    Connections {
        target: Pipewire
        function onReadyChanged() {
            if (Pipewire.ready)
                root.applyPreferredSink();
        }
    }

    // First time setup
    function applyPreferredSink() {
        const name = Settings.preferredAudioSinkName;
        if (!name) {
            setPreferredAudioSink(Pipewire.defaultAudioSink);
            return;
        }

        const matchedAudioSink = root.sinks.find(s => s.name === name);
        if (!matchedAudioSink) {
            setPreferredAudioSink(Pipewire.defaultAudioSink);
            return;
        }
        Pipewire.preferredDefaultAudioSink = matchedAudioSink;
    }

    function setPreferredAudioSink(sink: PwNode) {
        if (!sink) {
            console.error("Could not set preferredAudioSink. Provided sink maybe null");
            return;
        }
        Pipewire.preferredDefaultAudioSink = sink;
        Settings.preferredAudioSinkName = sink.name;
    }

    function setPreferredAudioSinkByName(name: string) {
        if (!name) {
            console.error("Invalid name provided for preferredAudioSink");
            return;
        }

        const matchedAudioSink = root.sinks.find(s => s.name === name);

        if (!matchedAudioSink) {
            console.error(`No audio sink found by name ${name}`);
            return;
        }
        setPreferredAudioSink(matchedAudioSink);
    }

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }
}
