import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs

Page {
    id: recentTranslationsPage

    // Back Button on the top-left
    Item {
        width: parent.width
        height: 50

        Button {
            text: "Back"
            width: 100
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            onClicked: {
                stackView.pop()  // Navigate back in the stack
            }
        }
    }

    Column {
        anchors.centerIn: parent  // Centers the content in the parent container
        spacing: 10

        Label {
            text: "Recent Translations"
            font.pixelSize: 24
            font.bold: true
        }

        Button {
            text: "View Recent Translations"
            width: 300
            onClicked: {
                translator.getRecentTranslations(6)
            }
        }

        Label {
            id: outputLabel
            width: 300
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
            function onRecentTranslationsReceived(translations) {
                var output = "Recent Translations:\n\n";
                for (var i = 0; i < translations.length; i++) {
                    var translation = translations[i];
                    output += "From " + translation.fromLang + " to " + translation.toLang + ":\n";
                    output += "Source: " + translation.sourceText + "\n";
                    output += "Translation: " + translation.translatedText + "\n";
                    output += "Timestamp: " + translation.timestamp + "\n\n";
                }
                outputLabel.text = output;
            }
        }
    }
}
