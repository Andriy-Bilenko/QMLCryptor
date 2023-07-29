import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15



Page{
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias button1Text: button1.text
    property alias button2Text: button2.text
    property alias button3Text: button3.text
    property alias filePathLabelText: labelFilePath.text
    property alias password: textField.text
    signal button1Clicked();
    signal button2Clicked();
    signal button3Clicked();
    property var results: []


    background: Rectangle{
        id:backgroundRect
    }

    Frame {
        id: frame1
        x: 0
        y: 0
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.4
        Button{
            id:button1
            y: parent.height * 0.15
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                root.button1Clicked();
            }
        }
        TextArea {
            id: labelFilePath
            y: parent.height * 0.5
            width: parent.width
            height: parent.height * 0.5
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "path/to/the/file"
            color: "black"
            wrapMode: TextArea.WrapAnywhere
            readOnly: true
        }
    }

    Frame {
        id: frame2
        x: 0
        y: parent.height * 0.4
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.4
        Label {
            id: labelPassPrompt
            y: parent.height * 0.1
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("pass:")
            color: "black"
        }

        Column {
            spacing: 40
            width: parent.width
            y: parent.height * 0.3
            TextField {
                id: textField
                placeholderText: qsTr(" your password")
                anchors.horizontalCenter: parent.horizontalCenter
                inputMethodHints: Qt.ImhNone
            }
        }


        Button {
            id: button2
            y: parent.height * 0.8
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                root.button2Clicked();
            }
        }
    }


    Button {
        id: button3
        y: parent.height * 0.85
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            root.button3Clicked();
        }
    }
}
