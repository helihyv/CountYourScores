/**************************************************************************
**  main.qml (of CountYourScores)
**  Copyright (c) 2012–2013 Heli Hyvättinen
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
**  main.qml 31.1.2014
**************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
    id: appWindow

    initialPage: mainPage

    cover: coverPage

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

    CoverPage
    {
        id: coverPage
    }
}



