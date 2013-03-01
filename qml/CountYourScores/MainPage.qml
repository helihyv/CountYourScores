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
**  MainPage 10.2.2013
**************************************************************************/

import QtQuick 1.0
import org.maemo.fremantle 1.0
import countyourscores 0.1

Page {
    tools: commonTools

    property int currentPlayer: 1
    property int games: 1
    property string highlightColor : theme.inverted ? "fuchsia" : "firebrick"





    Row
    {
        id: players

        anchors.top: parent.top

        Label
        {
            width: 100 //Placeholder for right positioning
            text: ""
        }

        Repeater
        {
            model: 4
        Label
            {
                width: 95
                height: 50
                text: "Player" + (index+1)
                color: (index+1 == currentPlayer) ? highlightColor : platformStyle.textColor

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
                    width: 100
                    height: 30
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

            cellHeight: 30
            cellWidth: 95

            model: scoresModel

            delegate: Label
            {

                width: 100
                text: score

                color: (index % 4) +1 == currentPlayer ? highlightColor : platformStyle.textColor

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
                anchors.verticalCenterOffset: appWindow.inPortrait ? 0 : 140


        Label
        {
            width: 100
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
                width: 95
                text: totalScore

                color: (index+1 == currentPlayer) ? highlightColor : platformStyle.textColor

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


    GridView
    {

        id: numbersView

//        anchors.fill: parent
        anchors.top: appWindow.inPortrait ? totalScores.bottom : parent.top
        anchors.topMargin: 20
        anchors.bottom: addedView.top
//        anchors.top: parent.verticalCenter
        anchors.left: appWindow.inPortrait ? parent.left : players.right
        anchors.right: parent.right
//        anchors.horizontalCenter: parent.horizontalCenter

        boundsBehavior: Flickable.StopAtBounds

        cellHeight: 95
        cellWidth: 95

        model: numbersList
        delegate: Rectangle
        {
            width: 95
            height:95
            border.width: 1
            color: theme.inverted ? "#1F1F1F" : "white"
            border.color: theme.inverted ? "white" : "black"

            Label
            {
                anchors.fill: parent
                text: display
                font.pointSize: 24
                font.bold: true
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
        height: 30
        anchors.left: parent.left
        anchors.right: appWindow.inPortrait ? parent.right : numbersView.left
        model: addedModel
        orientation: ListView.Horizontal

        boundsBehavior: Flickable.StopAtBounds

        delegate: Label
        {
            text: number + "  "

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
