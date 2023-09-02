import QtQuick 2.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.private.quicklaunch 1.0

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

    PlasmaCore.DataSource {
        id: dataSource
        readonly property string sourceStatus: "warp-cli status"
        readonly property string sourceStats: "warp-cli warp-stats"
        readonly property var handlers: ({
            [sourceStatus]: p.updateStatus,
            [sourceStats]: p.updateStats
        })
        engine: "executable"
        connectedSources: [sourceStatus]
        interval: p.isServiceRunning ? 1000 : 5000
        onNewData: handlers[sourceName](data)
    }

    Logic {
        id: kRun
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
            return kRun.openExec("warp-cli connect")
        }

        function disconnect() {
            isOperationInProgress = true
            return kRun.openExec("warp-cli disconnect")
        }

        function disableDefaultApp() {
            return kRun.openExec("systemctl --user stop warp-taskbar")
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
                errorMessage = parseStdoutProperties(data.stderr)[0][1]
                status = ""
            } else {
                const statusMessage = parseStdoutProperties(data.stdout)[0][1]
                const newStatus = statusMessage.replace(". Reason: ", "\n")
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
                dataSource.connectSource(dataSource.sourceStats)
            } else {
                dataSource.disconnectSource(dataSource.sourceStats)
                stats = null
            }
        }
    }
}
