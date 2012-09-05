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
**  main.cpp 5.9.2012
**************************************************************************/

#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>
#include "replaceableintegerlistmodel.h"
#include "settingshandler.h"
#include "numbersetnamesmodel.h"

//#include <QDebug>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    app->setApplicationName("CountYourScores");
    app->setOrganizationName("CountYourScores");

   qmlRegisterType<ReplaceableIntegerListModel> ("countyourscores",0,1,"ReplaceableIntegerListModel");  
   qmlRegisterType<SettingsHandler> ("countyourscores",0,1,"SettingsHandler");
   qmlRegisterType<NumberSetNamesModel> ("countyourscores",0,1,"NumberSetNamesModel");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/CountYourScores/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
