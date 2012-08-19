/**************************************************************************
**  main.cpp of CountYourScores
**  Copyright (c) 2012 Heli Hyvättinen
**
**  This program is free software: you can redistribute it and/or modify
**  it under the terms of the GNU General Public License as published by
**  the Free Software Foundation, either version 3 of the License, or
**  (at your option) any later version.
**
**  This program is distributed in the hope that it will be useful,
**  but WITHOUT ANY WARRANTY; without even the implied warranty of
**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
**  GNU General Public License for more details.
**
**  See <http://www.gnu.org/licenses/>
**
**  main.cpp 19.8.2012
**************************************************************************/

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
