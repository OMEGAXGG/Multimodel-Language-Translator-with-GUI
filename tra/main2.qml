// File: main2.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

Item {
    width: 450
    height: 600

    // Application properties
    property string selectedImagePath: ""
    property bool darkMode: true

    // Main content container
    Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        color: darkMode ? "#2f343f" : "#f0f0f0"


        AnimatedImage {
            id: animatedImage
            x: 0
            y: 0
            width: 450
            height: 600
            source: "c:/Users/HP/Downloads/3163534-hd_1280_720_30fps.mp4"
        }

        Column {
            id: mainColumn
            x: 55
            y: 197
            width: 340
            height: 514
            anchors.centerIn: parent
            spacing: 10
            padding: 20

            // Dark mode toggle
            Button {
                text: darkMode ? "Switch to Light Mode" : "Switch to Dark Mode"
                width: 300
                onClicked: darkMode = !darkMode
            }

            // Mode selection
            ComboBox {
                id: modeComboBox
                width: 300
                model: ["Text", "Speech", "Image"]
            }

            // Input field for text mode
            TextField {
                id: inputField
                width: 300
                placeholderText: "Enter text"
                visible: modeComboBox.currentIndex === 0
            }

            // Image selection button
            Button {
                id: selectImageButton
                text: "Select Image"
                width: 300
                visible: modeComboBox.currentIndex === 2
                onClicked: fileDialog.open()
            }

            FileDialog {
                id: fileDialog
                title: "Choose an Image"
                fileMode: FileDialog.ExistingFile
                nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
                onAccepted: {
                    if (fileDialog.selectedFiles.length > 0) {
                        selectedImagePath = fileDialog.selectedFiles[0]
                        imagePathLabel.text = selectedImagePath
                    }
                }
                onRejected: {
                    console.log("Image selection canceled.")
                }
            }

            // Image path display label
            Label {
                id: imagePathLabel
                visible: modeComboBox.currentIndex === 2
                width: 300
                wrapMode: Text.WordWrap
                text: "No image selected"
            }

            // Language selection ComboBoxes
            ComboBox {
                id: fromLangComboBox
                width: 300
                model: ["English", "French", "Italian", "Japanese", "Hindi", "Russian", "Spanish", "German", "Korean"]

                property var langMapping: {
                    "English": "en",
                    "French": "fr",
                    "Italian": "it",
                    "Japanese": "ja",
                    "Hindi": "hi",
                    "Russian": "ru",
                    "Spanish": "es",
                    "German": "de",
                    "Korean": "ko"
                }
                property string currentLangCode: langMapping[currentText]
            }

            ComboBox {
                id: toLangComboBox
                width: 300
                model: ["English", "French", "Italian", "Japanese", "Hindi", "Russian", "Spanish", "German", "Korean"]

                property var langMapping: {
                    "English": "en",
                    "French": "fr",
                    "Italian": "it",
                    "Japanese": "ja",
                    "Hindi": "hi",
                    "Russian": "ru",
                    "Spanish": "es",
                    "German": "de",
                    "Korean": "ko"
                }
                property string currentLangCode: langMapping[currentText]
            }

            // Translate button
            Button {
                text: "Translate"
                width: 300
                onClicked: {
                    if (modeComboBox.currentText === "Text") {
                        // Logic for text translation
                    } else if (modeComboBox.currentText === "Speech") {
                        // Logic for speech translation
                    } else if (modeComboBox.currentText === "Image") {
                        if (selectedImagePath !== "") {
                            // Logic for image translation
                        } else {
                            outputLabel.text = "Please select an image first."
                        }
                    }
                }
            }

            // Output label for results
            Label {
                id: outputLabel
                width: 300
                wrapMode: Text.WordWrap
            }
        }
    }
    palette {
        window: darkMode ? "#2f343f" : "#f0f0f0"
        button: darkMode ? "#4f5d64" : "#e0e0e0"
        highlight: darkMode ? "#3b4148" : "#c0c0c0"
        text: darkMode ? "#ffffff" : "#000000"
        base: darkMode ? "#2f343f" : "#f0f0f0"
        alternateBase: darkMode ? "#3b4148" : "#e0e0e0"
    }
}

/*##^##
Designer {
    D{i:0}D{i:2;locked:true}
}
##^##*/
