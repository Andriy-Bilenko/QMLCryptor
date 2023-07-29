import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Page{
    id: root
    property alias backgroundColor: backgroundRect.color
    property alias button1Text: button1.text
    property alias button2Text: button2.text
    property alias button3Text: button3.text
    signal button1Clicked();
    signal button2Clicked();
    signal button3Clicked();

    background: Rectangle{
        id:backgroundRect
    }

    Button{
        id:button1
        y: parent.height * 0.2
        width: parent.width / 2
        height: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        background: Rectangle{
            color: "red"
        }
        onClicked: {
            root.button1Clicked();
        }
    }

    Button {
        id: button2
        y: parent.height * 0.45
        width: parent.width / 2
        height: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        background: Rectangle{
            color: "blue"
        }
        onClicked: {
            root.button2Clicked();
        }
    }

    Button {
        id: button3
        y: parent.height * 0.7
        width: parent.width / 2
        height: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
            root.button3Clicked();
        }
    }
}
