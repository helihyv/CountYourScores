/**************************************************************************
**  replaceableintegerlistmodel.h of CountYourScores
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

#ifndef REPLACEABLEINTEGERLISTMODEL_H
#define REPLACEABLEINTEGERLISTMODEL_H

#include <QAbstractListModel>
#include <QStringList>

class ReplaceableIntegerListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ReplaceableIntegerListModel(QObject *parent = 0);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role) const;

    Q_INVOKABLE QStringList getSetNames();

    
signals:
    
public slots:

    void switchToNumberSet(QString set);


protected:

    QList<int> values_;
    QList<int> defaultValues_;
    
};

#endif // REPLACEABLEINTEGERLISTMODEL_H
