/**************************************************************************
**  numbersetnamesmodel.h (of Suova)
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
**  NumberSetNamesModel 21.2.2013
**************************************************************************/

#ifndef NUMBERSETNAMESMODEL_H
#define NUMBERSETNAMESMODEL_H

#include <QStringListModel>

class NumberSetNamesModel : public QStringListModel
{
    Q_OBJECT
public:
    explicit NumberSetNamesModel(QObject *parent = 0);

    Q_INVOKABLE int rowCount(const QModelIndex &parent= QModelIndex()) const; //Re-implemented  just to add Q_INVOKABLE

    QVariant data(const QModelIndex &index, int role) const;

    Q_INVOKABLE QString getString(int index);

    Q_INVOKABLE int indexOfCurrentSet();
    
signals:
    
public slots:

    void populate(bool includeDefault);


    
};

#endif // NUMBERSETNAMESMODEL_H
