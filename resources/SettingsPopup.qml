import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs

Popup {
    id: root

    signal indicatorColorChanged(color value)

    parent: Overlay.overlay
    anchors.centerIn: parent
    width: 900
    height: 450
    padding: 1
    modal: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        id: backgroundRec

        radius: 8
        color: "#343434"
        border.width: 1
        border.color: "#1E1E1E"
    }

    ColumnLayout {
        id: mainColumnLayout 

        anchors.fill: parent
        spacing: 0

        RowLayout {
            id: titleBar

            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Layout.margins: 8
            spacing: 0

            Rectangle {
                id: iconRec

                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Layout.leftMargin: 50
                color: "transparent"
                
                Image {
                    id: iconImage 

                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/icons/gear.svg"
                }
            }

            Button {
                id: closeBtn

                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                icon.source: "qrc:/icons/close.svg"
                icon.width: 50
                icon.height: 50

                onClicked: root.close()
            }
        }

        // Horizontal Separator
        Rectangle {
            id: horizontalSeparator

            Layout.fillWidth: true
            Layout.preferredHeight: 3
            color: "#1E1E1E"
        }

        RowLayout {
            id: mainSettingsRowLayout 

            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            ColumnLayout {
                id: categoryColumnLayout

                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
                spacing: 0

                ButtonGroup {
                    id: btnGroup
                }

                SettingsTab {
                    id: speedBtn

                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 75

                    tabText: qsTr("Speed")
                    iconSource: "qrc:/icons/speed.svg"
                    checked: true
                }

                SettingsTab {
                    id: toolsBtn

                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 75

                    tabText: qsTr("Tools")
                    iconSource: "qrc:/icons/tools.svg"
                }

                SettingsTab {
                    id: colorsBtn

                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 75

                    tabText: qsTr("Colors")
                    iconSource: "qrc:/icons/colors.svg"
                }
            }

            component SettingsTab: Button {
                id: settingsTab

                required property string tabText
                required property url iconSource

                text: tabText
                icon.source: iconSource
                icon.width: 35
                icon.height: 35
                
                palette.button: "royalblue" 

                checkable: true

                ButtonGroup.group: btnGroup
            } 

            // Vertical Separator
            Rectangle {
                id: verticalSeparator

                Layout.fillHeight: true
                Layout.preferredWidth: 3
                color: "#1E1E1E"
            }

            RowLayout {
                id: subSettingsRowLayout 

                Layout.alignment: Qt.AlignTop
                Layout.margins: 12
                spacing: 12

                Label {
                    id: settingLabel 

                    text: {
                        switch (btnGroup.checkedButton) {
                        case speedBtn: return qsTr("RPM:")
                        case toolsBtn: return qsTr("Unit:")
                        case colorsBtn: return qsTr("Indicator:")
                        }
                    }
                    font.pixelSize: 20
                    color: "royalblue"
                }

                Slider {
                    id: slider 

                    Layout.preferredWidth: 400
                    visible: btnGroup.checkedButton === speedBtn

                    from: 0
                    to: 100

                    Text {
                        id: sliderValue

                        x: parent.handle.x - (width - parent.handle.width) / 2
                        y: parent.handle.y - 16
                        color: "white"
                        text: parent.value.toFixed(2)
                        font.pixelSize: 14
                    }
                }

                ComboBox {
                    id: comboBox 

                    visible: btnGroup.checkedButton === toolsBtn

                    model: ["Kg", "Ib", "Oz"]
                    popup.modal: true
                    popup.closePolicy: Popup.CloseOnPressOutside
                }                  

                Button {
                    id: colorDialogOpener

                    visible: btnGroup.checkedButton === colorsBtn

                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40

                    icon.source: "qrc:/icons/pencil.svg"
                    onClicked: colorDialog.open()
                }

                ColorDialog {
                    id: colorDialog

                    onAccepted: {
                        root.indicatorColorChanged(selectedColor)
                        colorDialogOpener.palette.button = selectedColor
                    }
                }
            }
        }
    }
}

