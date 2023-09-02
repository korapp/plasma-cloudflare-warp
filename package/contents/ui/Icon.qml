import QtQuick 2.0
import QtGraphicalEffects 1.0

import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    property alias source: icon.source
    property alias active: icon.active

    PlasmaCore.IconItem {
        id: icon
        anchors.fill: parent
    }
    
    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: PlasmaCore.Theme.textColor
    }
}