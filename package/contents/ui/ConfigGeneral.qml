import QtQuick 2.0
import QtQuick.Controls 2.0

import org.kde.kirigami 2.3 as Kirigami

Kirigami.FormLayout {
    property alias cfg_toggleConnectionOnMiddleButton: toggleConnectionOnMiddleButton.checked
    property alias cfg_hideWhenDisconnected: hideWhenDisconnected.checked
    property alias cfg_showNotifications: showNotifications.checked
    property alias cfg_iconColorConnected: connectedColorSelector.value
    property alias cfg_iconColorDisconnected: disconnectedColorSelector.value

    readonly property var colorsConnected: ["textColor","highlightColor","positiveTextColor","neutralTextColor"]
    readonly property var colorsDisconnected: ["textColor","negativeTextColor"]

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

    ColorSelector {
        id: connectedColorSelector
        Kirigami.FormData.label: i18n("Icon color when connected")
        colors: colorsConnected.map(c => ({
            color: Kirigami.Theme[c],
            value: c
        }))
    }

    ColorSelector {
        id: disconnectedColorSelector
        Kirigami.FormData.label: i18n("Icon color when disconnected")
        colors: colorsDisconnected.map(c => ({
            color: Kirigami.Theme[c],
            value: c
        }))
    }
}