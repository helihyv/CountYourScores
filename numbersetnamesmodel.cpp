/**************************************************************************
**  numbersetnamesmodel.cpp (of CountYourScores)
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
**  NumberSetNamesModel 21.2.2013
**************************************************************************/

#include "numbersetnamesmodel.h"
#include <QSettings>
#include <QDebug>


    const int nameRole = Qt::UserRole+1; //Needed by QML SelectionDialog

NumberSetNamesModel::NumberSetNamesModel(QObject *parent) :
    QStringListModel(parent)
{
    //Set the role needed by QML SelectionDialog element

    QHash<int, QByteArray> roles;
    roles[nameRole] = "name";
    setRoleNames(roles);

    //populating the model must be done later for the contents to show up in QML!

}

int NumberSetNamesModel::rowCount(const QModelIndex &parent) const
{
    //This function was reimplemented just to make it Q_INVOKABLE for QML use
//    qDebug("rowcount asked");
    return QStringListModel::rowCount(parent);
}

QVariant NumberSetNamesModel::data(const QModelIndex &index, int role) const
{
//    qDebug("Data asked");

    // give displayrole if namerole asked (QML SelectionDialog wants namerole)
    if (role == nameRole)
        return QStringListModel::data(index, Qt::DisplayRole);

    //Otherwise busines as usual...

    return QStringListModel::data(index,role);
}

QString NumberSetNamesModel::getString(int index)
{
    return data(createIndex(index,0),nameRole).toString();
}

int NumberSetNamesModel::indexOfCurrentSet()
{
    QSettings settings;


    qDebug() << stringList().indexOf(settings.value("CurrentSet","default").toString()) << "Visited indexofcurrentset";

    return stringList().indexOf(settings.value("CurrentSet","default").toString());
    //returns -1 if not found, which should never happen unless the conf file has been messed up by hand-editing
    //-1 is the value for "nothing selected" in QML SelectionDialog, so this behaviour OK
}

void NumberSetNamesModel::populate(bool includeDefault)
{

    //populate the model

    QSettings settings;

    settings.beginGroup("sets"); //get only the keys for sets, not for other settings
    QStringList sets = settings.allKeys();

    if (includeDefault)
    {
        sets.prepend("default"); //add the built-in number set
    }
//    sets.append("Testing!!!");

    setStringList(sets);

//    qDebug() << data(createIndex(0,0),nameRole).toString() ;
}
