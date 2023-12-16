import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.notification

PlasmoidItem {
    id: root
    compactRepresentation: CompactRepresentation {}
    fullRepresentation: FullRepresentation {}
    toolTipSubText: {
        if (plasmoid.configuration.toggleConnectionOnMiddleButton) {
            const hint = client.isConnected ? i18n("Middle-click to disconnect") : i18n("Middle-click to connect")
            return client.status + "\n" + hint
        }
        return client.status
    }
    switchWidth: Kirigami.Units.gridUnit * 24
    switchHeight: Kirigami.Units.gridUnit * 24
    Plasmoid.busy: client.isBusy
    Plasmoid.status: client.isServiceRunning && (client.isConnected || !plasmoid.configuration.hideWhenDisconnected)
        ? PlasmaCore.Types.ActiveStatus
        : PlasmaCore.Types.PassiveStatus
    Plasmoid.contextualActions: [
        mapAction(actionDisconnect, client.isConnected),
        mapAction(actionConnect, !client.isConnected)
    ]

    Warp {
        id: client
        watchStats: root.expanded
        Component.onCompleted: disableDefaultApp()
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

    Component {
        id: actionComponent
        PlasmaCore.Action {}
    }

    Connections {
        target: client
        enabled: plasmoid.configuration.showNotifications
        function onStatusChanged() {
            createNotification(client.status)
        }
    }

    function mapAction(action, visible) {
        const ca = actionComponent.createObject(root, {
            text: action.text,
            'icon.name': action.icon.name,
            visible
        })
        ca.onTriggered.connect(action.onTriggered)
        return ca
    }

    Component {
        id: notifications
        Notification {
            componentName: "plasma_workspace"
            eventId: "notification"
            title: plasmoid.title
            iconName: plasmoid.icon
            autoDelete: true
        }
    }

    function createNotification(text) {        
        notifications.createObject(parent, { text })?.sendEvent()
    }

    function nmI18n(...args) {
        return i18nd("plasma_applet_org.kde.plasma.networkmanagement", ...args)
    }
}