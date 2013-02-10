/**************************************************************************
**  SettingsPage.qml (of CountYourScores)
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
**  SettingsPage 21.8.2012
**************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import countyourscores 0.1

Page
{
    tools: commonTools

    property variant sets

    onStatusChanged:
    {

        if (status == PageStatus.Activating)
        {
            //Populating the model with data. NEEDS to be done TWICE in order to SelectionDialog to show the data.

            numberSetNamesModel.populate()
            numberSetNamesModel.count = numberSetNamesModel.rowCount()

            numberSetNamesModel.populate()
            numberSetNamesModel.count = numberSetNamesModel.rowCount()
        }

    }


    Button
    {
        id: selectNumberSetButton
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Select a number set")

        onClicked:
        {
            numberSetDialog.open()
        }
    }

    NumberSetNamesModel
    {
        id: numberSetNamesModel
        property int count: 0


    }

    SelectionDialog
    {
        id: numberSetDialog

        model: numberSetNamesModel

        titleText: qsTr("Choose the number list")

        selectedIndex: 0

        onAccepted:
        {
            mainPage.changeNumberSet(numberSetNamesModel.getString(selectedIndex))
            settingsHandler.saveCurrentSet(numberSetNamesModel.getString(selectedIndex))
        }
   }


    Button
    {
        id: addButton
        text: "Add a new numberset"

        anchors.top: selectNumberSetButton.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        onClicked:
        {
            pageStack.push(createNumberSetPage)
        }
    }



        Label
        {
            id: themeSwitchLabel
            text: "Black Theme "
            font.bold: true
            anchors.top: addButton.bottom
            anchors.topMargin: 50
            anchors.left: addButton.left
        }
        Switch
        {
            id: themeSwitch
            anchors.top: addButton.bottom
            anchors.topMargin: 50
            anchors.right: addButton.right

            Component.onCompleted:
            {
                checked = settingsHandler.isBlackThemeOn()
            }

            onCheckedChanged:
            {
                theme.inverted = checked
                settingsHandler.setBlackTheme(checked)
            }
        }


    SettingsHandler
    {
        id: settingsHandler
    }

}
