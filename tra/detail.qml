import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

Page {

    Rectangle {
        anchors.fill: parent
        color: darkMode ? "#2f343f" : "#ffffff"
        border.color: darkMode ? "#3b4148" : "#c0c0c0"

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 30

            Label {
                text: "Social Media & Source"
                font.pixelSize: 24
                font.bold: true
                color: darkMode ? "#ffffff" : "#2f343f"
                horizontalAlignment: Text.AlignHCenter
            }

            GridLayout {
                columns: 4 // Two-column layout
                rowSpacing: 20
                columnSpacing: 20

                // Upper Social Media Row
                Repeater {
                    model: [
                        {
                            name: "Instagram",
                            text: "Instagram\n@_vans.h_05",
                            url: "https://www.instagram.com/_vans.h_05/",
                            icon: "file:///C:/Users/HP/Documents/tra/instagram icon.png"
                        },

                        {   name: "X",
                            text: "X\n@vansh_gupta_",
                            url: "https://x.com/vansh_gupta_",
                            icon: "file:///C:/Users/HP/Documents/tra/twitter x icon.png"
                        },

                        {   name: "LinkedIn",
                            text: "LinkedIn\nVansh Kumar",
                            url: "https://www.linkedin.com/in/vansh-kumar-5b422a322/",
                            icon: "file:///C:/Users/HP/Documents/tra/linkedin icon.png"
                        },

                        {
                            name: "GitHub",
                            text: "GitHub\nVansh-gupta01",
                            url: "https://github.com/Vansh-gupta01",
                            icon: "file:///C:/Users/HP/Documents/tra/github icon.png"
                        }
                          ]

                                    delegate: Rectangle {
                                        width: 150
                                        height: 100
                                        color: darkMode ? "#2f343f" : "#ffffff"
                                        radius: 5
                                        border.color: "#5c5c5c"
                                        border.width: 2

                                        Column {
                                            anchors.centerIn: parent
                                            spacing: 5

                                            Image {
                                                source: modelData.icon
                                                width: 32
                                                height: 32
                                                smooth: true
                                            }

                                            Text {
                                                text: modelData.text
                                                color: darkMode ? "#ffffff" : "#2f343f"
                                                font.pixelSize: 14
                                                font.bold: true
                                                horizontalAlignment: Text.AlignHCenter
                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor

                                            onClicked: {
                                                Qt.openUrlExternally(modelData.url);
                                            }
                                        }
                                    }
                                }

                // Instagram Button (Left Column)
                Rectangle {
                    width: 150
                    height: 100
                    color: darkMode ? "#2f343f" : "#ffffff"
                    radius: 5
                    border.color: "#5c5c5c"
                    border.width: 2

                    Column {
                        anchors.centerIn: parent
                        spacing: 5

                        Image {
                            source: "file:///C:/Users/HP/Documents/tra/instagram icon.png"
                            width: 32
                            height: 32
                            smooth: true
                        }

                        Text {
                            text: "Instagram:\n@_0megax_"
                            color: darkMode ? "#ffffff" : "#2f343f"
                            font.pixelSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            Qt.openUrlExternally("https://www.instagram.com/_0megax_/");
                        }
                    }
                }

                // X (Twitter) Button (Right Column)
                Rectangle {
                    width: 150
                    height: 100
                    color: darkMode ? "#2f343f" : "#ffffff"
                    radius: 5
                    border.color: "#5c5c5c"
                    border.width: 2

                    Column {
                        anchors.centerIn: parent
                        spacing: 5

                        Image {
                            source: "file:///C:/Users/HP/Documents/tra/twitter x icon.png"
                            width: 32
                            height: 32
                            smooth: true
                        }

                        Text {
                            text: "X:\n@dd99770883"
                            color: darkMode ? "#ffffff" : "#2f343f"
                            font.pixelSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            Qt.openUrlExternally("https://x.com/dd99770883");
                        }
                    }
                }

                // LinkedIn Button (Left Column)
                Rectangle {
                    width: 150
                    height: 100
                    color: darkMode ? "#2f343f" : "#ffffff"
                    radius: 5
                    border.color: "#5c5c5c"
                    border.width: 2

                    Column {
                        anchors.centerIn: parent
                        spacing: 5

                        Image {
                            source: "file:///C:/Users/HP/Documents/tra/linkedin icon.png"
                            width: 32
                            height: 32
                            smooth: true
                        }

                        Text {
                            text: "LinkedIn:\nNitin Thapa"
                            color: darkMode ? "#ffffff" : "#2f343f"
                            font.pixelSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            Qt.openUrlExternally("https://www.linkedin.com/in/nitin-thapa-22752a2a1/");
                        }
                    }
                }

                // GitHub Button (Right Column)
                Rectangle {
                    width: 150
                    height: 100
                    color: darkMode ? "#2f343f" : "#ffffff"
                    radius: 5
                    border.color: "#5c5c5c"
                    border.width: 2

                    Column {
                        anchors.centerIn: parent
                        spacing: 5

                        Image {
                            source: "file:///C:/Users/HP/Documents/tra/github icon.png"
                            width: 32
                            height: 32
                            smooth: true
                        }

                        Text {
                            text: "GitHub:\nOMEGAXGG"
                            color: darkMode ? "#ffffff" : "#2f343f"
                            font.pixelSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            Qt.openUrlExternally("https://github.com/OMEGAXGG");
                        }
                    }
                }


            // Lower Social Media Row
                            Repeater {
                                model: [
                                    {
                                        name: "Instagram",
                                        text: "Instagram:\n@its_saurav_911",
                                        url: "https://www.instagram.com/its_saurav_911",
                                        icon: "file:///C:/Users/HP/Documents/tra/instagram icon.png"
                                    },

                                    {
                                        name: "X",
                                        text: "X: ",
                                        url: " ",
                                        icon: "file:///C:/Users/HP/Documents/tra/twitter x icon.png"
                                    },

                                    {
                                        name: "LinkedIn",
                                        text: "LinkedIn: ",
                                        url: " ",
                                        icon: "file:///C:/Users/HP/Documents/tra/linkedin icon.png"
                                    },

                                    {
                                        name: "GitHub",
                                        text: "GitHub: ",
                                        url: " ",
                                        icon: "file:///C:/Users/HP/Documents/tra/github icon.png"
                                    }
                                ]

                                delegate: Rectangle {
                                    width: 150
                                    height: 100
                                    color: darkMode ? "#2f343f" : "#ffffff"
                                    radius: 5
                                    border.color: "#5c5c5c"
                                    border.width: 2

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 5

                                        Image {
                                            source: modelData.icon
                                            width: 32
                                            height: 32
                                            smooth: true
                                        }

                                        Text {
                                            text: modelData.text
                                            color: darkMode ? "#ffffff" : "#2f343f"
                                            font.pixelSize: 14
                                            font.bold: true
                                            horizontalAlignment: Text.AlignHCenter
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor

                                        onClicked: {
                                            Qt.openUrlExternally(modelData.url);
                                        }
                                    }
                                }
                            }

            // Back Button
            Button {
                text: "Back"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    stackView.pop();  // Navigate back in the stack
                }
            }
        }
    }
}
}
