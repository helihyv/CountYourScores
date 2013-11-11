/**************************************************************************
**  main.cpp of CountYourScores
**  Copyright (c) 2012–2013 Heli Hyvättinen
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
**  main.cpp 11.11.2013
**************************************************************************/

#include <QGuiApplication>
#include <QQuickView>

#include <QtQml>

#include "replaceableintegerlistmodel.h"
#include "settingshandler.h"

#include <sailfishapp.h>

//#include <QDebug>

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));

    app->setApplicationName("CountYourScores");
    app->setOrganizationName("CountYourScores");

   qmlRegisterType<ReplaceableIntegerListModel> ("countyourscores",1,2,"ReplaceableIntegerListModel");
   qmlRegisterType<SettingsHandler> ("countyourscores",1,2,"SettingsHandler");

   QScopedPointer<QQuickView> view(SailfishApp::createView());
   view.data()->setSource(/*"main.qml"*/ SailfishApp::pathTo("qml/main.qml") );



   view.data()->show();

    return app->exec();
}
