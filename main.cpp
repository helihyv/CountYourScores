#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>
#include "replaceableintegerlistmodel.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));


    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/CountYourScores/main.qml"));

    qmlRegisterType<ReplaceableIntegerListModel> ("countyourscores",0,1,"ReplaceableIntegerListModel");


    viewer.showExpanded();

    return app->exec();
}
