import QtQuick 2.0
import QtQuick.Controls 2.0

RadioButton {
    id: control
    property color color
    property string value
    ToolTip.text: value
    ToolTip.visible: !text && hovered

    indicator: Rectangle {
        implicitWidth: 20
        implicitHeight: 20
        radius: width / 2
        color: control.checked ? "transparent" : control.color
        border.color: control.color
        border.width: width / 4
    }
}