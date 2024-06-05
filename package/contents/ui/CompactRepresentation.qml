import QtQuick

import org.kde.kirigami as Kirigami

Kirigami.Icon {
    readonly property color connectedColor: Kirigami.Theme[plasmoid.configuration.iconColorConnected]
    readonly property color disconnectedColor: Kirigami.Theme[plasmoid.configuration.iconColorDisconnected]
    source: plasmoid.icon
    active: mouseArea.containsMouse
    color: client.isConnected ? connectedColor : disconnectedColor
    opacity: !client.isConnected && connectedColor === disconnectedColor ? 0.5 : 1
    isMask: true

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        anchors.fill: parent
        
        onClicked: function (mouse) {
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
        root.expanded = !root.expanded
    }
}
