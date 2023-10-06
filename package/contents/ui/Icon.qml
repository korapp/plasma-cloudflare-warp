import QtQuick 2.0
import Qt5Compat.GraphicalEffects 1.0

import org.kde.kirigami 2.3 as Kirigami

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