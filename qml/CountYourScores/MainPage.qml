import QtQuick 1.1
import com.nokia.meego 1.1
import countyourscores 0.1

Page {
    tools: commonTools

    property int currentPlayer: 1
    property int games: 1

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
                color: (index+1 == currentPlayer) ? "red" : "black"

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
            player: 1
        }

        ListElement
        {
            score: 0
            player: 2
        }

        ListElement
        {
            score: 0
            player: 3
        }

        ListElement
        {
            score: 0
            player: 4
        }
    }


//    Row
//    {
//        id: scores
//        anchors.top: players.bottom
//        spacing: 40


        Column
        {
            id: gameTexts
            anchors.top: players.bottom
            anchors.left: parent.left
//            anchors.right: parent.right
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

//        Rectangle
//        {
//            anchors.top: players.bottom
//            anchors.left: parent.left
//            anchors.right: parent.right
        GridView
        {
//              anchors.fill: parent

            anchors.top: players.bottom
            anchors.left: gameTexts.right
            anchors.right: parent.right
            anchors.bottom: totalScores.top
            id: scoreView

            cellHeight: 30
            cellWidth: 95

            model: scoresModel

            delegate: Label
            {

                width: 100
                text: score
            }

        }
//        }
//    }

    Row
    {
        id: totalScores
                anchors.verticalCenter: parent.verticalCenter
//        anchors.top: scoreView.bottom

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
                width: 100
                text: totalScore
            }
        }
    }

    Button
    {
        id: addGameButton
        anchors.top: totalScores.bottom

        text: "Add game"
        onClicked:
        {
            games++
            if (games >8)
                enabled = false

            scoresModel.append({"score": 0,"player": 1})
            scoresModel.append({"score": 0,"player": 2})
            scoresModel.append({"score": 0,"player": 3})
            scoresModel.append({"score": 0,"player": 4})

            addedModel.clear()

        }
    }

    ReplaceableIntegerListModel
    {
        id: numbersList
    }


    GridView
    {
//        anchors.fill: parent
        anchors.top: appWindow.inPortrait ? addGameButton.bottom : parent.top
        anchors.topMargin: 20
        anchors.bottom: addedView.top
//        anchors.top: parent.verticalCenter
        anchors.left: appWindow.inPortrait ? parent.left : players.right
        anchors.right: parent.right
//        anchors.horizontalCenter: parent.horizontalCenter
        model: numbersList
        delegate: Rectangle
        {
            width: 100
            height:100
            border.width: 1

            Label
            {
                anchors.fill: parent
                text: display
                font.pointSize: 64
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
                }

                onPressed:
                {
                    parent.color = "red"
                }

                onReleased:
                {
                    parent.color = "white"
                }

                onExited:
                {
                    parent.color = "white"
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
        anchors.right: parent.right
        model: addedModel
        orientation: ListView.Horizontal

        delegate: Label
            {
                text: number
                width: 50
            }

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

}
