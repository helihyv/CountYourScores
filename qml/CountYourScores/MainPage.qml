import QtQuick 1.1
import com.nokia.meego 1.0
import countyourscores 0.1

Page {
    tools: commonTools

    Row
    {
        id: players

        anchors.top: parent.top

        Repeater
        {
            model: 4
        Label
            {
                width: 100
                text: "Player " + (index+1)
            }
        }

    }

    Grid
    {
        id: scores
        anchors.top: players.bottom



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


    ReplaceableIntegerListModel
    {
        id: numbersList
    }


    GridView
    {
//        anchors.fill: parent
        anchors.top: scores.bottom
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
                    scoreRepeater.itemAt(1).score += display
                }


            }

        }
    }
}
