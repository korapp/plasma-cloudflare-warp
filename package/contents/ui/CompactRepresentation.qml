import QtQuick 2.0

import org.kde.plasma.core 2.0 as PlasmaCore

Icon {
    source: plasmoid.icon
    active: mouseArea.containsMouse
    opacity: client.isConnected ? 1 : 0.5

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