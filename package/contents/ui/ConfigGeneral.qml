import QtQuick
import QtQuick.Controls

import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    property alias cfg_toggleConnectionOnMiddleButton: toggleConnectionOnMiddleButton.checked
    property alias cfg_hideWhenDisconnected: hideWhenDisconnected.checked
    property alias cfg_showNotifications: showNotifications.checked

    CheckBox {
        id: toggleConnectionOnMiddleButton
        Kirigami.FormData.label: i18n("Toggle connection on middle mouse button")
    }

    CheckBox {
        id: hideWhenDisconnected
        Kirigami.FormData.label: i18n("Hide icon when disconnected")
    }

    CheckBox {
        id: showNotifications
        Kirigami.FormData.label: i18n("Show notifications")
    }
}