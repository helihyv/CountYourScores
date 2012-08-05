#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>
#include "replaceableintegerlistmodel.h"
//#include <QDebug>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

   qmlRegisterType<ReplaceableIntegerListModel> ("countyourscores",0,1,"ReplaceableIntegerListModel");


    QmlApplicationViewer viewer;



#ifdef MEEGO_EDITION_HARMATTAN
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/CountYourScores/main.qml"));
    viewer.showExpanded();
#endif

#ifdef Q_WS_MAEMO_5
    viewer.setOrientation((QmlApplicationViewer::ScreenOrientationLockLandscape ));
    viewer.setMainQmlFile(QLatin1String("qml/CountYourScores/main.qml"));
    viewer.showFullScreen();
#endif



    return app->exec();
}
