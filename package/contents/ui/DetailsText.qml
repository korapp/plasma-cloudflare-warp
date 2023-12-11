import QtQuick

import org.kde.plasma.components as PlasmaComponents3

import org.kde.kirigami as Kirigami

Column {
    property alias model: repeater.model

    Repeater {
        id: repeater
        property int contentHeight: 0
        property int longestString: 0

        Item {
            anchors {
                left: parent.left
                right: parent.right
            }
            height: Math.max(detailNameLabel.height, detailValueLabel.height)

            PlasmaComponents3.Label {
                id: detailNameLabel

                anchors {
                    left: parent.left
                    leftMargin: repeater.longestString - paintedWidth + Math.round(Kirigami.Units.gridUnit / 2)
                }

                horizontalAlignment: Text.AlignRight
                text: modelData[0] + ": "
                opacity: 0.6

                Component.onCompleted: {
                    if (paintedWidth > repeater.longestString) {
                        repeater.longestString = paintedWidth
                    }
                }
            }

            PlasmaComponents3.Label {
                id: detailValueLabel

                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: repeater.longestString + Math.round(Kirigami.Units.gridUnit / 2)
                }
                
                elide: Text.ElideRight
                text: modelData[1]
                textFormat: Text.PlainText
            }
        }
    }
}