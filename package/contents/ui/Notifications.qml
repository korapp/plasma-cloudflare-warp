import QtQuick 2.0

import org.kde.plasma.core 2.0 as PlasmaCore

PlasmaCore.DataSource {
    id: notificationSource
    engine: "notifications"
    connectedSources: "org.freedesktop.Notifications"

    function createNotification(text, { appName = plasmoid.title, appIcon = plasmoid.icon } = {}) {        
        const service = notificationSource.serviceForSource("notification");
        const operation = service.operationDescription("createNotification");

        operation.appName = appName
        operation.appIcon = appIcon
        operation.body = text
        operation.expireTimeout = 5000

        service.startOperationCall(operation);
    }
}