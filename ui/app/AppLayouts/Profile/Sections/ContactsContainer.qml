import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import "../../../../imports"
import "../../../../shared"
import "../../Chat/components"
import "./Contacts"

Item {
    id: contactsContainer
    Layout.fillHeight: true
    property alias searchStr: searchBox.text

    SearchBox {
        id: searchBox
        anchors.top: parent.top
        anchors.topMargin: 32
        fontPixelSize: 15
    }

    Item {
        id: addNewContact
        anchors.top: searchBox.bottom
        anchors.topMargin: Style.current.bigPadding
        width: addButton.width + usernameText.width + Style.current.padding
        height: addButton.height

        AddButton {
            id: addButton
            clickable: false
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: 40
        }

        StyledText {
            id: usernameText
            text: qsTr("Add new contact")
            color: Style.current.blue
            anchors.left: addButton.right
            anchors.leftMargin: Style.current.padding
            anchors.verticalCenter: addButton.verticalCenter
            font.pixelSize: 15
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                addContactModal.open()
            }
        }
    }

    Item {
        id: blockedContactsButton
        anchors.top: addNewContact.bottom
        anchors.topMargin: Style.current.bigPadding
        width: blockButton.width + blockButtonLabel.width + Style.current.padding
        height: addButton.height

        IconButton {
            id: blockButton
            clickable: false
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: 40
            iconName: "block-icon"
            color: Style.current.lightBlue
        }

        StyledText {
            id: blockButtonLabel
            text: qsTr("Blocked contacts")
            color: Style.current.blue
            anchors.left: blockButton.right
            anchors.leftMargin: Style.current.padding
            anchors.verticalCenter: blockButton.verticalCenter
            font.pixelSize: 15
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                blockedContactsModal.open()
            }
        }
    }

    ModalPopup {
        id: blockedContactsModal
        title: qsTr("Blocked contacts")

        ContactList {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            contacts: profileModel.blockedContacts
            selectable: false
        }
    }

    ModalPopup {
        id: addContactModal
        title: qsTr("Add contact")

        Input {
            id: addContactSearchInput
            placeholderText: qsTrId("Enter ENS username or chat key")
            customHeight: 44
            fontPixelSize: 15
            onEditingFinished: {
              profileModel.lookupContact(inputValue)
            }
        }

        Item {
          id: contactToAddInfo
          anchors.top: addContactSearchInput.bottom
          anchors.topMargin: Style.current.padding
          anchors.horizontalCenter: parent.horizontalCenter
          height: contactUsername.height
          width: contactUsername.width + contactPubKey.width
          visible: profileModel.contactToAddPubKey !== ""

          StyledText {
              id: contactUsername
              text: profileModel.contactToAddUsername + " • "
              anchors.top: addContactSearchInput.bottom
              anchors.topMargin: Style.current.padding
              font.pixelSize: 12
              color: Style.current.darkGrey
          }

          StyledText {
              id: contactPubKey
              text: profileModel.contactToAddPubKey
              anchors.left: contactUsername.right
              width: 100
              font.pixelSize: 12
              elide: Text.ElideMiddle
              color: Style.current.darkGrey
          }

        }
        footer: StyledButton {
            anchors.right: parent.right
            anchors.leftMargin: Style.current.padding
            //% "Send Message"
            label: qsTr("Add contact")
            disabled: !contactToAddInfo.visible
            anchors.bottom: parent.bottom
            onClicked: {
                profileModel.addContact(profileModel.contactToAddPubKey);
                addContactModal.close()
            }
        }
    }

    ContactList {
        id: contactListView
        anchors.top: blockedContactsButton.bottom
        anchors.topMargin: Style.current.bigPadding
        anchors.bottom: parent.bottom
        contacts: profileModel.addedContacts
        selectable: false
        searchString: searchBox.text
    }

    Item {
        id: element
        visible: profileModel.contactList.rowCount() === 0
        anchors.fill: parent

        StyledText {
            id: noFriendsText
            text: qsTr("You don’t have any contacts yet")
            anchors.verticalCenterOffset: -Style.current.bigPadding
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            color: Style.current.darkGrey
        }

        StyledButton {
            anchors.horizontalCenter: noFriendsText.horizontalCenter
            anchors.top: noFriendsText.bottom
            anchors.topMargin: Style.current.bigPadding
            label: qsTr("Invite firends")
            onClicked: function () {
                inviteFriendsPopup.open()
            }
        }

        InviteFriendsPopup {
            id: inviteFriendsPopup
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#ffffff";formeditorZoom:0.6600000262260437;height:480;width:600}
}
##^##*/
