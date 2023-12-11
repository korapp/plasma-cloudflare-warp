import QtQuick
import QtQuick.Layouts

import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.extras as PlasmaExtras
import org.kde.kirigami as Kirigami

PlasmaComponents3.Page {
    readonly property var appletInterface: plasmoid.self

    readonly property string mainText: client.status || client.errorMessage
    readonly property string icon: client.errorMessage ? "error" : plasmoid.icon

    Layout.preferredWidth: Kirigami.Units.gridUnit * 24
    Layout.preferredHeight: Kirigami.Units.gridUnit * 24

    ColumnLayout {
        spacing: Kirigami.Units.largeSpacing
        width: parent.width
        enabled: !client.isBusy
        anchors.centerIn: parent
  
        Icon {
            opacity: 0.5
            source: icon
            readonly property int size: Math.round(Kirigami.Units.iconSizes.huge * 1.5)
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: size
            Layout.preferredHeight: size
        }

        PlasmaExtras.Heading {
            text: mainText
            type: PlasmaExtras.Heading.Primary
            horizontalAlignment: Qt.AlignHCenter
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }

        DetailsText {
            id: details
            visible: client.isConnected
            model: client.stats
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 300
            Layout.maximumWidth: parent.width
        }

        PlasmaComponents3.Button {
            action: client.isConnected ? actionDisconnect : actionConnect
            visible: client.isServiceRunning
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: Kirigami.Units.gridUnit
        }
    }

    PlasmaComponents3.BusyIndicator {
        running: client.isBusy
        visible: running
        anchors.centerIn: parent
    }
}
