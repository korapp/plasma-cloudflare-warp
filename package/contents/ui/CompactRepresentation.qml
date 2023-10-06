import QtQuick 2.0

Icon {
    source: plasmoid.icon
    active: mouseArea.containsMouse
    opacity: client.isConnected ? 1 : 0.5

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
