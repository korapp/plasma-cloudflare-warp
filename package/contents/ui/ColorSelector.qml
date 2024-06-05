import QtQuick
import QtQuick.Controls

import org.kde.kirigami as Kirigami

Item {
    id: control
    property alias colors: repeater.model
    property var value
    implicitHeight: colorsRow.height
    
    ButtonGroup {
        id: group
        buttons: colorsRow.children
        onCheckedButtonChanged: value = checkedButton.value
    }

    Row {
        id: colorsRow
        spacing: Kirigami.Units.largeSpacing

        Repeater {
            id: repeater
            ColorRadioButton {
                color: modelData.color
                value: modelData.value
                Component.onCompleted: checked = value === control.value
            }
        }
    }
}