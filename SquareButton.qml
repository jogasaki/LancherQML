import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import "const.js" as CONST

Item{
    id: root_element;
    height: 100; width: 100;

    //カスタムプロパティー
    property string baseColor: CONST.COLOR_BASE;
    property string filePath: "";
    property bool dragAccepted : false;
    property real imageOpacity : 1;
    property real angleY : 0;

    //カスタムイベント
    signal clicked(int e);

    transform: Rotation{
        origin.x: width / 2;
        origin.y: height / 2;
        axis { x: 0; y: 1; z: 0 }
        angle: angleY;
    }

    Glow {
        id: e_glow
        opacity: 0
        anchors.fill: mainSqare
        radius: 20
        samples: 20
        color: CONST.COLOR_TRIM
        source: mainSqare
    }

    Rectangle {
        id: mainSqare
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: 90; width: 90
        x: 4; y: 4
        radius: 10
        color: baseColor
        border.width: 3
        border.color: CONST.COLOR_TRIM

        Image{
            width: 32
            height: 32
            opacity: imageOpacity
            anchors.top: parent.top
            anchors.topMargin: 25
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: (filePath.length === 0) ? "" : "image://fileicon/" + filePath;
        }

        Text {
            id: txtFileName
            opacity: imageOpacity
            x: 0
            y: 64
            width: 74
            height: 16
            clip: true
            color: CONST.COLOR_FILENAME
            wrapMode: Text.Wrap
            maximumLineCount: 1
            text: {
                //filePathからファイル名だけ取り出す
                var txt = root_element.filePath.split('\\').pop().split('/').pop();
                if(txt.length === 0){
                    return " "; //空白を入れる。空文字だとToolTiiｐが表示されてしまう。
                }else{
                    return txt;
                }
            }

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            font.pointSize: 10
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MouseArea{
            id: mouseArea
            anchors.fill: parent;
            property var _latestPressButton: Qt.NoButton;
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton;
            ToolTip {
                id: fileToolTip
                visible: parent.containsMouse && txtFileName.truncated
                delay: 500
                text: txtFileName.text
            }

            onPressed: {
                _latestPressButton = pressedButtons;
            }

            onClicked: {
                switch(_latestPressButton){
                case Qt.LeftButton:
                    root_element.clicked(Qt.LeftButton);
                    break;
                case Qt.RightButton:
                    root_element.filePath = "";
                    root_element.clicked(Qt.RightButton);
                    break;
                case Qt.MiddleButton:
                default:
                    break;
                }
            }

            onDoubleClicked: {
                root_element.runProgram();
            }
        }

        DropArea {
            anchors.fill: parent;
            onEntered:{
                drag.accepted = root_element.dragAccepted;
            }
            onDropped: {
                var url_path = drop.urls.toString();
                url_path = url_path.replace(/^(file:\/{3})/,"");
                root_element.filePath = decodeURIComponent(url_path);
            }
        }
    }

    //点灯アニメーション
    SequentialAnimation{
        id: brinkAnim;
        NumberAnimation {　target: e_glow;　properties: "opacity";　from:0;　to:0.8;　duration: 100;　}
        NumberAnimation {　target: e_glow;　properties: "opacity";　from:0.8;　to:0;　duration: 400;　}
    }

    //点灯させる
    function blink(){
        brinkAnim.start();
    }

    //プログラムを実行する
    function runProgram(){
        if(root_element.filePath.length > 0)
        {
            blink();
            proc.start(root_element.filePath);
        }
    }
}
