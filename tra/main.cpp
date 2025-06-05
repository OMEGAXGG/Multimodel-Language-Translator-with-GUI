#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtDebug>
#include "translator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qputenv("QT_LOGGING_RULES", "qt.qml*=true"); // Enables QML logging
    QQmlApplicationEngine engine;

    Translator translator;
    engine.rootContext()->setContextProperty("translator", &translator);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
