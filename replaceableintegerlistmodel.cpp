
/**************************************************************************
**  replaceableintegerlistmodel.cpp of CountYourScores
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
**  ReplaceableIntegerListModel 19.8.2012
**************************************************************************/

#include "replaceableintegerlistmodel.h"
#include <QSettings>
//#include <QList>
#include <QDebug>

ReplaceableIntegerListModel::ReplaceableIntegerListModel(QObject *parent) :
    QAbstractListModel(parent)
{
    //Testcode

    defaultValues_.append(1);
    defaultValues_.append(2);
    defaultValues_.append(3);


    defaultValues_.append(4);
    defaultValues_.append(5);
    defaultValues_.append(6);


    defaultValues_.append(7);
    defaultValues_.append(8);
    defaultValues_.append(9);

    defaultValues_.append(10);
    defaultValues_.append(20);
    defaultValues_.append(25);

    defaultValues_.append(50);
    defaultValues_.append(75);
    defaultValues_.append(100);

    QSettings settings;

    QString currentSet = settings.value("currentset","default").toString();

    switchToNumberSet(currentSet);


}

int ReplaceableIntegerListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;   //No item in a list model has children

    return values_.count();

}

QVariant ReplaceableIntegerListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role)
    {
        case Qt::DisplayRole:
        case Qt::EditRole:
        case Qt::AccessibleTextRole:

            return values_.at(index.row());

        default:

            return QVariant();

    }
}

QStringList ReplaceableIntegerListModel::getSetNames()
{
    QSettings settings;

    settings.beginGroup("sets"); //get only the keys for sets, not for other settings
    QStringList sets = settings.allKeys();

    sets.prepend("default"); //add the built-in number set

    return sets;

}

void ReplaceableIntegerListModel::switchToNumberSet(QString set)
{

    beginResetModel();

//    qDebug() << "Starting to reset the model";
    if (set == "default")
        values_ = defaultValues_;

    else
    {


        values_.clear();

        QSettings settings;
        settings.beginGroup("sets");

        QList<QVariant> list = settings.value(set).toList();

        //convert QVariant list to integer list and set it as used list

        QVariant number;
        foreach (number, list)
        {
            values_.append(number.toInt());
        }


    }

    endResetModel();

//    qDebug() << ("Finished resetting the model");


}

void ReplaceableIntegerListModel::saveSet(QString name, QList<int> numbers)
{

    //convert integer list to QVariant list for saving

    QList<QVariant> numbersList;
    int number;

    foreach (number,numbers)
    {
        numbersList.append(number);
    }

    //save the list

    QSettings settings;
    settings.beginGroup("sets");

    settings.setValue(name,numbersList);

}
