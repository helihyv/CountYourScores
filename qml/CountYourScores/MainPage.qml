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
        delegate: Label
        {
            text: display
        }
    }
}
