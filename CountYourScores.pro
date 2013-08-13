# Add more folders to ship with the application, here
folder_01.source = qml/CountYourScores
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =


# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable



# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    replaceableintegerlistmodel.cpp \
    settingshandler.cpp


include(sailfishapplication/sailfishapplication.pri)

OTHER_FILES += \
    rpm/CountYourScores.yaml \
    rpm/CountYourScores.spec \
    CountYourScoresSplashscreenPortrait.png \
    CountYourScoresSplashscreenLandscape.png

HEADERS += \
    replaceableintegerlistmodel.h \
    settingshandler.h

splash.files = CountYourScoresSplashscreenLandscape.png
splash.files += CountYourScoresSplashscreenPortrait.png
splash.path = /opt/CountYourScores/images
INSTALLS += splash
