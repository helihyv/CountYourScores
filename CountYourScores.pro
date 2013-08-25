# The name of your app
TARGET =CountYourScores


SOURCES += main.cpp \
    replaceableintegerlistmodel.cpp \
    settingshandler.cpp




OTHER_FILES += \
    rpm/CountYourScores.yaml \
    rpm/CountYourScores.spec \
#    CountYourScoresSplashscreenPortrait.png \
#    CountYourScoresSplashscreenLandscape.png
    qml/CountYourScores/SettingsPage.qml \
    qml/CountYourScores/MainPage.qml \
    qml/CountYourScores/main.qml \
    qml/CountYourScores/CreateNumberSetPage.qml \
    qml/CountYourScores/AboutPage.qml

HEADERS += \
    replaceableintegerlistmodel.h \
    settingshandler.h

# QML files and folders
#qml.files = *.qml pages cover main.qml
#qml.files = *.qml
qml.files = *.qml qml/CountYourScores/*.qml

# The .desktop file
desktop.files = CountYourScores.desktop


include(sailfishapplication/sailfishapplication.pri)
