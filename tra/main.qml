import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import QtQuick.Controls.Material 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15


ApplicationWindow {
    visible: true
    width: 1000  // Increased width to accommodate facts display
    height: 1000
    title: qsTr("Language Translator")
    Material.theme: darkMode ? Material.Dark : Material.Light // Set Material theme

    property string selectedImagePath: ""
    property bool darkMode: true

    Timer {
            id: clockTimer
            interval: 1000 // Update every second
            running: true
            repeat: true
            onTriggered: {
                currentTimeLabel.text = Qt.formatTime(new Date(), "hh:mm AP");
            }
        }

    Rectangle {
        id: topbar
        width: parent.width
        height: 60
        color: darkMode ? "#2f343f" : "#ffffff"  // Adjust color based on darkMode
        border.color: darkMode ? "#3b4148" : "#c0c0c0" // Adjust border color based on darkMode
        border.width: 1
        radius: 5
        anchors.horizontalCenter: parent.horizontalCenter

        // Top ToolBar
        ToolBar {
            id: topToolBar
            width: parent.width
            height: parent.height // Match the height of the topbar
            background: Rectangle { color: "transparent" } // Make the background transparent

            RowLayout {
                anchors.fill: parent  // Fill the toolbar
                spacing: 20
                Layout.alignment: Qt.AlignHCenter  // Center the layout horizontally

                Image {
                    source: "file:///C:/Users/HP/Documents/tra/output-onlinepngtools.png" // Path to your image resource
                    width: 100  // Set the desired width
                    height: 100  // Set the desired height
                    fillMode: Image.PreserveAspectFit  // Adjusts the image aspect ratio
                    Layout.alignment: Qt.AlignCenter
                }

                Button {
                    text: "Report"
                    onClicked: stackView.push(Qt.resolvedUrl("ReportPage.qml"))
                }

                Label {
                    id: currentTimeLabel
                    text: Qt.formatTime(new Date(), "hh:mm AP")
                    font.pixelSize: 16
                    color: darkMode ? "#ffffff" : "#000000"
                }
            }
        }
    }

    // Sidebar layout
    Rectangle {
        id: sidebar
        width: 50
        height: parent.height
        color: darkMode ? "#2f343f" : "#ffffff"  // Adjust color based on darkMode
        border.color: darkMode ? "#3b4148" : "#c0c0c0" // Adjust border color based on darkMode
        radius: 5
        anchors.left: parent.left

        ToolBar {
                   id: toolBar
                   anchors.top: parent.top
                   anchors.left: parent.left
                   width: parent.width
                   ToolButton {
                       text: "⋮" // Three dots
                       font.pointSize: 25
                       onClicked: {
                           console.log("Menu button clicked")
                           // Implement menu or drawer opening logic here
                       }
                   }
               }

        states: State {
            name: "active"
            PropertyChanges {
                target: sidebar
                width: 300
            }
        }

        Rectangle {
            id: logo
            width: parent.width
            height: 50
            color: "transparent"
            opacity: 0
            anchors.horizontalCenter: parent.horizontalCenter
            //Behavior on opacity {
              //  NumberAnimation { duration: 1500 }
            //}

            Row {
                anchors.centerIn: parent
                spacing: 5

                Image {
                    source: "file:///C:/Users/HP/Downloads/file.png" // Replace with the path to your logo image
                    width: 30
                    height: 30
                }

                Text {
                    id: logoName
                    text: "Bhasha"
                    font.pixelSize: 23
                    font.weight: Font.DemiBold
                    color: darkMode ? "#ffffff" : "#2f343f"
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    sidebar.state = sidebar.state === "" ? "active" : ""
                    logo.opacity = sidebar.state === "active" ? 1 : 0
                }
            }
        }

        // Button to view recent translations - placed directly below the logo
        Button {
            id: view
            text: "View Recent Translations"
            width: parent.width
            height: 45
            anchors.top: logo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: sidebar.state === "active"
            onClicked: {
                stackView.push(Qt.resolvedUrl("RecentTranslationsPage.qml"))  // Modified line
            }
        }

        // Button to delete recent translations
        Button {
            id: deleteData
            text: "Delete Recent Translations"
            width: parent.width
            height: 45
            anchors.top: view.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: sidebar.state === "active"
            onClicked: {
                translator.deleteRecentTranslations()
            }
        }

        Button {
                id: mode
                text: darkMode ? "Switch to Light Mode" : "Switch to Dark Mode"
                width: parent.width
                height: 45
                anchors.top: deleteData.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: sidebar.state === "active"
                onClicked: darkMode = !darkMode
            }

        Button {
                id: detali
                text: "About"
                width: parent.width
                height: 45
                anchors.top: mode.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: sidebar.state === "active"
                onClicked: {
                    stackView.push(Qt.resolvedUrl("detail.qml"))  // Modified line
            }
        }

        Button {
                id: credits
                text: "Credits and Tools"
                width: parent.width
                height: 45
                anchors.top: detali.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: sidebar.state === "active"
                onClicked: {
                    stackView.push(Qt.resolvedUrl("Credits.qml"))  // Modified line
            }
        }
    }

    // StackView for managing page navigation
    StackView {
        id: stackView
        initialItem: Item {
            Column {
                id: mainColumn
                anchors.centerIn: parent
                spacing: 10
                padding: 20
                anchors.margins: 100  // To adjust the main content after sidebar width
                // Mode selection
                ComboBox {
                    id: modeComboBox
                    width: 450
                    model: ["Text", "Speech", "Image"]
                }

                ComboBox {
                        id: fromLangComboBox
                        width: 450
                        model: ["English", "French", "Italian", "Japanese", "Hindi", "Russian", "Spanish", "German", "Korean", "Arabic"]

                        property var langMapping: {
                            "English": "en",
                            "French": "fr",
                            "Italian": "it ",
                            "Japanese": "ja",
                            "Hindi": "hi",
                            "Russian": "ru",
                            "Spanish": "es",
                            "German": "de",
                            "Korean": "ko",
                            "Arabic": "ar"
                        }

                        property string currentLangCode: langMapping[currentText]
                    }

                Button {
                    id:swapButton
                    text: "Swap" // Swap button
                    width: 450
                    height: 40

                onClicked: {
                    let temp = fromLangComboBox.currentIndex;
                           fromLangComboBox.currentIndex = toLangComboBox.currentIndex
                           toLangComboBox.currentIndex = temp;
                    }
                }

                ComboBox {
                    id: toLangComboBox
                    width: 450
                    model: ["English", "French", "Italian", "Japanese", "Hindi", "Russian", "Spanish", "German", "Korean", "Arabic"]

                    property var langMapping: {
                        "English": "en",
                        "French": "fr",
                        "Italian": "it",
                        "Japanese": "ja",
                        "Hindi": "hi",
                        "Russian": "ru",
                        "Spanish": "es",
                        "German": "de",
                        "Korean": "ko",
                        "Arabic": "ar"
                    }

                    property string currentLangCode: langMapping[currentText]
                }


                // Input field
                TextField {
                    id: inputField
                    width: 450
                    placeholderText: "Enter text"
                    visible: modeComboBox.currentIndex === 0
                }

                // Image selection
                Button {
                    id: selectImageButton
                    text: "Select Image"
                    width: 450
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

                Label {
                    id: imagePathLabel
                    visible: modeComboBox.currentIndex === 2
                    width: 450
                    wrapMode: Text.WordWrap
                    text: "No image selected"
                }

                // Translate button
                Button {
                    text: "Translate"
                    width: 450
                    onClicked:
                    {
                        if (modeComboBox.currentText === "Text") {
                            translator.translateText(inputField.text, fromLangComboBox.currentLangCode, toLangComboBox.currentLangCode)
                        } else if (modeComboBox.currentText === "Speech") {
                            translator.translateSpeech(fromLangComboBox.currentLangCode, toLangComboBox.currentLangCode)
                        } else if (modeComboBox.currentText === "Image") {
                            if (selectedImagePath !== "") {
                                var cleanPath = selectedImagePath.replace(/^(file:\/{2})|(qrc:\/{2})|(http:\/{2})/,"");
                                cleanPath = cleanPath.replace(/^\/(.:\/)/, "$1");
                                translator.translateImage(cleanPath, fromLangComboBox.currentLangCode, toLangComboBox.currentLangCode)
                            } else {
                                outputLabel.text = "Please select an image first."
                            }
                        }

                        var facts = getLanguageFacts(toLangComboBox.currentText).concat([" ","==============================="]).concat(getLanguageFacts(fromLangComboBox.currentText)).join("\n");
                        rightSidebar.displayFacts(facts); // Pass combined facts to the typing effect

                    }
                }

                // Output label
                Label {
                    id: outputLabel
                    width: 450
                    wrapMode: Text.WordWrap
                }

               Connections {
                    target: translator
                    function onTranslationComplete(result) {
                        outputLabel.text = result;
                    }
                    function onErrorOccurred(error) {
                        outputLabel.text = error;
                    }
                }
            }
        }
        anchors.fill: parent
        Rectangle {
               id: rightSidebar
               width: 50
               height: parent.height
               color: darkMode ? "#2f343f" : "#ffffff"  // Adjust background color for dark mode
               border.color: darkMode ? "#3b4148" : "#c0c0c0" // Adjust border color
               border.width: 1  // Add visible border
               radius: 5
               anchors.right: parent.right

               property string fullText: ""  // Stores the full text to display
               property int currentIndex: 0 // Tracks the current character position

                states: State {
                    name: "active"
                    PropertyChanges {
                        target: rightSidebar
                        width: 300
                    }
                }

                TextArea {
                        id: factsLabel
                        anchors.fill: parent
                        anchors.margins: 0
                        wrapMode: Text.WordWrap
                        readOnly: true
                        font.pointSize: 10
                        color: darkMode ? "#ffffff" : "#000000"
                        background: Rectangle {
                            color: darkMode ? "#2f343f" : "#ffffff"
                            radius: 5
                        }
                        visible: rightSidebar.state === "active" && factsLabel.text !== ""

                    }

                Timer {
                        id: typingTimer
                        interval: 32 // Adjust speed of typing
                        repeat: true
                        running: true
                        onTriggered: {
                            if (rightSidebar.currentIndex < rightSidebar.fullText.length) {
                                factsLabel.text += rightSidebar.fullText[rightSidebar.currentIndex];
                                rightSidebar.currentIndex++;
                            } else {
                                stop(); // Stop the timer when done
                            }
                        }
                    }

                MouseArea {
                       anchors.fill: parent
                       onClicked: {
                           rightSidebar.state = rightSidebar.state === "" ? "active" : "";
                           if (rightSidebar.state === "") {
                               // Reset the facts label when the sidebar collapses
                               factsLabel.text = "";
                               typingTimer.stop();
                           }
                       }
                   }

                function displayFacts(text) {
                        fullText = text;  // Store the full text
                        factsLabel.text = ""; // Reset the displayed text
                        currentIndex = 0; // Reset the index
                        typingTimer.start(); // Start the typing animation
                    }
            }
    }
    // Function to get facts about the output language
    function getLanguageFacts(language) {
        var facts = {
            "English": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝙀𝙣𝙜𝙡𝙞𝙨𝙝：",
                "",
                "• English is the third most spoken language in the world.",
                "• It is the primary language of 58 countries.",
                "• Over 1.5 billion people speak English worldwide.",
                "• English is the official language of aviation and maritime communication.",
                "• It has borrowed words from many languages, including Latin, French, and German."
            ],
            "French": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝙁𝙧𝙚𝙣𝙘𝙝: ",
                "",
                "• French is spoken in 29 countries across five continents.",
                "• It is one of the official languages of the United Nations.",
                "• French is the second most studied language in the world.",
                "• It is known for its rich literary tradition.",
                "• French cuisine and culture have influenced many countries."
            ],
            "Italian": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝙄𝙩𝙖𝙡𝙞𝙖𝙣: ",
                "",
                "• Italian is the official language of Italy and Switzerland.",
                "• It is known for its musicality and is often used in opera.",
                "• Italian has many dialects, with some being quite distinct.",
                "• It is the language of art, music, and architecture.",
                "• Italian cuisine is famous worldwide."
            ],
            "Japanese": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝙅𝙖𝙥𝙖𝙣𝙘𝙚𝙨𝙚: ",
                "",
                "• Japanese is spoken by over 125 million people.",
                "• It has three writing systems: Hiragana, Katakana, and Kanji.",
                "• Japanese culture is rich in traditions and modern influences.",
                "• It is known for its unique honorifics and politeness levels.",
                "• Japan has a significant impact on technology and pop culture."
            ],
            "Hindi": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝙃𝙞𝙣𝙙𝙞: ",
                "",
                "• Hindi is one of the official languages of India.",
                "• It is spoken by over 500 million people.",
                "• Hindi is written in the Devanagari script.",
                "• It has many dialects and regional variations.",
                "• Bollywood films are primarily produced in Hindi."
            ],
            "Russian": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝙍𝙪𝙨𝙨𝙞𝙖𝙣: ",
                "",
                "• Russian is the most widely spokenSlavic language in the world.",
                "• It is the official language of Russia and several other countries.",
                "• Russian uses the Cyrillic alphabet.",
                "• It has a rich literary tradition with famous authors like Tolstoy and Dostoevsky.",
                "• Russian is known for its complex grammar and vocabulary."
            ],
            "Spanish": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝙎𝙥𝙖𝙣𝙞𝙨𝙝: ",
                "",
                "• Spanish is the second most spoken language in the world by native speakers.",
                "• It is the official language of 20 countries.",
                "• Spanish has many regional dialects and variations.",
                "• It is one of the six official languages of the United Nations.",
                "• Spanish literature has a rich history with notable authors like Cervantes."
            ],
            "German": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝙂𝙚𝙧𝙢𝙖𝙣: ",
                "",
                "• German is the most widely spoken language in the European Union.",
                "• It is the official language of Germany, Austria, and Switzerland.",
                "• German has a strong influence on philosophy, literature, and science.",
                "• It is known for its compound words and grammatical cases.",
                "• Germany is known for its contributions to music, engineering, and technology."
            ],
            "Korean": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝙆𝙤𝙧𝙚𝙖𝙣: ",
                "",
                "• Korean is the official language of both South and North Korea.",
                "• It uses a unique script called Hangul.",
                "• Korean has a rich cultural heritage with influences from China and Japan.",
                "• It is known for its honorifics and levels of politeness.",
                "• K-pop and Korean dramas have popularized the language globally."
            ],
            "Arabic": [
                "",
                "𝙔𝙤𝙪 𝙠𝙣𝙤𝙬 𝙖𝙗𝙤𝙪𝙩 𝘼𝙧𝙖𝙗𝙞𝙘: ",
                "",
                "• Arabic is spoken in over 20 countries and is the liturgical language of Islam.",
                "• It has many dialects that can vary significantly from one region to another.",
                "• Arabic is written from right to left.",
                "• It has a rich history in literature, science, and philosophy.",
                "• Arabic calligraphy is a highly regarded art form."
            ]
        };
        return facts[language] || [];
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
