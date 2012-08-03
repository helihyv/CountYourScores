import QtQuick 1.1
import com.nokia.meego 1.0
import countyourscores 0.1

Page {
    tools: commonTools


    ReplaceableIntegerListModel
    {
        id: numbersList
    }


    GridView
    {
        anchors.fill: parent
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
                onPressed: parent.color = "red"
            }

        }
    }
}
