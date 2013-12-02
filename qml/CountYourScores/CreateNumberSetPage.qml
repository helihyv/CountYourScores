/**************************************************************************
**  CreateNumberSePaget.qml (of CountYourScores)
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
**  CreateNumberSetPage 2.12.2013
**************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import Sailfish.Silica 1.0
import countyourscores 1.2

Page
{
//    tools: commonTools

    property bool editing : false

    property string numbersetToEdit




    onStatusChanged:
    {

        if (status == PageStatus.Activating)
        {

            //Clear previous data
            for (var i = 0; i < 15; i++)
            {
                newNumbersRepeater.itemAt(i).text = ""
            }


            //Get the edited set
            if (editing == true)
            {
                editedModel.switchToNumberSet(numbersetToEdit)



                for (var i = 0; i < editedModel.rowCount() && i < 15; i++)
                {
                    newNumbersRepeater.itemAt(i).text = editedModel.getValueAt(i)
                }

                nameField.text = numbersetToEdit

            }

            //Clear the name field for a new set
            else
            {
                nameField.text = ""
            }
        }

    }

    ReplaceableIntegerListModel
    {
        id: editedModel
//        property int count: 0


    }


    PageHeader
    {
        id: headerItem
        title: "CountYourScores"
    }


    TextField
    {
        id: nameField
        placeholderText: "Name of the number set"
//        inputMask: "x"
        validator: RegExpValidator {regExp: /.+/}
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Theme.paddingLarge
        anchors.rightMargin: Theme.paddingLarge
        anchors.top: headerItem.bottom

    }




    Grid
    {
        id: newNumbersColumn

        anchors.top: nameField.bottom
        anchors.topMargin: Theme.paddingMedium
        anchors.horizontalCenter: parent.horizontalCenter


        columns: isPortrait ? 3 : 4



        Repeater
        {

        id: newNumbersRepeater

        model: 15

        TextField
            {
                inputMethodHints: Qt.ImhDigitsOnly
                validator: IntValidator{}
                placeholderText: "Number " + (index +1)
                width: Theme.itemSizeExtraLarge
            }


        }

    }

    Button
    {
        id: saveButton
        anchors.top: newNumbersColumn.bottom
        anchors.topMargin: Theme.paddingMedium
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
                remorse.execute("A number set with the name " + nameField.text + " already exists. Overwriting",saveSet())

            }

            else if (nameField.text == "")
            {
                nameIsObligatoryDialog.open()
            }

            else saveSet()

        }
    }

    SettingsHandler
    {
        id: settingsHandler
    }


    RemorsePopup
    {
        id: remorse
    }

//    QueryDialog
//    {
//        id: defaultNotAllowedInformationDialog

//        titleText: "Cannot use the name \"default\""

//        message: "The default numberset cannot be changed. Use another name."

//        acceptButtonText: "OK"
//    }

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
        settingsHandler.saveCurrentSet(nameField.text) // ...and save the current set to settings

        nameField.text = ""

        pageStack.pop(null) //Go back to main page

    }


//    QueryDialog
//    {
//        id: nameIsObligatoryDialog

//        titleText: "The number set has no name"

//        message: "Give your number set a name before saving it."

//        acceptButtonText: "OK"
//    }
}


