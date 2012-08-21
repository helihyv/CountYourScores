/**************************************************************************
**  numbersetmodel.h (of Suova)
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
**  NumberSetModel 21.8.2012
**************************************************************************/

#ifndef NUMBERSETMODEL_H
#define NUMBERSETMODEL_H

#include <QStringListModel>

class NumberSetModel : public QStringListModel
{
    Q_OBJECT
public:
    explicit NumberSetModel(QObject *parent = 0);
    
signals:
    
public slots:
    
};

#endif // NUMBERSETMODEL_H
