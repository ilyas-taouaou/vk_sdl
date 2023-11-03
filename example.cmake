cmake_minimum_required(VERSION 3.26)
project(example C)
enable_language(CXX)

set(CMAKE_C_STANDARD 23)

file(
        DOWNLOAD
        https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.3/CPM.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/cmake/CPM.cmake
        EXPECTED_HASH SHA256=cc155ce02e7945e7b8967ddfaff0b050e958a723ef7aad3766d368940cb15494
)
include(${CMAKE_CURRENT_BINARY_DIR}/cmake/CPM.cmake)

CPMAddPackage("gh:ilyas-taouaou/vk_sdl#main")

add_executable(${PROJECT_NAME} main.c)
target_link_libraries(${PROJECT_NAME} PRIVATE vk_sdl)
