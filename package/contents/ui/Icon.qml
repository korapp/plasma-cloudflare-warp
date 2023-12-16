import QtQuick
import Qt5Compat.GraphicalEffects

import org.kde.kirigami as Kirigami

Item {
    property alias source: icon.source
    property alias active: icon.active

    Kirigami.Icon {
        id: icon
        anchors.fill: parent
    }
    
    ColorOverlay {
        anchors.fill: icon
        source: icon
        color: Kirigami.Theme.textColor
    }
}