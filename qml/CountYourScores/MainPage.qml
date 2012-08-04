import QtQuick 1.1
import com.nokia.meego 1.0
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
                    onClicked: currentPlayer = index+1
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
        anchors.bottom: parent.bottom
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
                text: display
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
            }

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onClicked:
                {


                    scoresModel.get(4*(games-1) + currentPlayer-1).score += display



                    totalScoreRepeater.itemAt(currentPlayer-1).totalScore += display
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
}
