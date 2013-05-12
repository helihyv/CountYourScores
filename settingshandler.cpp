/**************************************************************************
**  settingshandler.cpp (of CountYourScores)
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
**  SettingsHandler 20.5.2013
**************************************************************************/

#include "settingshandler.h"
#include <QSettings>


SettingsHandler::SettingsHandler(QObject *parent) :
    QObject(parent)
{
}

bool SettingsHandler::setNameExists(QString name)
{

    QSettings settings;

    settings.beginGroup("sets"); //get only the keys for sets, not for other settings
    QStringList sets = settings.allKeys();

    return sets.contains(name);

}

bool SettingsHandler::isBlackThemeOn()
{
    QSettings settings;

    return settings.value("BlackThemeOn", false).toBool(); //defaults to white theme if no user setting
}

QString SettingsHandler::currentSet()
{
    QSettings settings;

    return settings.value("CurrentSet","default").toString();
}

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

void SettingsHandler::setBlackTheme(bool on)
{
    QSettings settings;

    settings.setValue("BlackThemeOn", on);
}

void SettingsHandler::saveCurrentSet(QString setName)
{
    QSettings settings;

    settings.setValue("CurrentSet",setName);
}

void SettingsHandler::removeSet(QString name)
{
    //Delete set

    QSettings settings;

    settings.beginGroup("sets");

    if(!name.isEmpty())
    {

        settings.remove(name);
    }

    else //empty string on remove will delete *all* keys in th group
    {
    //move other sets to safe

       QSettings::SettingsMap sets;

        QStringList names = setNames(false);

        QString safegoerName;

        foreach (safegoerName,names)
        {
            //copy sets that do not have empty name to safe place

            if (!safegoerName.isEmpty())
            sets.insert(safegoerName,settings.value(safegoerName));
        }

        settings.remove(""); //delete *all* sets from settings

        //copy back to settings from the safe place

        QString toBeRestoredSet;

        foreach (toBeRestoredSet, sets.keys())
        {
            settings.setValue(toBeRestoredSet,sets.value(toBeRestoredSet));
        }

    }

}


QStringList SettingsHandler::setNames(bool includeDefault)
{
    QSettings settings;

    settings.beginGroup("sets"); //get only the keys for sets, not for other settings
    QStringList sets = settings.allKeys();

    if (includeDefault)
    {
        sets.prepend("default"); //add the built-in number set
    }
//    sets.append("Testing!!!");

    return (sets);

//    qDebug() << data(createIndex(0,0),nameRole).toString() ;
}
