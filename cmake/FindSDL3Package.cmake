set(SDL_PACKAGE_ROOT "${CMAKE_SOURCE_DIR}/external/SDL3-3.4.12")
set(SDL_PREFIX_ROOT "${SDL_PACKAGE_ROOT}/SDL3-3.4.12/x86_64-w64-mingw32")

find_package(SDL3 CONFIG QUIET PATHS "${SDL_PREFIX_ROOT}" NO_DEFAULT_PATH)

if(NOT TARGET SDL3::SDL3)
    message(STATUS "SDL3 package not found in external; attempting to download it")

    file(MAKE_DIRECTORY "${SDL_PACKAGE_ROOT}")

    set(SDL_DOWNLOAD_URL "https://github.com/libsdl-org/SDL/releases/download/release-3.4.12/SDL3-devel-3.4.12-mingw.tar.gz")
    set(SDL_ARCHIVE_PATH "${SDL_PACKAGE_ROOT}/SDL3-devel-3.4.12-mingw.tar.gz")

    file(DOWNLOAD
        "${SDL_DOWNLOAD_URL}"
        "${SDL_ARCHIVE_PATH}"
        SHOW_PROGRESS
        STATUS SDL_DOWNLOAD_STATUS
    )

    list(GET SDL_DOWNLOAD_STATUS 0 SDL_DOWNLOAD_STATUS_CODE)

    if(NOT SDL_DOWNLOAD_STATUS_CODE EQUAL 0)
        message(FATAL_ERROR "Could not download SDL3 package. Place a valid SDL3 development package in ${SDL_PACKAGE_ROOT}.")
    endif()

    execute_process(
        COMMAND ${CMAKE_COMMAND} -E tar xzf "${SDL_ARCHIVE_PATH}"
        WORKING_DIRECTORY "${SDL_PACKAGE_ROOT}"
        RESULT_VARIABLE SDL_EXTRACT_STATUS
    )

    if(NOT SDL_EXTRACT_STATUS EQUAL 0)
        message(FATAL_ERROR "Could not extract SDL3 package.")
    endif()

    find_package(SDL3 CONFIG QUIET PATHS "${SDL_PREFIX_ROOT}" NO_DEFAULT_PATH)
endif()

if(NOT TARGET SDL3::SDL3)
    find_package(SDL3 CONFIG QUIET)
endif()

if(NOT TARGET SDL3::SDL3)
    message(FATAL_ERROR "SDL3 could not be found. Please place a valid SDL3 development package in ${SDL_PACKAGE_ROOT}.")
endif()
