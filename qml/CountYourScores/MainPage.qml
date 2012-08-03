import QtQuick 1.1
import com.nokia.meego 1.0
import countyourscores 0.1

Page {
    tools: commonTools

    property int currentPlayer: 1

    Row
    {
        id: players

        anchors.top: parent.top

        Rectangle
        {
            width: 100 //Placeholder for right positioning
        }

        Repeater
        {
            model: 4
        Label
            {
                width: 100
                height: 50
                text: "Player " + (index+1)
                color: (index+1 == currentPlayer) ? "red" : "black"

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: currentPlayer = index+1
                }
            }
        }

    }

    Row
    {
        id: scores
        anchors.top: players.bottom
//        spacing: 40


        Column
        {
            Repeater
            {
                model: 4

                Label
                {
                    width: 100
                    text: "Game " + (index+1)
                }
            }


        }

        Grid
        {


        Repeater

        {
            id: scoreRepeater
            model: 16

            Label
            {
                property int score: 0
                width: 100
                text: score
            }
        }
        }
    }

    Row
    {
        id: totalScores
        anchors.top: scores.bottom

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
                property int totalScore
                width: 100
                text: totalScore
            }
        }
    }


    ReplaceableIntegerListModel
    {
        id: numbersList
    }


    GridView
    {
//        anchors.fill: parent
        anchors.top: totalScores.bottom
        anchors.bottom: parent.bottom
//        anchors.top: parent.verticalCenter
        anchors.left: parent.left
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
                onPressed:
                {

                    parent.color = "red"
                    scoreRepeater.itemAt(currentPlayer-1).score += display
                }


            }

        }
    }
}
