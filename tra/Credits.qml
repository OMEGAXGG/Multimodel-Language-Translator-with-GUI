import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

Page {
        id: creditsPage
        title: "Credits"
    Rectangle {
        anchors.fill: parent
        color: darkMode ? "#2f343f" : "#ffffff"
        border.color: darkMode ? "#3b4148" : "#c0c0c0"

        ScrollView {
            anchors.fill: parent
            visible: true
            contentItem: Column {
                spacing: 10
                padding: 20
                Text {
                    text: "Credits"
                    font.pointSize: 20
                    font.bold: true
                    color: darkMode ? "#ffffff" : "#2f343f"
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                     text: "QT Credits"
                     font.pointSize: 13
                     font.bold: true
                     color: darkMode ? "#ffffff" : "#2f343f"
                     anchors.horizontalCenter: parent.horizontalCenter
                     horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    text: "Developed by: John Doe"
                    color: darkMode ? "#ffffff" : "#2f343f"
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    text: "Design by: Jane Smith"
                    color: darkMode ? "#ffffff" : "#2f343f"
                    anchors.horizontalCenter: parent.horizontalCenter
                     horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    text: "Powered by: Qt Group Plc"
                    color: darkMode ? "#ffffff" : "#2f343f"
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    text: "Qt is a cross-platform framework for developing software applications and embedded devices"
                    color: darkMode ? "#ffffff" : "#2f343f"
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Qt Framework: The Qt Framework is the backbone of your application, providing tools for GUI development, cross-platform compatibility, and integration with other components."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Qt Creator: Qt Creator is a cross-platform integrated development environment (IDE) that helps developers create software for mobile, desktop, and embedded platforms."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "QML: QML is a simple language that helps developers design beautiful, interactive, and smooth user interfaces for apps."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }

                Text {
                     text: "C++ Credits"
                     font.pointSize: 13
                     font.bold: true
                     color: darkMode ? "#ffffff" : "#2f343f"
                     anchors.horizontalCenter: parent.horizontalCenter
                     horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "C++: The C++ part plays a crucial role in managing the graphical user interface (GUI) and providing the backbone for user interactions in this project."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Graphical User Interface (GUI) Development: We are using the Qt framework to design the GUI in C++"
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Integration with Python Components: C++ help to handle the user interactions and delegates tasks to Python scripts while ensuring seamless data exchange between the two languages."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Event Handling: All user inputs (e.g., selecting a file, clicking buttons, or switching modes) are processed using C++ event handlers in the Qt framework."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }

                Text {
                     text: "Python Credits"
                     font.pointSize: 13
                     font.bold: true
                     color: darkMode ? "#ffffff" : "#2f343f"
                     anchors.horizontalCenter: parent.horizontalCenter
                     horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Python: The python help to Executes translation or recognition tasks using the appropriate Python libraries with the applying language-specific models."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Translation: argostranslate is enables the offline translation by utilizing pre-trained translation models."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Speech Recognition: speech_recognition library purpose is to converts spoken words into text."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Optical Character Recognition(OCR): Is a technology that converts text in an image into a machine-readable format.  \n1.cv2 (OpenCV): Is reads and processes images.\n2.easyocr: Extracts text from images using Optical Character Recognition (OCR). \n3.Pillow(PIL): Handles image manipulation."
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "sqlite3: Manages a local SQLite database for storing translation history"
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }


                Text {
                    text: "Special Thanks"
                    font.pointSize: 12
                    font.bold: true
                    color: darkMode ? "#ffffff" : "#2f343f"
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                        text: "Community: I.Qt community\nII.Argos Translate community\nIII.OpenCV Community\nIV.easyocr community\nV.sqlite3 community"
                        color: darkMode ? "#ffffff" : "#2f343f"
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        //anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.NoWrap
                        horizontalAlignment: Text.AlignHCenter
                }

                Button {
                    text: "Back"
                    onClicked: stackView.pop()
                }
            }
        }
    }
}
