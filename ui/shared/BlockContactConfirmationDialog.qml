import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import "../imports"
import "./"

ModalPopup {
    id: blockContactConfirmationDialog
    height: 237
    width: 400
    property string contactAddress: ""
    property string contactName: ""
    signal blockButtonClicked()
    title: qsTrId("block-user")

    Text {
        text: qsTr("Blocking will remove any messages you received from " + blockContactConfirmationDialog.contactName + " and stop new messages from reaching you.")
        font.pixelSize: 15
        anchors.left: parent.left
        anchors.right: parent.right
        wrapMode: Text.WordWrap
    }
    

    footer: Item {
        id: footerContainer
        width: parent.width
        height: children[0].height

        StyledButton {
            anchors.right: parent.right
            anchors.rightMargin: Style.current.smallPadding
            btnColor: Style.current.lightRed
            btnBorderWidth: 1
            btnBorderColor: Style.current.grey
            textColor: Style.current.red
            //% "Block User"
            label: qsTrId("block-user")
            anchors.bottom: parent.bottom
            onClicked: blockContactConfirmationDialog.blockButtonClicked()
        }
    }
}

