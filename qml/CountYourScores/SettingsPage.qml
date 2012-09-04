/**************************************************************************
**  MainPage.qml (of CountYourScores)
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
**  MainPage 21.8.2012
**************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import countyourscores 0.1

Page
{
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
   }

}
