#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include <QObject>
#include <QProcess>
#include <QVariantList>  // To use QVariantList in signals


class Translator : public QObject
{
    Q_OBJECT

public:
    explicit Translator(QObject *parent = nullptr);

public slots:
    void translateText(const QString &text, const QString &fromLang, const QString &toLang);
    void translateSpeech(const QString &fromLang, const QString &toLang);
    void translateSpeechToSpeech(const QString &fromLang, const QString &toLang);
    void translateImage(const QString &imagePath, const QString &fromLang, const QString &toLang);
    void getRecentTranslations(int limit); // New public slot to get recent translations
    void deleteRecentTranslations(); // New public slot to delete recent translations

signals:
    void translationComplete(const QString &result);
    void speechToTextComplete(const QString &result);
    void speechToSpeechComplete(const QString &result);
    //void TextToSpeechComplete(const QString &result);
    void errorOccurred(const QString &error);
    void recentTranslationsReceived(const QVariantList &translations); // New signal to emit recent translations

private:
    QProcess m_process;
    QString m_currentMode;  // New variable to track the current operation mode
    QString m_targetLang;
    void runPythonScript(const QStringList &arguments);
    void processOutput(const QString &output); // To process the Python script output
};

#endif // TRANSLATOR_H
