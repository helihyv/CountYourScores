/**************************************************************************
**  main.qml (of CountYourScores)
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
**  main.qml 4.9.2012
**************************************************************************/

import QtQuick 1.1
import com.nokia.meego 1.1

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

    SettingsPage
    {
        id: settingsPage
    }

    CreateNumberSetPage
    {
        id: createNumberSetPage
    }

    ToolBarLayout {
        id: commonTools
        visible: true

        ToolIcon
        {
            iconId: "toolbar-home"
            visible: pageStack.depth > 2
            onClicked:
            {
                pageStack.pop(null)
            }
        }


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
            onClicked:
            {
                mainPage.undo()
            }
        }

        ToolIcon

        {
            id: addGameIcon
            platformIconId: "toolbar-next"
            visible: pageStack.currentPage == mainPage ? true : false
            onClicked:
            {
                mainPage.addGame()
                if (mainPage.games > 8)
                {
                    enabled = false
                    platformIconId = "toolbar-next-dimmed"
                }
            }
        }

        ToolIcon
        {
            platformIconId: "toolbar-delete"
            visible: pageStack.currentPage == mainPage ? true : false
            onClicked:
            {
                mainPage.clearScores()
                addGameIcon.enabled = true
                addGameIcon.platformIconId = "toolbar-next"

            }
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

            MenuItem
            {
                text: qsTr("Settings")
                onClicked: pageStack.push(settingsPage)
            }

        }
    }
}
