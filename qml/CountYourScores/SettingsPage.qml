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
**  SettingsPage 1.3.2013
**************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
import org.maemo.fremantle 1.0
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

            numberSetNamesModel.populate(true)
            numberSetNamesModel.count = numberSetNamesModel.rowCount()

            numberSetNamesModel.populate(true)
            numberSetNamesModel.count = numberSetNamesModel.rowCount()

            selectSetToBeEditedModel.populate(false) //Populating the model with data. NEEDS to be done TWICE in order to SelectionDialog to show the data.
            selectSetToBeEditedModel.count = selectSetToBeEditedModel.rowCount()

            selectSetToBeDeletedModel.populate(false) //Populating the model with data. NEEDS to be done TWICE in order to SelectionDialog to show the data.
            selectSetToBeDeletedModel.count = selectSetToBeEditedModel.rowCount()

        }

    }


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

        titleText: qsTr("Choose the set to use")

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
            selectSetToBeEditedModel.populate(false)
            selectSetToBeEditedModel.count = selectSetToBeEditedModel.rowCount()

            selectSetToBeEditedDialog.open()



        }
    }


    NumberSetNamesModel
    {
        id: selectSetToBeEditedModel
        property int count: 0
    }

    SelectionDialog
    {
        id: selectSetToBeEditedDialog
        model: selectSetToBeEditedModel

        titleText: qsTr("Choose the set to edit")

        onAccepted:
        {
            createNumberSetPage.editing = true
            createNumberSetPage.numbersetToEdit = selectSetToBeEditedModel.getString(selectedIndex)
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
            selectSetToBeDeletedModel.populate(false)
            selectSetToBeDeletedModel.count = selectSetToBeDeletedModel.rowCount

            selectSetToBeDeletedDialog.open()
        }
    }

    NumberSetNamesModel
    {
        id: selectSetToBeDeletedModel
        property int count: 0
    }

    SelectionDialog
    {
        id: selectSetToBeDeletedDialog
        model: selectSetToBeDeletedModel

        titleText: qsTr("Choose the set to delete")

        onAccepted:
        {
            confirmDeleteSetDialog.open()
        }
    }

    QueryDialog
    {
        id: confirmDeleteSetDialog

        titleText: "Confirm delete set"

        message: "Do you really wish to delete the number set " + selectSetToBeDeletedModel.getString(selectSetToBeDeletedDialog.selectedIndex) +"?"

        acceptButtonText: "Yes"

        rejectButtonText: "No"

        onAccepted:
        {

            //If the set to be deleted was in use, switch to the default set.

            if (selectSetToBeDeletedModel.getString(selectSetToBeDeletedDialog.selectedIndex) == settingsHandler.currentSet())
            {
                mainPage.changeNumberSet("default")
            }

            //Delete set

            settingsHandler.removeSet(selectSetToBeDeletedModel.getString(selectSetToBeDeletedDialog.selectedIndex))

            numberSetNamesModel.populate(true) //refresh select model
            selectSetToBeEditedModel.populate(false) //refresh edit model
            selectSetToBeDeletedModel.populate(false) //refresh delete model


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
