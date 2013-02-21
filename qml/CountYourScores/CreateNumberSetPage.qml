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
**  CreateNumberSetPage 21.2.2013
**************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
import org.maemo.fremantle 1.0
import countyourscores 0.1

Page
{
    tools: commonTools

    property bool editing : false

    property string numbersetToEdit


    onStatusChanged:
    {

        if (status == PageStatus.Activating)
        {
            if (editing == true)
            {
//                nameField.text =
            }
        }

    }

    Column
    {
        id: nameColumn
        anchors.horizontalCenter: parent.horizontalCenter


        TextField
        {
            id: nameField
            placeholderText: "Name of the number set"
            width: 300

        }
    }



    Grid
    {
        id: newNumbersColumn

        anchors.top: nameColumn.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter


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

            if (nameField.text == "default")
            {
                defaultNotAllowedInformationDialog.open()
            }
            else if (settingsHandler.setNameExists(nameField.text))
            {
                confirmOverwriteDialog.open()

            }

            else saveSet()

        }
    }

    SettingsHandler
    {
        id: settingsHandler
    }

    QueryDialog
    {
        id: confirmOverwriteDialog

        titleText: "Confirm overwrite?"

        message: "A number set with the name " + nameField.text + " already exists. Do you wish to overwrite it?"

        acceptButtonText: "Yes"

        rejectButtonText: "No"

        onAccepted:
        {
            saveSet()
        }
    }

    QueryDialog
    {
        id: defaultNotAllowedInformationDialog

        titleText: "Cannot use the name \"default\""

        message: "The default numberset cannot be changed. Use another name."

        acceptButtonText: "OK"
    }

    function saveSet()
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
                newNumbersRepeater.itemAt(i).text = "" //clear the numbers

            }
        }
        settingsHandler.finishSet(nameField.text)

        mainPage.changeNumberSet(nameField.text) //automatically take the newly created set into use

        nameField.text = ""

        pageStack.pop(null) //Go back to main page

    }
}


