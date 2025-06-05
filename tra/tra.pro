QT += quick quickcontrols2 widgets
CONFIG += c++11
QT += core gui qml quick
QT += quick multimedia
QT += multimedia
SOURCES += \
    $$PWD/main.cpp \
    $$PWD/translator.cpp

HEADERS += \
    $$PWD/translator.h

RESOURCES += \
    $$PWD/qml.qrc

OTHER_FILES += \
    $$PWD/main.qml \
    $$PWD/translator.py
    $$PWD/aiFacts.py

# Ensure that the qml.qrc file is created if it doesn't exist
!exists($$PWD/qml.qrc) {
    qrc_file = \
    "<RCC>\
        <qresource prefix=\"/\">\
            <file>main.qml</file>\
            <file>RecentTranslationsPage.qml</file>\
            <file>translator.py</file>\
            <file>aiFacts.py</file>\
        </qresource>\
    </RCC>"
    write_file($$PWD/qml.qrc, qrc_file)
    message("Created qml.qrc file")
}

TEMPLATE = app

DISTFILES += \
    Credits.qml \
    RecentTranslationsPage.qml \
    ReportPage.qml \
    aiFacts.py \
    database.py \
    detail.qml \
    main2.qml \
    translatorback.py

# Icon settings for Windows (.ico)
RC_ICONS = $$PWD/file.ico
