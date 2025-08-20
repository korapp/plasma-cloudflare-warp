import QtQuick

import org.kde.plasma.plasma5support as P5Support

Item {
    property bool watchStats: false
    
    readonly property alias status: p.status
    readonly property alias stats: p.stats
    readonly property alias errorMessage: p.errorMessage
    readonly property alias isConnected: p.isConnected
    readonly property alias isServiceRunning: p.isServiceRunning

    readonly property var connect: p.connect
    readonly property var disconnect: p.disconnect
    readonly property var disableDefaultApp: p.disableDefaultApp
    readonly property bool isBusy: p.isConnecting || p.isOperationInProgress

    P5Support.DataSource {
        id: watcher
        readonly property string cmdStatus: "warp-cli status"
        readonly property string cmdStats: "warp-cli tunnel stats"
        readonly property var handlers: ({
            [cmdStatus]: p.updateStatus,
            [cmdStats]: p.updateStats
        })
        engine: "executable"
        connectedSources: [cmdStatus]
        interval: p.isServiceRunning ? 1000 : 5000
        onNewData: (sourceName, data) => handlers[sourceName](data)
    }

    P5Support.DataSource {
        id: exec
        engine: "executable"
        onNewData: disconnectSource
        readonly property var run: connectSource
    }

    QtObject {
        id: p
        property var stats
        property string status: ""
        property string errorMessage: ""
        property bool isServiceRunning: false
        property bool isOperationInProgress: false
        readonly property bool isConnected: status === "Connected"
        readonly property bool isConnecting: status === "Connecting"
        readonly property var propertiesSplitRegex: new RegExp("\n|; ?")
        readonly property bool watchStatsFlag: watchStats && isConnected

        function connect() {
            isOperationInProgress = true
            exec.run("warp-cli connect")
        }

        function disconnect() {
            isOperationInProgress = true
            exec.run("warp-cli disconnect")
        }

        function disableDefaultApp() {
            exec.run("systemctl --user stop warp-taskbar")
        }

        function parseStdoutProperties(text) {
            if (!text) return []
            const lines = text.split(propertiesSplitRegex)
            return lines.reduce((acc, l) => {
                const idx = l ? l.indexOf(": ") : -1
                if (~idx) {
                    acc.push([l.substring(0, idx), l.substring(idx+2)])
                }
                return acc
            }, [])
        }
        
        function updateStatus(data) {
            const isRunning = !data["exit code"]
            if (!isRunning) {
                errorMessage = data.stderr
                status = ""
            } else {
                const newStatus = parseStdoutProperties(data.stdout).map(l => l[1]).join("\n")
                errorMessage = ""
                if (status != newStatus) {
                    status = newStatus
                    isOperationInProgress = false
                }
            }
            isServiceRunning = isRunning           
        }

        function updateStats(data) {
            if (isConnected) {
                stats = parseStdoutProperties(data.stdout)
            }
        }

        onWatchStatsFlagChanged: {
            if (watchStatsFlag) {
                watcher.connectSource(watcher.cmdStats)
            } else {
                watcher.disconnectSource(watcher.cmdStats)
                stats = null
            }
        }
    }
}
