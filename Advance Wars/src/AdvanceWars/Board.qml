// x = first  player
// o = second player

import QtQuick 2.0

Rectangle
{
    id: big_wrapper
    anchors.fill: parent
    border.color: "black"
    Image
    {
        id: mainBackground
        anchors.fill: parent
        source: "img/MainMap.png"
    }

    Grid
    {
        id: grd_board
        height: parent.height
        width: parent.width
        anchors.horizontalCenter: big_wrapper.horizontalCenter
        anchors.verticalCenter: big_wrapper.verticalCenter
        columns: 30
        rows: 20
        z: 10
        property int _playerTurn: 0;
        property int _playerIndex1: 0; //save positioning
        property int _playerIndex2: 0;
        property color _playerColor1:  newGamePage._playerColor1
        property color _playerColor2: newGamePage._playerColor2
        Repeater
        {
            id: repeater_tic_tac
            model: 900
            Rectangle
            {
                property bool vis;
                property string _player;
                height: parent.height / grd_board.rows//24.1
                width: parent.width / grd_board.columns//21.3
                border.color: "dark grey"
                border.width: .5
                opacity: .5
                color: "transparent"
                Image
                {
                    id: image
                    anchors.fill: parent
                    source: _player
                    visible: true
                }
                MouseArea
                {
                    anchors.fill: parent

                    onClicked:
                    {
                        if(grd_board._playerTurn === 0)
                            repeater_tic_tac.itemAt(index).color = grd_board._playerColor1;
                        else
                            repeater_tic_tac.itemAt(index).color = grd_board._playerColor2;

                        //horizontal
                        //only display movement available if not at top row
                        //if(index > grd_board.columns)
                        //{
                        if(grd_board._playerTurn === 0)
                            repeater_tic_tac.itemAt(index - grd_board.columns).color = grd_board._playerColor1;
                        else
                            repeater_tic_tac.itemAt(index - grd_board.columns).color = grd_board._playerColor2;
                        //}
                        //if(index < ((grd_board.columns - 1) * grd_board.rows))
                        if(grd_board._playerTurn === 0)
                            repeater_tic_tac.itemAt(index + grd_board.columns).color = grd_board._playerColor1;
                        else
                            repeater_tic_tac.itemAt(index + grd_board.columns).color = grd_board._playerColor2;

                        //lateral
                        if(0 != (index % grd_board.columns))//on left edge
                            if(grd_board._playerTurn === 0)
                                 repeater_tic_tac.itemAt(index - 1).color = grd_board._playerColor1;
                            else
                                 repeater_tic_tac.itemAt(index - 1).color = grd_board._playerColor2;

                        if(19 != (index % grd_board.columns))//right edge
                            if(grd_board._playerTurn === 0)
                                 repeater_tic_tac.itemAt(index + 1).color = grd_board._playerColor1;
                            else
                                 repeater_tic_tac.itemAt(index + 1).color = grd_board._playerColor2;

                        if(grd_board._playerTurn === 0)
                        {
                        grd_board._playerTurn = 1;
                        grd_board._playerIndex1 = index;
                         console.log(newGamePage._player1color);
                        repeater_tic_tac.itemAt(index)._player = newGamePage._player1color;
                    }
                    else
                    {
                            grd_board._playerTurn = 0;
                            grd_board._playerIndex2 = index;
                            console.log(newGamePage._player2color);
                        repeater_tic_tac.itemAt(index)._player = newGamePage._player2color;
                    }
                    }
                }

            }

        }

    }

    Image
    {
        id: healthBar
        source:"/img/health.png"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
    }

    Image
    {
        id: damageBar
        source:"/img/damage.png"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
    }
}
