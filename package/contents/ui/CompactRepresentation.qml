import QtQuick 2.0

import org.kde.plasma.core 2.0 as PlasmaCore

Icon {
    readonly property color connectedColor: PlasmaCore.Theme[plasmoid.configuration.iconColorConnected]
    readonly property color disconnectedColor: PlasmaCore.Theme[plasmoid.configuration.iconColorDisconnected]
    opacity: !client.isConnected && connectedColor === disconnectedColor ? 0.5 : 1
    source: plasmoid.icon
    active: mouseArea.containsMouse
    color: client.isConnected ? connectedColor : disconnectedColor

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        anchors.fill: parent
        
        onClicked: {
            if (plasmoid.configuration.toggleConnectionOnMiddleButton && mouse.button === Qt.MiddleButton) {
                toggleConnection()
            } else {
                toggleExpanded()
            }
        }
    }

    function toggleConnection() {
        client.isConnected ? client.disconnect() : client.connect()
    }

    function toggleExpanded() {
        plasmoid.expanded = !plasmoid.expanded
    }

    Accessible.name: plasmoid.title
    Accessible.description: plasmoid.toolTipSubText
    Accessible.role: Accessible.Button
}