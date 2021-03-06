import QtQuick 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.14
import "../../../../../imports"
import "../../../../../shared"

Item {
    signal startBtnClicked()

    StyledText {
        id: sectionTitle
        //% "ENS usernames"
        text: qsTrId("ens-usernames")
        anchors.left: parent.left
        anchors.leftMargin: 24
        anchors.top: parent.top
        anchors.topMargin: 24
        font.weight: Font.Bold
        font.pixelSize: 20
    }

    ScrollView {
        id: sview
        clip: true
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        contentHeight: contentItem.childrenRect.height
        anchors.top: sectionTitle.bottom
        anchors.topMargin: Style.current.padding
        anchors.bottom: startBtn.top
        anchors.bottomMargin: Style.current.padding
        anchors.left: parent.left
        anchors.right: parent.right

        Item {
            id: contentItem
            anchors.right: parent.right;
            anchors.left: parent.left;

            Image {
                id: image
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "../../../../img/ens-header@2x.png"
            }

            StyledText {
                id: title
                text: qsTr("Get a universal username")
                anchors.top: image.bottom
                anchors.topMargin: 24
                font.weight: Font.Bold
                font.pixelSize: 24
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            StyledText {
                id: subtitle
                text: qsTr("ENS names transform those crazy-long addresses into unique usernames.")
                anchors.top: title.bottom
                anchors.topMargin: 24
                font.pixelSize: 14
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            StyledText {
                id: element1Number
                text: "1"
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.top: subtitle.bottom
                anchors.topMargin: 24
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element1Title
                text: qsTr("Customize your chat name")
                anchors.left: element1Number.right
                anchors.leftMargin: 24
                anchors.top: subtitle.bottom
                anchors.topMargin: 24
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element1Subtitle
                text: qsTr("An ENS name can replace your random 3-word name in chat. Be @yourname instead of %1.").arg(profileModel.profile.username)
                anchors.left: element1Number.right
                anchors.leftMargin: 24
                anchors.top: element1Title.bottom
                anchors.topMargin: 24
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.pixelSize: 14
            }

            StyledText {
                id: element2Number
                text: "2"
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.top: element1Subtitle.bottom
                anchors.topMargin: 24
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element2Title
                text: qsTr("Simplify your ETH address")
                anchors.left: element2Number.right
                anchors.leftMargin: 24
                anchors.top: element1Subtitle.bottom
                anchors.topMargin: 24
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element2Subtitle
                text: qsTr("You can receive funds to your easy-to-share ENS name rather than your hexadecimal hash (0x...).")
                anchors.left: element2Number.right
                anchors.leftMargin: 24
                anchors.top: element2Title.bottom
                anchors.topMargin: 24
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.pixelSize: 14
            }

            StyledText {
                id: element3Number
                text: "3"
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.top: element2Subtitle.bottom
                anchors.topMargin: 24
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element3Title
                text: qsTr("Receive transactions in chat")
                anchors.left: element3Number.right
                anchors.leftMargin: 24
                anchors.top: element2Subtitle.bottom
                anchors.topMargin: 24
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element3Subtitle
                text: qsTr("Others can send you funds via chat in one simple step.")
                anchors.left: element3Number.right
                anchors.leftMargin: 24
                anchors.top: element3Title.bottom
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                anchors.topMargin: 24
                font.pixelSize: 14
            }

            StyledText {
                id: element4Number
                text: "4"
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.top: element3Subtitle.bottom
                anchors.topMargin: 24
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element4Title
                text: qsTr("10 SNT to register")
                anchors.left: element4Number.right
                anchors.leftMargin: 24
                anchors.top: element3Subtitle.bottom
                anchors.topMargin: 24
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element4Subtitle
                text: qsTr("Register once to keep the name forever. After 1 year you can release the name and get your SNT back.")
                anchors.left: element4Number.right
                anchors.leftMargin: 24
                anchors.top: element4Title.bottom
                anchors.topMargin: 24
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.pixelSize: 14
            }


            StyledText {
                id: element5Number
                text: "@"
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.top: element4Subtitle.bottom
                anchors.topMargin: 24
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element5Title
                text: qsTr("Already own a username?")
                anchors.left: element5Number.right
                anchors.leftMargin: 24
                anchors.top: element4Subtitle.bottom
                anchors.topMargin: 24
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.weight: Font.Bold
                font.pixelSize: 14
            }

            StyledText {
                id: element5Subtitle
                text: qsTr("You can verify and add any usernames you own in the next steps.")
                anchors.left: element5Number.right
                anchors.leftMargin: 24
                anchors.top: element5Title.bottom
                anchors.topMargin: 24
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.pixelSize: 14
            }

            StyledText {
                id: poweredBy
                text: qsTr("Powered by Ethereum Name Services")
                anchors.left: element5Number.right
                anchors.leftMargin: 24
                anchors.top: element5Subtitle.bottom
                anchors.topMargin: 40
                anchors.right: parent.right
                wrapMode: Text.WordWrap
                font.pixelSize: 11
            }
        }
    }

    StyledButton {
        id: startBtn
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Style.current.padding
        anchors.horizontalCenter: parent.horizontalCenter
        label: qsTr("Start")
        onClicked: startBtnClicked()
    }
}