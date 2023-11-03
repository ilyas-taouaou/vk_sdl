cmake_minimum_required(VERSION 3.26)
project(vk_sdl C CXX)

set(CMAKE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_PDB_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

file(
        DOWNLOAD
        https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.3/CPM.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/cmake/CPM.cmake
        EXPECTED_HASH SHA256=cc155ce02e7945e7b8967ddfaff0b050e958a723ef7aad3766d368940cb15494
)
include(${CMAKE_CURRENT_BINARY_DIR}/cmake/CPM.cmake)

CPMAddPackage("gh:libsdl-org/SDL#6cf84e2")
CPMAddPackage("gh:libsdl-org/SDL_image#7744158")
CPMAddPackage("gh:libsdl-org/SDL_ttf#f9b636f")
CPMAddPackage("gh:libsdl-org/SDL_mixer#8ab0d03")

CPMAddPackage("gh:KhronosGroup/Vulkan-Headers#vulkan-sdk-1.3.268.0")
CPMAddPackage("gh:KhronosGroup/SPIRV-Headers#vulkan-sdk-1.3.268.0")
CPMAddPackage("gh:KhronosGroup/SPIRV-Tools#vulkan-sdk-1.3.268.0")
CPMAddPackage("gh:KhronosGroup/glslang#vulkan-sdk-1.3.268.0")

CPMAddPackage("gh:zeux/volk#41c8f70")

CPMAddPackage("gh:GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator#dc8a3fb")

CPMAddPackage("gh:recp/cglm#d93b46b")

CPMAddPackage("gh:assimp/assimp#a7cfa32")

CPMAddPackage("gh:cimgui/cimgui#4ca6b29")

CPMAddPackage(
        NAME enet
        GITHUB_REPOSITORY lsalzman/enet
        GIT_TAG 2a85cd6
        DOWNLOAD_ONLY True
)

if (enet_ADDED)
    add_library(enet)
    target_include_directories(enet PUBLIC "${enet_SOURCE_DIR}/include")
    target_sources(enet PRIVATE
            ${enet_SOURCE_DIR}/callbacks.c
            ${enet_SOURCE_DIR}/compress.c
            ${enet_SOURCE_DIR}/host.c
            ${enet_SOURCE_DIR}/list.c
            ${enet_SOURCE_DIR}/packet.c
            ${enet_SOURCE_DIR}/peer.c
            ${enet_SOURCE_DIR}/protocol.c
            ${enet_SOURCE_DIR}/unix.c
            ${enet_SOURCE_DIR}/win32.c)
endif ()

add_library(${PROJECT_NAME} INTERFACE)
target_link_libraries(${PROJECT_NAME} INTERFACE
        Vulkan::Headers
        SPIRV-Headers::SPIRV-Headers
        volk::volk_headers
        glslang
        GPUOpen::VulkanMemoryAllocator
        SDL3::SDL3
        SDL3_image::SDL3_image
        SDL3_mixer::SDL3_mixer
        SDL3_ttf::SDL3_ttf
        cglm
        assimp::assimp
        cimgui
        enet
)

if (PROJECT_IS_TOP_LEVEL)
    add_executable(${PROJECT_NAME}_test test/main.c test/deps.cpp)
    target_link_libraries(${PROJECT_NAME}_test PRIVATE ${PROJECT_NAME})
endif ()
