import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

Page {
    id: reportpage
    Rectangle {
                width: parent.width
                height: parent.height
                color: "transparent"

                Row {
                    id: layoutRow
                    spacing: 20
                    anchors.centerIn: parent

                    // Report Column
                    Column {
                        id: reportColumn
                        spacing: 10
                        width: 400

                        Label {
                            text: "Report an Issue"
                            font.pixelSize: 18
                            font.bold: true
                        }

                        TextField {
                            id: reportName
                            width: parent.width
                            placeholderText: "Enter your name"
                        }

                        TextField {
                            id: reportEmail
                            width: parent.width
                            placeholderText: "Enter your email"
                        }

                        TextArea {
                            id: reportMessage
                            width: parent.width
                            height: 100
                            placeholderText: "Describe your issue..."
                        }

                        Button {
                            id: submit_button
                            text: "Submit Report"
                            width: parent.width
                            onClicked: {
                                console.log("Report Submitted:-")
                                console.log("Name:", reportName.text)
                                console.log("Email:", reportEmail.text)
                                console.log("Message:", reportMessage.text)

                                reportName.text = ""
                                reportEmail.text = ""
                                reportMessage.text = ""

                                // Show success message
                                successMessage.text = "Report submitted successfully!"
                                successMessage.visible = true;

                                // Start a timer to hide the message after 3 seconds
                                successTimer.start();
                            }
                        }

                        Label {
                                id: successMessage
                                text: ""
                                font.pixelSize: 14
                                color: darkMode ? "#ffffff" : "#2f343f" // Change color to indicate success
                                visible: false // Initially hidden
                            }

                        Button
                        {
                                text: "Back"
                                width: 100
                                onClicked:
                                    {
                                        stackView.pop(); // Assuming you are using a StackView for navigation
                                    }
                        }
                    }

                }
            }
    Timer
    {
            id: successTimer
            interval: 10000
            onTriggered: {
                successMessage.visible = false; // Hide the message
                console.log("Success message hidden"); // Debugging log
            }
    }
}
