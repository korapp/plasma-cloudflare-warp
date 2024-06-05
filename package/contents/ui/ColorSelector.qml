import QtQuick 2.0
import QtQuick.Controls 2.0

import org.kde.kirigami 2.3 as Kirigami

Item {
    id: control
    property alias colors: repeater.model
    property var value
    implicitHeight: colorsRow.height
    
    ButtonGroup {
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