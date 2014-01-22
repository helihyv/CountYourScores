# The name of your app
TARGET =harbour-countyourscores

CONFIG  += sailfishapp

SOURCES += main.cpp \
    replaceableintegerlistmodel.cpp \
    settingshandler.cpp




OTHER_FILES += \
    rpm/harbour-countyourscores.yaml \
    rpm/harbour-countyourscores.spec \
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




