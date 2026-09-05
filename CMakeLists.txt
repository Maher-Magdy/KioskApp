cmake_minimum_required(VERSION 3.16)

project(KioskApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Qml Quick Multimedia)

qt_standard_project_setup(REQUIRES 6.10)

# Content of downloaded design from Figma to Qt or similar
if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

qt_add_executable(appKioskApp
    main.cpp
)

qt_add_qml_module(appKioskApp
    URI KioskApp
    QML_FILES
        resources/Main.qml
        resources/MotorControls.qml
        resources/SettingsPopup.qml
        resources/ToolsBar.qml
    RESOURCES
        icons/close.svg
        icons/colors.svg
        icons/gear.svg
        icons/speed.svg
        icons/tools.svg
        icons/pencil.svg
        videos/fruit_video_1.mp4
        videos/fruit_video_2.mp4
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appKioskApp PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appKioskApp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appKioskApp
    PRIVATE
        Qt6::Quick
        Qt6::Multimedia
)

find_file(QT_WAYLAND_PLUGIN
    NAMES libqwayland.so
    PATHS "${QT6_INSTALL_PREFIX}/plugins/platforms"
    NO_DEFAULT_PATH
)

include(GNUInstallDirs)

install(TARGETS appKioskApp
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_generate_deploy_qml_app_script(
    TARGET appKioskApp
    OUTPUT_SCRIPT deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
    INCLUDE_PLUGINS qwayland
)
install(SCRIPT ${deploy_script})
