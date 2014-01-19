/**************************************************************************
**  MainPage.qml (of CountYourScores)
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
**  MainPage 25.8.2013
**************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.countyourscores.modelsandsettings 1.2

Page {
    //    tools: commonTools

    property int currentPlayer: 1
    property int games: 1

    property int itemWidthInScoreGrid: Screen.width/5
    property int itemHeightInScoreGrid: Theme.itemSizeExtraSmall/2

    PageHeader      //This is just to provide nonmousearea space below PullDownMenu, since it does not seem to work in the emulator otherwise
    {
        id: pageTitle
        title: ""
    }

    SilicaFlickable
    {

        anchors.fill: parent
        contentHeight: childrenRect.height

        PullDownMenu
        {

            MenuItem
            {
                text: qsTr("About")
                onClicked: pageStack.push(aboutPage)
            }

            MenuItem
            {
                text: qsTr("Settings")
                onClicked: pageStack.push(settingsPage)
            }

            MenuItem
            {

                id: clearItem
                text: qsTr("Clear all scores")
                onClicked:
                {
                    remorse.execute(scoreView, "Clearing all scores", function () {clearScores(); addGameMenuItem.visible = true; } )

                }
            }

            MenuItem
            {
                id: addGameMenuItem
                text: qsTr("Next game")
                onClicked:
                {
                    addGame()
                    if (games > 8)
                    {
                        visible = false
//                        platformIconId = "toolbar-next-dimmed"
                    }
                }
            }

            MenuItem
            {
                text: "Undo"

                visible: addedModel.count > 0

                onClicked:
                {
                    undo()
                }
            }

            RemorseItem
            {
                id: remorse
            }






            //        ToolIcon
            //        {
            //            platformIconId: "toolbar-undo"
            //            visible: pageStack.currentPage == mainPage ? true : false
            //            onClicked:
            //            {
            //                mainPage.undo()
            //            }
            //        }

            //        ToolIcon

            //        {
//                        id: addGameIcon
            //            platformIconId: "toolbar-next"
            //            visible: pageStack.currentPage == mainPage ? true : false
            //            onClicked:
            //            {
            //                mainPage.addGame()
            //                if (mainPage.games > 8)
            //                {
            //                    enabled = false
            //                    platformIconId = "toolbar-next-dimmed"
            //                }
            //            }
            //        }

            //        ToolIcon
            //        {
            //            platformIconId: "toolbar-delete"
            //            visible: pageStack.currentPage == mainPage ? true : false
            //            onClicked:
            //            {
            //                mainPage.clearScores()
            //                addGameIcon.enabled = true
            //                addGameIcon.platformIconId = "toolbar-next"

            //            }
            //        }


        }
    }



    Row
    {
        id: players

        anchors.top: pageTitle.bottom

        Label
        {
            width: itemWidthInScoreGrid //Placeholder for right positioning
            text: ""
        }

        Repeater
        {
            model: 4
            Label
            {
                width: itemWidthInScoreGrid
//                height: Theme.ItemSizeSmall
                font.pixelSize: Theme.fontSizeSmall
                text: "Player" + (index+1)
                color: (index+1 == currentPlayer) ? Theme.highlightColor : Theme.primaryColor

                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        currentPlayer = index+1
                        addedModel.clear()
                    }
                }
            }
        }

    }

    ListModel
    {
        id: scoresModel

        ListElement
        {
            score: 0
        }

        ListElement
        {
            score: 0
        }

        ListElement
        {
            score: 0
        }

        ListElement
        {
            score: 0
        }
    }





    Column
    {
        id: gameTexts
        anchors.top: players.bottom
        anchors.left: parent.left
        anchors.bottom: totalScores.top


        Repeater
        {
            model: games

            Label
            {
                width: itemWidthInScoreGrid
                height: itemHeightInScoreGrid
                font.pixelSize: Theme.fontSizeSmall
                text: "Game " + (index+1)
            }
        }

    }


    GridView
    {

        anchors.top: players.bottom
        anchors.left: gameTexts.right
        anchors.right: appWindow.inPortrait ? parent.right : players.right
        anchors.bottom: totalScores.top
        id: scoreView

        boundsBehavior: Flickable.StopAtBounds

        cellHeight: itemHeightInScoreGrid
        cellWidth: itemWidthInScoreGrid

        model: scoresModel

        delegate: Label
        {

        width: itemWidthInScoreGrid
        height: itemHeightInScoreGrid
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Theme.fontSizeSmall
        text: score

        color: (index % 4) +1 == currentPlayer ? Theme.highlightColor : Theme.primaryColor

        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                currentPlayer = (index % 4) + 1
                addedModel.clear()
            }

        }
    }

}


Row
{
    id: totalScores
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: isPortrait ? 0 : 140


    Label
    {
        width: itemWidthInScoreGrid
        height: itemHeightInScoreGrid
        font.pixelSize: Theme.fontSizeSmall
        font.family: Theme.fontFamily //For unkown reason this does not work automatically here
        text: "Total"
    }

    Repeater
    {
        id: totalScoreRepeater
        model: 4

        Label
        {
            property int player: index +1
            property int totalScore: 0
            width: itemWidthInScoreGrid
            height: itemHeightInScoreGrid
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeSmall
            text: totalScore

            color: (index+1 == currentPlayer) ? Theme.highlightColor : Theme.primaryColor

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    currentPlayer = index+1
                    addedModel.clear()
                }
            }
        }
    }
}



ReplaceableIntegerListModel
{
    id: numbersList

    //        onModelAboutToBeReset:
    //        {
    //            console.debug("Model to be reset")
    //        }

    //        onModelReset:
    //            console.debug("Model has been reset")

    Component.onCompleted:
    {
        changeNumberSet( settingsHandler.currentSet() )


    }
}


ListModel
{
    id: testModel

    ListElement{
        name: "Test element"
        display: "Another test"
    }
}


SilicaGridView
{

    id: numbersView

    //        anchors.fill: parent
    //        anchors.top: appWindow.inPortrait ? totalScores.bottom : parent.top

    anchors.top : totalScores.bottom
    anchors.topMargin: 20
    anchors.bottom: addedView.top
    //        anchors.top: parent.verticalCenter
    //        anchors.left: appWindow.inPortrait ? parent.left : players.right

    anchors.left: parent.left
    anchors.right: parent.right
    //        anchors.horizontalCenter: parent.horizontalCenter

    boundsBehavior: Flickable.StopAtBounds

    cellHeight: itemWidthInScoreGrid
    cellWidth: itemWidthInScoreGrid

    model: numbersList
    //          model: testModel

    delegate: Rectangle
    {
    width: itemWidthInScoreGrid
    height:itemWidthInScoreGrid
    border.width: 1
    color: "transparent"
    border.color: Theme.primaryColor


    Label
    {
        anchors.fill: parent
        text: display
        font.pixelSize: Theme.fontSizeLarge
        font.bold: true
        color: Theme.highlightColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        onClicked:
        {


            scoresModel.get(4*(games-1) + currentPlayer-1).score += display



            totalScoreRepeater.itemAt(currentPlayer-1).totalScore += display

            addedModel.append({"number" : display})
            addedView.positionViewAtEnd ()
        }

    }

}
}

ListModel
{
    id: addedModel

}

ListView
{
    id: addedView
    anchors.bottom: parent.bottom
    height: Theme.itemSizeSmall
    anchors.left: parent.left
    anchors.right: isPortrait ? parent.right : numbersView.left
    model: addedModel
    orientation: ListView.Horizontal

    boundsBehavior: Flickable.StopAtBounds

    delegate: Label
    {

        font.pixelSize: Theme.fontSizeSmall
        text: number + "  "

    }
}



SettingsHandler
{
    id: settingsHandler
}

function clearScores()
{
    scoresModel.clear()
    for (var i = 0; i<4; i++)
    {
        scoresModel.append({"score" : 0})
        totalScoreRepeater.itemAt(i).totalScore = 0
    }
    games = 1
    addedModel.clear()


}

function undo()
{
    if (addedModel.count > 0)
    {
        scoresModel.get(4*(games-1) + currentPlayer-1).score -= addedModel.get(addedModel.count-1).number
        totalScoreRepeater.itemAt(currentPlayer-1).totalScore -= addedModel.get(addedModel.count-1).number
        addedModel.remove(addedModel.count-1)
    }
}

function addGame()
{
    games++
    //        if (games >8)
    //            commonTools. = false

    for (var i = 0; i<4; i++)
    {
        scoresModel.append({"score" : 0})
    }

    addedModel.clear()

}

function changeNumberSet(setName)
{
    numbersList.switchToNumberSet(setName)
}


}
