pragma Singleton

import QtQuick 2.8

QtObject {
  readonly property int chatTypeOneToOne: 1
  readonly property int chatTypePublic: 2
  readonly property int chatTypePrivateGroupChat: 3

  readonly property int messageType: 1
  readonly property int stickerType: 2
}