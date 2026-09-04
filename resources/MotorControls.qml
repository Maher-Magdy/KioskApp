import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    id: root

    spacing: 12

    Label {
        id: startStopLabel

        text: qsTr("Start/Stop")
        font.pixelSize: 20
        color: "blue"
    }

    Switch {
        id: switchControl 

        Layout.preferredWidth: 20
        Layout.preferredHeight: 50

        checked: false

        indicator: Rectangle {
            id: switchIndicator 

            x: (switchControl.width - width) / 2
            y: 0
            width: 20
            height: switchControl.height
            radius: width / 2
            color: switchControl.checked ? privates.indicatorColor : "#cccccc"

            Rectangle {
                id: switchHandle

                x: (switchControl.width - width) / 2
                y: switchControl.checked ? 0 : (switchControl.height - height) 
                width: 24
                height: 24
                radius: width / 2
                color: "white"
                
                Behavior on y {
                    NumberAnimation { duration: 150 }
                }
            }
        }

        onCheckedChanged: if (!checked) spinBox.value = 0
    }

    // separator
    Rectangle {
        id: separatorRec

        Layout.preferredHeight: 50
        Layout.preferredWidth: 2
        color: "#1E1E1E"
    }

    SpinBox {
        id: spinBox 

        Layout.preferredWidth: 75
        Layout.preferredHeight: 50

        from: 0
        to: 100
        value: 0
        editable: true
        enabled: switchControl.checked

        validator: IntValidator {
            bottom: Math.min(spinBox.from, spinBox.to)
            top: Math.max(spinBox.from, spinBox.to)
        }
    }  

    // separator
    Rectangle {
        id: verticalSeparator2

        Layout.preferredHeight: 50
        Layout.preferredWidth: 2
        color: "#1E1E1E"
    }

    Label {
        id: mototLabel 

        text: {                            
            if (switchControl.checked && spinBox.value >= spinBox.from && spinBox.value <= spinBox.to)
                qsTr("<font color='blue'>Status:</font> <font color='green'>Running</font>")
            else if (!switchControl.checked && spinBox.value === spinBox.from)
                qsTr("<font color='blue'>Status:</font> <font color='black'>Stopped</font>") 
            else 
                qsTr("<font color='blue'>Status:</font> <font color='red'>Fault</font>") 
        }                            
    
        font.pixelSize: 22
    }   
}

