/**************************************************************************
**  CreateNumberSePaget.qml (of CountYourScores)
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
**  CreateNumberSetPage 30.8.2012
**************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import countyourscores 0.1

Page
{
    tools: commonTools

    Column
    {
        id: nameColumn
        anchors.horizontalCenter: parent.horizontalCenter

//        Label
//        {
//            text: "Name of the number set:"
//        }

        TextField
        {
            id: nameField
            placeholderText: "Name of the number set"
            width: 300

        }
    }

//    Label
//    {
//        anchors.top: nameColumn.bottom
//        anchors.topMargin: 30
//        anchors.horizontalCenter: parent.horizontalCenter

//        id: numbersHeading
//        text: "Numbers in pad:"
//    }

    Grid
    {
        id: newNumbersColumn

        anchors.top: nameColumn.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

//        anchors.left: parent.left
//        anchors.right: parent.right
        columns: appWindow.inPortrait ? 2 : 4

        Repeater
        {

        id: newNumbersRepeater

        model: 15

        TextField
            {
                inputMethodHints: Qt.ImhDigitsOnly
                validator: IntValidator{}
                placeholderText: "Number " + (index +1)
                width: 200
            }
        }

    }

    Button
    {
        id: saveButton
        anchors.top: newNumbersColumn.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        text: qsTr("Save")

        onClicked:
        {
            settingsHandler.startSet()
//            console.debug("clicked!")

            for (var i = 0; i < newNumbersRepeater.count; i++)
            {
//                console.debug(i)
//                console.debug(newNumbersRepeater.itemAt(i).text)
                if (newNumbersRepeater.itemAt(i).acceptableInput)
                {
                    settingsHandler.addNumbertoSet(newNumbersRepeater.itemAt(i).text)

                }
            }
            settingsHandler.finishSet(nameField.text)

        }
    }

    SettingsHandler
    {
        id: settingsHandler
    }
}


