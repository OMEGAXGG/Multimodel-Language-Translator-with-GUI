cmake_minimum_required(VERSION 3.16)
project(Tra)

set(CMAKE_AUTOMOC ON)
find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

add_executable(tra main.cpp Translator.cpp
    resources.qrc)  # Include your source files

# Add the .qrc file to the project
qt6_add_resources(tra "resources"
    PREFIX "/"
    FILES rcc/resources.qrc
)

# Link necessary Qt libraries
target_link_libraries(tra PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick)
