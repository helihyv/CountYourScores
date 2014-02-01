/**************************************************************************
**  CoverPage.qml (of CountYourScores)
**  Copyright (c) 2012–2014 Heli Hyvättinen
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
**  CoverPage 1.2.2014
**************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground
{
    property var totalScores: [0,0,0,0]

    onStatusChanged: {totalScores = mainPage.getTotalScores()}

    Column
    {
        Label
        {
            text: "CountYourScores"
            font.pointSize: Theme.fontSizeSmall
        }

        Repeater
        {
            model: 4

            Label
            {
                text: "Player " + (index+1) + ": " + totalScores[index]

            }
        }
    }

}
