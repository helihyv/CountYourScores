import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    MainPage {
        id: mainPage
    }

    AboutPage
    {
        id: aboutPage
    }

    ToolBarLayout {
        id: commonTools
        visible: true

        ToolIcon
        {
            platformIconId: "toolbar-back"
            onClicked: pageStack.pop()
            visible: pageStack.currentPage == mainPage ? false : true
        }

        ToolIcon
        {
            platformIconId: "toolbar-undo"
            visible: pageStack.currentPage == mainPage ? true : false
        }

        ToolIcon

        {
            platformIconId: "toolbar-next"
            visible: pageStack.currentPage == mainPage ? true : false
        }

        ToolIcon
        {
            platformIconId: "toolbar-delete"
            visible: pageStack.currentPage == mainPage ? true : false
        }

        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem
            {
                text: qsTr("About")
                onClicked: pageStack.push(aboutPage)
            }

        }
    }
}
