cmake_minimum_required(VERSION 3.16)

project(qt_console VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Core LinguistTools REQUIRED)

qt_add_executable(qt_console
    main.cpp
)

qt_add_translations(qt_console
    TS_FILES
    qt_console_ru_RU.ts
)

target_link_libraries(qt_console
    PRIVATE Qt6::Core)
