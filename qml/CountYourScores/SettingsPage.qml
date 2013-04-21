/**************************************************************************
**  SettingsPage.qml (of CountYourScores)
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
**  SettingsPage 21.4.2013
**************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
import org.maemo.fremantle 1.0
import countyourscores 1.0

Page
{
    tools: commonTools

    Button
    {
        id: selectNumberSetButton
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter:  parent.horizontalCenter
        anchors.horizontalCenterOffset: appWindow.inPortrait ? 0 : -200
        text: qsTr("Select a number set")

        onClicked:
        {
            getSetNames(true) //include "default" in the set name list
            numberSetDialog.selectedIndex = 0
            numberSetDialog.open()
            numberSetDialog.selectedIndex = numberSetNamesModel.indexOfCurrentSet
        }
    }

    function getSetNames(includeDefault)
    {
        var names = settingsHandler.setNames(includeDefault)
        var currentSet = settingsHandler.currentSet()

        numberSetNamesModel.clear()

         //Choose the first item here to make sure there will be a "current" item, as no item selected causes the first item to disappear
        if (!names.length)
        {
           numberSetNamesModel.indexOfCurrentSet = 0
        }
        //fill the ListModel with the obtained set names

        for (var i = 0; i < names.length; i++)
        {
//            console.debug(names[i])

            numberSetNamesModel.append({"name" : names[i]})

            if (names[i] == currentSet)
            {
                //If the set is in use, mark it as current in order to be selected by the dialog needing it
                numberSetNamesModel.indexOfCurrentSet = i
            }


        }

    }

    ListModel
    {
        id: numberSetNamesModel

        property int indexOfCurrentSet: 0
    }



    SelectionDialog
    {
        id: numberSetDialog

        model: numberSetNamesModel

        titleText: qsTr("Choose the set to use")

        selectedIndex: 0

        onAccepted:
        {
            mainPage.changeNumberSet(numberSetNamesModel.get(selectedIndex).name)
            settingsHandler.saveCurrentSet(numberSetNamesModel.get(selectedIndex).name)

        }
   }


    Button
    {
        id: addButton
        text: qsTr("Add a new numberset")

        anchors.top: selectNumberSetButton.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: selectNumberSetButton.horizontalCenter

        onClicked:
        {
            createNumberSetPage.editing = false
            pageStack.push(createNumberSetPage)
        }
    }



    Button
    {
        id: editButton
        text: qsTr("Edit a numberset")

        anchors.top: addButton.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: addButton.horizontalCenter

        onClicked:
        {
            getSetNames(false) //do not add "default" as it cannot be edited

            selectSetToBeEditedDialog.selectedIndex = 0
            selectSetToBeEditedDialog.open()
            selectSetToBeEditedDialog.selectedIndex = numberSetNamesModel.indexOfCurrentSet
        }
    }



    SelectionDialog
    {
        id: selectSetToBeEditedDialog
        model: numberSetNamesModel
        titleText: qsTr("Choose the set to edit")

        onAccepted:
        {
            createNumberSetPage.editing = true
            createNumberSetPage.numbersetToEdit = numberSetNamesModel.get(selectedIndex).name
            pageStack.push(createNumberSetPage)
        }
    }

    Button
    {
        id: deleteButton
        text: qsTr("Delete a numberset")

        anchors.top: editButton.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: editButton.horizontalCenter

        onClicked:
        {
            getSetNames(false) //do not add "default" as it cannot be deleted

            selectSetToBeDeletedDialog.selectedIndex = 0
            selectSetToBeDeletedDialog.open()
            selectSetToBeDeletedDialog.selectedIndex = numberSetNamesModel.indexOfCurrentSet
        }
    }


    SelectionDialog
    {
        id: selectSetToBeDeletedDialog
        model: numberSetNamesModel

        titleText: qsTr("Choose the set to delete")

        onAccepted:
        {
            confirmDeleteSetDialog.message = "Do you really wish to delete the number set " + numberSetNamesModel.get(selectSetToBeDeletedDialog.selectedIndex).name +"?"
            confirmDeleteSetDialog.open()
        }
    }

    QueryDialog
    {
        id: confirmDeleteSetDialog

        titleText: "Confirm delete set"

//        message: "Do you really wish to delete the number set " + numberSetNamesModel.get(selectSetToBeDeletedDialog.selectedIndex).name +"?"

        acceptButtonText: "Yes"

        rejectButtonText: "No"

        onAccepted:
        {

            //If the set to be deleted was in use, switch to the default set.

            if (numberSetNamesModel.get(selectSetToBeDeletedDialog.selectedIndex).name == settingsHandler.currentSet())
            {
                mainPage.changeNumberSet("default")

            }

            //Delete set

            settingsHandler.removeSet( numberSetNamesModel.get(selectSetToBeDeletedDialog.selectedIndex).name)

        }
    }


        Label
        {
            id: themeSwitchLabel
            text: qsTr("Black Theme ")
            font.bold: true
            anchors.top: appWindow.inPortrait ? deleteButton.bottom : parent.top
            anchors.topMargin: appWindow.inPortrait ? 50 : 30
            anchors.left: appWindow.inPortrait ? deleteButton.left : selectNumberSetButton.right
            anchors.leftMargin: appWindow.inPortrait ? 0 : 75
        }
        Switch
        {
            id: themeSwitch
            anchors.verticalCenter: themeSwitchLabel.verticalCenter
//            anchors.topMargin: 50
            anchors.right: appWindow.inPortrait ? deleteButton.right : parent.right
            anchors.rightMargin: appWindow.inPortrait ? 0 : 75

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
