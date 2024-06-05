import QtQuick
import QtQuick.Controls

import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_toggleConnectionOnMiddleButton: toggleConnectionOnMiddleButton.checked
    property alias cfg_hideWhenDisconnected: hideWhenDisconnected.checked
    property alias cfg_showNotifications: showNotifications.checked
    property alias cfg_iconColorConnected: connectedColorSelector.value
    property alias cfg_iconColorDisconnected: disconnectedColorSelector.value

    readonly property var availableConnectedColors: ["textColor","highlightColor","positiveTextColor","neutralTextColor"]
    readonly property var availableDisconnectedColors: ["textColor","negativeTextColor"]

    Kirigami.FormLayout {
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
            colors: availableConnectedColors.map(c => ({
                color: Kirigami.Theme[c],
                value: c
            }))
        }

        ColorSelector {
            id: disconnectedColorSelector
            Kirigami.FormData.label: i18n("Icon color when disconnected")
            colors: availableDisconnectedColors.map(c => ({
                color: Kirigami.Theme[c],
                value: c
            }))
        }
    }
}