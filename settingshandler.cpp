/**************************************************************************
**  settingshandler.cpp (of CountYourScores)
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

#include "settingshandler.h"
#include <QSettings>


SettingsHandler::SettingsHandler(QObject *parent) :
    QObject(parent)
{
}

//QStringList SettingsHandler::getSetNames()
//{
//    QSettings settings;

//    settings.beginGroup("sets"); //get only the keys for sets, not for other settings
//    QStringList sets = settings.allKeys();

//    sets.prepend("default"); //add the built-in number set

//    return sets;

//}

void SettingsHandler::saveSet(QString name, QList<int> numbers)
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

void SettingsHandler::startSet()
{
    numberSet_.clear();
}

void SettingsHandler::addNumbertoSet(int number)
{
    numberSet_.append(number);
}

void SettingsHandler::finishSet(QString name)
{
    saveSet(name,numberSet_);
}
