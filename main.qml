import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12
import "const.js" as CONST
//import "SquareButton.qml"

ApplicationWindow {
    visible: true
    width: 360
    height: 360
    color: "transparent"
    opacity: 1.0
    id: rootWindow
    flags: Qt.Window | Qt.FramelessWindowHint
    property int currentPage: 1

    Item {
        id: baseContainer
        anchors.fill: parent;
        property bool isOpen: false

        //1行目
        SquareButton{
            id: sqb1_1
            opacity: 0
            dragAccepted: true
            onFilePathChanged: {
                localSettings.setValue("P" + currentPage + "_1_1", filePath);
            }
        }

        SquareButton {
            id: sqb1_2
            opacity: 0
            baseColor: CONST.COLOR_BASE_D
            onClicked: {
                if(e === Qt.LeftButton)
                {
                    blink();
                    rotationAnim1.start();
                }
            }

            Text {
                id: txtPage
                color: CONST.COLOR_PAGE_NUM
                anchors.fill: parent
                text: currentPage.toString()
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "メイリオ"
                font.pointSize: 40
            }
        }

        SquareButton {
            id: sqb1_3
            opacity: 0
            dragAccepted: true
            onFilePathChanged: {
                localSettings.setValue("P" + currentPage + "_1_3", filePath);
            }
        }

        //2行目
        SquareButton {
            id: sqb2_1
            opacity: 0
            dragAccepted: true
            onFilePathChanged: {
                localSettings.setValue("P" + currentPage + "_2_1", filePath);
            }
        }

        SquareButton {
            id: sqb2_3
            opacity: 0
            dragAccepted: true
            onFilePathChanged: {
                localSettings.setValue("P" + currentPage + "_2_3", filePath);
            }
        }

        //３行目
        SquareButton {
            id: sqb3_1
            opacity: 0
            dragAccepted: true
            onFilePathChanged: {
                localSettings.setValue("P" + currentPage + "_3_1", filePath);
            }
        }
        SquareButton {
            id: sqb3_2
            opacity: 0
            dragAccepted: true
            onFilePathChanged: {
                localSettings.setValue("P" + currentPage + "_3_2", filePath);
            }
        }

        SquareButton {
            id: sqb3_3
            opacity: 0
            dragAccepted: true
            onFilePathChanged: {
                localSettings.setValue("P" + currentPage + "_3_3", filePath);
            }
        }

        SquareButton{
            id: mainButton
            x: 120; y: 120
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            baseColor: CONST.COLOR_BASE_D
            property variant clickPos: "1,1";
            MouseArea {
                id: mainButtonMouseArea
                anchors.fill: parent;
                onDoubleClicked: {
                    if(!closeAnimation.running && !openAnimation.running)
                    {
                        mainButton.blink();
                        if( baseContainer.isOpen)
                        {
                            closeAnimation.start();
                        }
                        else
                        {
                            openAnimation.start();
                        }
                        baseContainer.isOpen = !baseContainer.isOpen;
                    }
                }

                onPressed: {
                    if(mainButtonMouseArea.pressedButtons & Qt.LeftButton) {
                        mainButton.clickPos  = Qt.point(mouse.x,mouse.y);
                    }
                }

                onPositionChanged: {
                    if(mainButtonMouseArea.pressedButtons & Qt.LeftButton) {
                        var delta = Qt.point(mouse.x-mainButton.clickPos.x, mouse.y-mainButton.clickPos.y);
                        rootWindow.x += delta.x;
                        rootWindow.y += delta.y;
                    }
                }
            }
        }

        ParallelAnimation{
            id: openAnimation

            //sqb1_1
            NumberAnimation { target: sqb1_1; property: "x"; duration: CONST.ANIM_DURATION; from:mainButton.x; to: mainButton.x - sqb1_1.width }
            NumberAnimation { target: sqb1_1; property: "y"; duration: CONST.ANIM_DURATION; from:mainButton.x; to: mainButton.y - sqb1_1.height }
            NumberAnimation { target: sqb1_1; property: "opacity"; duration: CONST.ANIM_DURATION; from:0; to: 1 }

            //sqb1_2
            NumberAnimation { target: sqb1_2; property: "x"; duration: CONST.ANIM_DURATION; from:mainButton.x; to: mainButton.x }
            NumberAnimation { target: sqb1_2; property: "y"; duration: CONST.ANIM_DURATION; from:mainButton.y; to: mainButton.y - sqb1_2.height }
            NumberAnimation { target: sqb1_2; property: "opacity"; duration: CONST.ANIM_DURATION; from:0; to: 1 }

            //sqb1_3
            NumberAnimation { target: sqb1_3; property: "x"; duration: CONST.ANIM_DURATION; from:mainButton.x; to: mainButton.x + sqb1_3.width }
            NumberAnimation { target: sqb1_3; property: "y"; duration: CONST.ANIM_DURATION; from:mainButton.y; to: mainButton.y - sqb1_3.height}
            NumberAnimation { target: sqb1_3; property: "opacity"; duration: CONST.ANIM_DURATION; from:0; to: 1 }

            //sqb2_1
            NumberAnimation { target: sqb2_1; property: "x"; duration: CONST.ANIM_DURATION; from:mainButton.x; to: mainButton.x - sqb2_1.width }
            NumberAnimation { target: sqb2_1; property: "y"; duration: CONST.ANIM_DURATION; from:mainButton.y; to: mainButton.y }
            NumberAnimation { target: sqb2_1; property: "opacity"; duration: CONST.ANIM_DURATION; from:0; to: 1 }

            //sqb2_3
            NumberAnimation { target: sqb2_3; property: "x"; duration: CONST.ANIM_DURATION; from:mainButton.x; to: mainButton.x + sqb2_3.width }
            NumberAnimation { target: sqb2_3; property: "y"; duration: CONST.ANIM_DURATION; from:mainButton.y; to: mainButton.y }
            NumberAnimation { target: sqb2_3; property: "opacity"; duration: CONST.ANIM_DURATION; from:0; to: 1 }

            //sqb3_1
            NumberAnimation { target: sqb3_1; property: "x"; duration: CONST.ANIM_DURATION; from:mainButton.x; to: mainButton.x - sqb3_1.width }
            NumberAnimation { target: sqb3_1; property: "y"; duration: CONST.ANIM_DURATION; from:mainButton.y; to: mainButton.y + sqb3_1.height }
            NumberAnimation { target: sqb3_1; property: "opacity"; duration: CONST.ANIM_DURATION; from:0; to: 1 }

            //sqb3_2
            NumberAnimation { target: sqb3_2; property: "x"; duration: CONST.ANIM_DURATION; from:mainButton.x; to: mainButton.x }
            NumberAnimation { target: sqb3_2; property: "y"; duration: CONST.ANIM_DURATION; from:mainButton.y; to: mainButton.y + sqb3_2.height }
            NumberAnimation { target: sqb3_2; property: "opacity"; duration: CONST.ANIM_DURATION; from:0; to: 1 }

            //sqb3_3
            NumberAnimation { target: sqb3_3; property: "x"; duration: CONST.ANIM_DURATION; from:mainButton.x; to: mainButton.x + sqb3_3.width  }
            NumberAnimation { target: sqb3_3; property: "y"; duration: CONST.ANIM_DURATION; from:mainButton.y; to: mainButton.y + sqb3_3.height  }
            NumberAnimation { target: sqb3_3; property: "opacity"; duration: CONST.ANIM_DURATION; from:0; to: 1 }
        }

        ParallelAnimation{
            id: closeAnimation

            //sqb1_1
            NumberAnimation { target: sqb1_1; property: "x"; duration: CONST.ANIM_DURATION; from:sqb1_1.x; to: mainButton.x }
            NumberAnimation { target: sqb1_1; property: "y"; duration: CONST.ANIM_DURATION; from:sqb1_1.y; to: mainButton.y }
            NumberAnimation { target: sqb1_1; property: "opacity"; duration: CONST.ANIM_DURATION; from:1; to: 0 }

            //sqb1_2
            NumberAnimation { target: sqb1_2; property: "y"; duration: CONST.ANIM_DURATION; from:sqb1_2.y; to: mainButton.y }
            NumberAnimation { target: sqb1_2; property: "opacity"; duration: CONST.ANIM_DURATION; from:1; to: 0 }

            //sqb1_3
            NumberAnimation { target: sqb1_3; property: "x"; duration: CONST.ANIM_DURATION; from:sqb1_3.x; to: mainButton.x }
            NumberAnimation { target: sqb1_3; property: "y"; duration: CONST.ANIM_DURATION; from:sqb1_3.y; to: mainButton.y }
            NumberAnimation { target: sqb1_3; property: "opacity"; duration: CONST.ANIM_DURATION; from:1; to: 0 }

            //sqb2_1
            NumberAnimation { target: sqb2_1; property: "x"; duration: CONST.ANIM_DURATION; from:sqb2_1.x; to: mainButton.x }
            NumberAnimation { target: sqb2_1; property: "opacity"; duration: CONST.ANIM_DURATION; from:1; to: 0 }

            //sqb2_3
            NumberAnimation { target: sqb2_3; property: "x"; duration: CONST.ANIM_DURATION; from:sqb2_3.x; to: mainButton.x }
            NumberAnimation { target: sqb2_3; property: "opacity"; duration: CONST.ANIM_DURATION; from: 1; to: 0 }

            //sqb3_1
            NumberAnimation { target: sqb3_1; property: "x"; duration: CONST.ANIM_DURATION; from:sqb3_1.x; to: mainButton.x }
            NumberAnimation { target: sqb3_1; property: "y"; duration: CONST.ANIM_DURATION; from:sqb3_1.y; to: mainButton.y }
            NumberAnimation { target: sqb3_1; property: "opacity"; duration: CONST.ANIM_DURATION; from:1; to: 0 }

            //sqb3_2
            NumberAnimation { target: sqb3_2; property: "y"; duration: CONST.ANIM_DURATION; from:sqb3_2.y; to: mainButton.y }
            NumberAnimation { target: sqb3_2; property: "opacity"; duration: CONST.ANIM_DURATION; from:1; to: 0 }

            //sqb3_3
            NumberAnimation { target: sqb3_3; property: "x"; duration: CONST.ANIM_DURATION; from:sqb3_3.x; to: mainButton.x }
            NumberAnimation { target: sqb3_3; property: "y"; duration: CONST.ANIM_DURATION; from:sqb3_3.y; to: mainButton.y }
            NumberAnimation { target: sqb3_3; property: "opacity"; duration: CONST.ANIM_DURATION; from:1; to: 0 }
        }

        ParallelAnimation{
            //0-90度
            id: rotationAnim1
            NumberAnimation { target: sqb1_1; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:0; to: 90 }
            NumberAnimation { target: sqb1_3; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:0; to: 90 }
            NumberAnimation { target: sqb2_1; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:0; to: 90 }
            NumberAnimation { target: sqb2_3; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:0; to: 90 }
            NumberAnimation { target: sqb3_1; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:0; to: 90 }
            NumberAnimation { target: sqb3_2; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:0; to: 90 }
            NumberAnimation { target: sqb3_3; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:0; to: 90 }
            onFinished: {
                rootWindow.currentPage++;
                if(rootWindow.currentPage > 3) rootWindow.currentPage = 1;
                loadFilepath(rootWindow.currentPage);
                rotationAnim2.start();
            }
        }

        ParallelAnimation{
            //90-0度
            id: rotationAnim2
            NumberAnimation { target: sqb1_1; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:90; to: 0 }
            NumberAnimation { target: sqb1_3; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:90; to: 0 }
            NumberAnimation { target: sqb2_1; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:90; to: 0 }
            NumberAnimation { target: sqb2_3; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:90; to: 0 }
            NumberAnimation { target: sqb3_1; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:90; to: 0 }
            NumberAnimation { target: sqb3_2; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:90; to: 0 }
            NumberAnimation { target: sqb3_3; property: "angleY"; duration: CONST.ANIM_ROTATE_DURATION; from:90; to: 0 }
        }
    }

    Component.onCompleted: {
        console.log("start");
        loadFilepath(1);
    }

    onClosing: {
        localSettings.save();
    }

    function loadFilepath(pageNum)
    {
        sqb1_1.filePath = localSettings.getValue("P" + pageNum + "_1_1");
        sqb1_3.filePath = localSettings.getValue("P" + pageNum + "_1_3");
        sqb2_1.filePath = localSettings.getValue("P" + pageNum + "_2_1");
        sqb2_3.filePath = localSettings.getValue("P" + pageNum + "_2_3");
        sqb3_1.filePath = localSettings.getValue("P" + pageNum + "_3_1");
        sqb3_2.filePath = localSettings.getValue("P" + pageNum + "_3_2");
        sqb3_3.filePath = localSettings.getValue("P" + pageNum + "_3_3");
    }


}
