#include "translator.h"
#include <QDebug>

Translator::Translator(QObject *parent) : QObject(parent)
{
    // Capture standard output from the Python script
    connect(&m_process, &QProcess::readyReadStandardOutput, [this]() {
        QString result = m_process.readAllStandardOutput();
        qDebug() << "Output from Python script:" << result;

        // Process the output depending on the current mode
        processOutput(result);
    });

    // Capture standard error from the Python script
    connect(&m_process, &QProcess::readyReadStandardError, [this]() {
        QString errorOutput = m_process.readAllStandardError();
        qDebug() << "Error from Python script:" << errorOutput;
        emit errorOccurred(errorOutput.trimmed());
    });

    // Handle process errors
    connect(&m_process, &QProcess::errorOccurred, [this](QProcess::ProcessError error) {
        qDebug() << "Process error:" << error;
        emit errorOccurred(QString("Process error: %1").arg(error));
    });

    // Handle process completion
    connect(&m_process, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
            this, [](int exitCode, QProcess::ExitStatus exitStatus) {
                if (exitStatus == QProcess::CrashExit) {
                    qDebug() << "Python script crashed with exit code:" << exitCode;
                } else {
                    qDebug() << "Python script finished with exit code:" << exitCode;
                }
            });
}

void Translator::runPythonScript(const QStringList &arguments)
{
    QString program = "python";  // Change to "python3" if needed in your environment
    QStringList args;
    args << "C:/Users/HP/Documents/tra/translator.py" << arguments;  // Full path to the Python script

    qDebug() << "Running Python script with arguments:" << args;

    m_process.start(program, args);

    if (!m_process.waitForStarted()) {
        qDebug() << "Failed to start Python script.";
        emit errorOccurred("Failed to start Python script");
    }
}

void Translator::translateText(const QString &text, const QString &fromLang, const QString &toLang)
{
    m_currentMode = "text";  // Set current mode
    runPythonScript(QStringList() << "text" << fromLang << toLang << text);
}

void Translator::translateSpeech(const QString &fromLang, const QString &toLang)
{
    m_currentMode = "speech";  // Set current mode
    runPythonScript(QStringList() << "speech" << fromLang << toLang);
}

void Translator::translateSpeechToSpeech(const QString &fromLang, const QString &toLang)
{
    m_currentMode = "speech_to_speech"; // Set the mode for S2S
    //m_targetLang = toLang;
    // Run the Python script with speech-to-text mode to first convert speech into text
    runPythonScript(QStringList() << "speech" << fromLang << toLang);

    // Use the captured output to invoke text-to-speech in the `processOutput` method
}

void Translator::translateImage(const QString &imagePath, const QString &fromLang, const QString &toLang)
{
    m_currentMode = "image";  // Set current mode
    runPythonScript(QStringList() << "image" << fromLang << toLang << imagePath);
}

void Translator::getRecentTranslations(int limit)
{
    m_currentMode = "recent";  // Set current mode
    QStringList args;
    args << "recent" << QString::number(limit);
    runPythonScript(args);
}

void Translator::deleteRecentTranslations()
{
    m_currentMode = "delete_recent";  // Set current mode
    runPythonScript(QStringList() << "delete_recent");  // Call the Python script with the delete command
}

void Translator::processOutput(const QString &output)
{
    if (m_currentMode == "recent") {
        QVariantList translations;
        // Split the output by lines and filter out empty or separator lines
        QStringList lines = output.split("\n", Qt::SkipEmptyParts);

        QVariantMap translation;

        for (const QString &line : lines) {
            if (line.contains("---")) {
                // Finished processing one translation, append it to the list
                if (!translation.isEmpty()) {
                    translations.append(translation);
                    translation.clear();
                }
            } else if (line.startsWith("From")) {
                QStringList parts = line.split(" ");
                if (parts.size() >= 4) {
                    translation["fromLang"] = parts[1].trimmed();
                    translation["toLang"] = parts[3].trimmed().remove(":");
                }
            } else if (line.startsWith("Source:")) {
                translation["sourceText"] = line.split(":")[1].trimmed();
            } else if (line.startsWith("Translation:")) {
                translation["translatedText"] = line.split(":")[1].trimmed();
            } else if (line.startsWith("Timestamp:")) {
                translation["timestamp"] = line.split(":")[1].trimmed();
            }
        }

        // Append the last translation if there is one
        if (!translation.isEmpty()) {
            translations.append(translation);
        }

        emit recentTranslationsReceived(translations);
    }
    else if (m_currentMode == "speech_to_speech") {
        // Pass the translated text for text-to-speech
        runPythonScript(QStringList() << "text_to_speech" << output.trimmed() << m_targetLang);
    }
    else {
        emit translationComplete(output.trimmed());
    }
        if (m_currentMode == "delete_recent") {
        emit translationComplete("Recent translations deleted successfully.");  // Emit a success message and i can remove the line "Recent translations deleted successfully."
    } else if (m_currentMode == "recent") {
        // Existing logic for processing recent translations
    } else {
        emit translationComplete(output.trimmed());
    }
}
