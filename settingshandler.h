/**************************************************************************
**  settingshandler.h (of Suova)
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
**  SettingsHandler 21.8.2012
**************************************************************************/

#ifndef SETTINGSHANDLER_H
#define SETTINGSHANDLER_H

#include <QObject>
#include <QStringList>

class SettingsHandler : public QObject
{
    Q_OBJECT
public:
    explicit SettingsHandler(QObject *parent = 0);

//        Q_INVOKABLE QStringList getSetNames();
    
    Q_INVOKABLE bool setNameExists(QString name);
signals:
    
public slots:

        void saveSet(QString name, QList<int> numbers);

        void startSet();

        void addNumbertoSet(int number);

        void finishSet(QString name);

private:

    QList<int> numberSet_;
    
};

#endif // SETTINGSHANDLER_H
