cmake_minimum_required(VERSION 3.16)

project(qt_quick VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick LinguistTools REQUIRED)

qt_add_executable(appqt_quick
    main.cpp
)

qt_add_translations(appqt_quick
    TS_FILES
    qt_quick_ru_RU.ts
)

qt_add_qml_module(appqt_quick
    URI qt_quick
    VERSION 1.0
    QML_FILES main.qml 
)

set_target_properties(appqt_quick PROPERTIES
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appqt_quick
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appqt_quick
    PRIVATE Qt6::Quick)
