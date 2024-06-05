import QtQuick 2.0
import QtGraphicalEffects 1.0

import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    property alias source: icon.source
    property alias active: icon.active
    property color color: PlasmaCore.Theme.textColor

    PlasmaCore.IconItem {
        id: icon
        anchors.fill: parent
        visible: false
    }
    
    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: parent.color
    }
}