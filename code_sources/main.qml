import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import FileCryptor 1.0
import Qt.labs.folderlistmodel 2.15

ApplicationWindow {
    id: window
    width: 300
    height: 600
    visible: true
    title: qsTr("cryptor")

    FileCryptor{
        id:cryptor
    }

    StackView {
        id: stack
        initialItem: startPointPage
        anchors.fill: parent
    }
    MainPage{
        id: startPointPage
        backgroundColor: "black"
        button1Text: "encrypt"
        button2Text: "decrypt"
        button3Text: "exit"
        onButton1Clicked: {
            stack.push(encryptPage);
        }
        onButton2Clicked: {
            stack.push(decryptPage);
        }
        onButton3Clicked: {
            Qt.quit()
        }
    }


    PeriferalPage {
        id:encryptPage
        property string information: "encryptPage"
        backgroundColor: "red"
        button1Text: "choose file"
        button2Text: "encrypt"
        button3Text: "back"
        visible: false
        onButton3Clicked: {
            stack.pop(startPointPage);
        }
        onButton2Clicked: {
            if(encryptPage.filePathLabelText === ""){
                messageDialog.title = "error"
                messageDialog.text = "please specify the path to the file"
                messageDialog.open();
            }else if(encryptPage.password === ""){
                messageDialog.title = "error"
                messageDialog.text = "please specify the password"
                messageDialog.open();
            }else{
                results = cryptor.encryptFile(encryptPage.filePathLabelText, encryptPage.password);
                if(results[0] !== "success"){
                    messageDialog.title = "error"
                    messageDialog.text = results[0] + "\npath:" + results[1]
                    messageDialog.open();
                }else{
                    messageDialog.title = results[0]
                    messageDialog.text = "path:" + results[1] + "\npass:" + results[2]
                    messageDialog.open();
                    encryptPage.filePathLabelText = ""
                    encryptPage.password = ""
                }
            }
        }
        onButton1Clicked: {
            openDialog.open();
        }
    }

    PeriferalPage {
        id:decryptPage
        property string information: "decryptPage"
        backgroundColor: "blue"
        button1Text: "choose file"
        button2Text: "decrypt"
        button3Text: "back"
        visible: false
        onButton3Clicked: {
            stack.pop(startPointPage);
        }
        onButton2Clicked: {
            if(decryptPage.filePathLabelText === ""){
                messageDialog.title = "error"
                messageDialog.text = "please specify the path to the file"
                messageDialog.open();
            }else if(decryptPage.password === ""){
                messageDialog.title = "error"
                messageDialog.text = "please specify the password"
                messageDialog.open();
            }else{
                results = cryptor.decryptFile(decryptPage.filePathLabelText, decryptPage.password);
                if(results[0] !== "success"){
                    messageDialog.title = "error"
                    messageDialog.text = results[0] + "\npath:" + results[1]
                    messageDialog.open();
                }else{
                    messageDialog.title = results[0]
                    messageDialog.text = "\npath:" + results[1] + "\npass:" + results[2]
                    messageDialog.open();
                    decryptPage.filePathLabelText = ""
                    decryptPage.password = ""
                }
            }
        }
        onButton1Clicked: {
            openDialog.open();
        }
    }

    FileDialog {
        id: openDialog
        title: "Please choose a file"
        currentFolder: shortcuts.home
        onAccepted: {
            openDialog.OpenFile
            if(stack.get(1).information === "encryptPage"){
                console.info("it is encryptPage")
                encryptPage.filePathLabelText = selectedFile;
            }else if(stack.get(1).information === "decryptPage"){
                console.info("it is decryptPage")
                decryptPage.filePathLabelText = selectedFile;
            }else{
                messageDialog.title = "error"
                messageDialog.text = "error defining current page"
                messageDialog.open();
            }
        }
    }
    MessageDialog {
        id: messageDialog
        title: "title"
        text: "text"
        onAccepted: {
            messageDialog.close()
        }
        onButtonClicked: {
            messageDialog.close()
        }
    }
}
