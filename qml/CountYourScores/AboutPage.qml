/**************************************************************************
**  AboutPage.qml (of CountYourScores)
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
**  AboutPage 28.4.2013
**************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
import org.maemo.fremantle 1.0

Page
{
    tools: commonTools

    Label
    {
        anchors.fill: parent

        text: "<h2>CountYourScores v. 0.1</h2>(c) Heli Hyvättinen 2012<br>This program is free software under the General Public License 3" +
               "<p>The source code is available from <a href=https://github.com/helihyv/CountYourScores/tree/fremantle> https://github.com/helihyv/CountYourScores/tree/fremantle</a>" +
                "<p> You can find instructions of use on <a href=http://helihyv.github.io/CountYourScores/ > http://helihyv.github.io/CountYourScores/</a>"+
                "<p>Bugreports and feature requests are welcome at <a href=https://github.com/helihyv/CountYourScores/issues> https://github.com/helihyv/CountYourScores/issues</a>"
        wrapMode: Text.Wrap

        onLinkActivated:
        {
            Qt.openUrlExternally(link)
        }
    }
}
