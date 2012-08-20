
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

ReplaceableIntegerListModel::ReplaceableIntegerListModel(QObject *parent) :
    QAbstractListModel(parent)
{
    //Testcode

    values_.append(1);
    values_.append(2);
    values_.append(3);


    values_.append(4);
    values_.append(5);
    values_.append(6);


    values_.append(7);
    values_.append(8);
    values_.append(9);

    values_.append(10);
    values_.append(20);
    values_.append(25);

    values_.append(50);
    values_.append(75);
    values_.append(100);

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
