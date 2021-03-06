import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import "../../../../../imports"
import "../../../../../shared"

ModalPopup {
    id: popup

    title: qsTr("Primary username")

    property string newUsername: ""

    onOpened: {
        for(var i in ensNames.contentItem.children){
            ensNames.contentItem.children[i].checked = ensNames.contentItem.children[i].text === profileModel.ens.preferredUsername
        }
    }

    StyledText {
        id: lbl1
        text: qsTr("Your messages are displayed to others with this username:")
        font.pixelSize: 15
    }

    StyledText {
        id: lbl2
        anchors.top: lbl1.bottom
        anchors.topMargin: Style.current.padding
        text: profileModel.ens.preferredUsername
        font.pixelSize: 17
        font.weight: Font.Bold
    }
    
    ScrollView {
        anchors.fill: parent
        anchors.top: lbl2.bottom
        anchors.topMargin: 70
        Layout.fillWidth: true
        Layout.fillHeight: true

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ensNames.contentHeight > ensNames.height ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff

        ListView {
            anchors.fill: parent
            model: profileModel.ens
            spacing: 0
            clip: true
            id: ensNames
            delegate: RadioDelegate {
                id: radioDelegate
                text: username
                checked: profileModel.ens.preferredUsername === username
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        parent.checked = true
                        newUsername = username;
                    }
                }
            }
        }
    }

    onNewUsernameChanged: {
        btnSelectPreferred.state = newUsername === profileModel.ens.preferredUsername ? "inactive" : "active"
    }
    
    footer: Item {
        anchors.top: parent.bottom
        anchors.right: parent.right
        anchors.bottom: popup.bottom
        anchors.left: parent.left

        Button {
            id: btnSelectPreferred
            width: 44
            height: 44
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            state: "inactive"
            states: [
                State {
                    name: "inactive"
                    PropertyChanges {
                        target: btnContinue
                        source: "../../../../img/arrow-right-btn-inactive.svg"
                    }
                },
                State {
                    name: "active"
                    PropertyChanges {
                        target: btnContinue
                        source: "../../../../img/arrow-right-btn-active.svg"
                    }
                }
            ]

            SVGImage {
                id: btnContinue
                width: 50
                height: 50
            }
            background: Rectangle {
                color: "transparent"
            }
            MouseArea {
                cursorShape: btnSelectPreferred.state === "active" ? Qt.PointingHandCursor : Qt.ArrowCursor
                anchors.fill: parent
                onClicked : {
                    if(btnSelectPreferred.state === "active"){
                        profileModel.ens.preferredUsername = newUsername;
                        newUsername = ""; 
                        popup.close();  
                    }
                }
            }
        }
    }
}

