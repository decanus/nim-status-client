import QtQuick 2.3
import "../../../../../shared"
import "../../../../../imports"

Rectangle {
    property int chatVerticalPadding: 12
    property int chatHorizontalPadding: 12
    property int imageWidth: 250
    property string imageSource: "data:image/jpeg;base64,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"

    id: imageChatBox
    height: imageMessage.paintedHeight
    width:  imageMessage.paintedWidth + 2 * chatHorizontalPadding
    radius: 16
    visible: isImage
    color: "transparent"

    Image {
        id: imageMessage
        source: imageSource
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: imageChatBox.chatVerticalPadding
        fillMode: Image.PreserveAspectFit
        width: sourceSize.width > imageWidth ? imageWidth : sourceSize.width
        onStatusChanged: {
            if (imageMessage.status == Image.Error) {
                imageMessage.height = 0
                imageMessage.visible = false
                imageChatBox.height = 0
                imageChatBox.visible = false
            } else if (imageMessage.status == Image.Ready) {
                messageItem.scrollToBottom(true, messageItem)
            }
        }
    }
}