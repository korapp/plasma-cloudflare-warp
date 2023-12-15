import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.3

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root
    Plasmoid.compactRepresentation: CompactRepresentation {}
    Plasmoid.fullRepresentation: FullRepresentation {}
    Plasmoid.toolTipSubText: {
        if (plasmoid.configuration.toggleConnectionOnMiddleButton) {
            const hint = client.isConnected ? i18n("Middle-click to disconnect") : i18n("Middle-click to connect")
            return client.status + "\n" + hint
        }
        return client.status
    }
    Plasmoid.busy: client.isBusy
    Plasmoid.status: client.isServiceRunning && (client.isConnected || !plasmoid.configuration.hideWhenDisconnected)
        ? PlasmaCore.Types.ActiveStatus
        : PlasmaCore.Types.PassiveStatus
    
    Plasmoid.switchWidth: PlasmaCore.Units.gridUnit * 24
    Plasmoid.switchHeight: PlasmaCore.Units.gridUnit * 24

    Warp {
        id: client
        watchStats: plasmoid.expanded
        onIsConnectedChanged: prepareContextualActions()
        
        Component.onCompleted: {
            disableDefaultApp()
            prepareContextualActions()
        }
    }

    Action {
        id: actionConnect
        text: nmI18n("Connect")
        icon.name: "network-connect"
        onTriggered: client.connect()
    }

    Action {
        id: actionDisconnect
        text: nmI18n("Disconnect")
        icon.name: "network-disconnect"
        onTriggered: client.disconnect()
    }

    function actionToContextual(action) {
        return [action.text.toLowerCase(), action.text, action.icon.name]
    }

    Loader {
        id: nLoader
        active: plasmoid.configuration.showNotifications
        source: "Notifications.qml"
    }

    Connections {
        target: client
        enabled: nLoader.status === Loader.Ready
        onStatusChanged: nLoader.item.createNotification(client.status)
    }

    function prepareContextualActions() {
        plasmoid.clearActions()
        plasmoid.setAction(...actionToContextual(client.isConnected ? actionDisconnect : actionConnect))
    }

    function action_disconnect() {
        client.disconnect()
    }

    function action_connect() {
        client.connect()
    }

    function nmI18n(...args) {
        return i18nd("plasma_applet_org.kde.plasma.networkmanagement", ...args)
    }
}