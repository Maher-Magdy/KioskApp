import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia

ApplicationWindow {
    id: window

    color: '#6f6f6f'
    width: 1600
    height: 900
    minimumWidth: 480
    minimumHeight: 270
    visible: true

    ColumnLayout {
        anchors.fill: parent

        spacing: 0

        ToolsBar {
            id: toolsBar

            Layout.fillWidth: true 
            Layout.preferredHeight: 50

            onIndicatorColorChanged: (value) => {
                privates.indicatorColor = value
            }
        }

        SplitView {
            id: splitView

            Layout.fillWidth: true 
            Layout.fillHeight: true
            orientation: Qt.Horizontal
            spacing: 0   

            handle: Rectangle {
                id: handleDelegate

                implicitWidth: 4
                color: SplitHandle.hovered ? "#595959" : "#1E1E1E"
            }

            ColumnLayout {
                id: line1ColumnLayout 

                SplitView.preferredWidth: parent.width / 2
                SplitView.minimumWidth: Math.min(450, parent.width/2)

                VideoFeed {
                    id: line1VideoFeed

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    videoSource: "qrc:/videos/fruit_video_1.mp4"
                }   

                MotorControls {
                    id: line1Controls 

                    Layout.preferredHeight: 50
                    Layout.fillWidth: true
                    Layout.margins: 12
                }              
            } 

            ColumnLayout {
                id: line2ColumnLayout

                SplitView.preferredWidth: parent.width / 2
                SplitView.minimumWidth: Math.min(450, parent.width/2)

                VideoFeed {
                    id: line2VideoFeed

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    videoSource: "qrc:/videos/fruit_video_2.mp4"
                } 

                MotorControls {
                    id: line2Controls

                    Layout.preferredHeight: 50
                    Layout.fillWidth: true
                    Layout.margins: 12
                }  
            }  
        }

        component VideoFeed: Rectangle {
            id: videoFeed

            required property url videoSource  

            color: "black"

            Camera {
                id: camera

                active: privates.productionLineEnabled
            }

            CaptureSession {
                id: captureSession 

                camera: camera
                videoOutput: privates.productionLineEnabled ? videoOutput : null
            }

            // in case the camera is disabled, we show a looped video
            MediaPlayer {
                id: mediaPlayer

                source: videoSource
                videoOutput: privates.productionLineEnabled ? null : videoOutput
                audioOutput: null // disable audio
                loops: MediaPlayer.Infinite 
                autoPlay: true
            }

            VideoOutput {
                id: videoOutput

                anchors.fill: parent
                fillMode: VideoOutput.PreserveAspectFit
            }
        } 

        QtObject {
            id: privates

            // TODO (Maher): Map this property to user realse flag in Cmake/Config file if needed.
            readonly property bool productionLineEnabled: false 
            property color indicatorColor: "#007acc"
        }      
    }
}
