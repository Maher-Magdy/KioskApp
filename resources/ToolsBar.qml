import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    signal indicatorColorChanged(color value)

    color: "#343434"
    border.width: 2
    border.color: "#1E1E1E"
    radius: 4

    RowLayout {
        anchors.fill: parent

        Text {
            id: line1Text 
            
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Line 1")
            color: "green"
            font.pixelSize: 30
            font.weight: Font.Bold
        }

        Rectangle {
            id: settingsBtn                    

            Layout.preferredWidth: 45
            Layout.preferredHeight: 45 
            Layout.alignment: Qt.AlignCenter               
            color: mouseArea.containsMouse ? "#1E1E1E" : "transparent"
            radius: 4 

            Image {
                id: gearImage

                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "qrc:/icons/gear.svg"
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                hoverEnabled: true

                onClicked: settingsPopup.open()
            }   

            ToolTip {
                id: settingsToolTip 

                visible: mouseArea.containsMouse
                text: qsTr("Settings")
            }
        }

        Text {
            id: line2Text 

            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Line 2")
            color: "green"
            font.pixelSize: 30
            font.weight: Font.Bold
        }
    }

    SettingsPopup {
        id: settingsPopup

        onIndicatorColorChanged: (value) => {
            root.onIndicatorColorChanged(value)
        }
    }
}

