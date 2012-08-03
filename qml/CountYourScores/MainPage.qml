import QtQuick 1.1
import com.nokia.meego 1.0
import countyourscores 0.1

Page {
    tools: commonTools

    Label {
        id: label
        anchors.centerIn: parent
        text: qsTr("Hello world!")
        visible: false
    }

    Button{
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: label.bottom
            topMargin: 10
        }
        text: qsTr("Click here!")
        onClicked: label.visible = true
    }

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
