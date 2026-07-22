add_library(CurseMarkEngine
    engine.cpp
)

target_include_directories(CurseMarkEngine
    PUBLIC
    ${CMAKE_SOURCE_DIR}/source/engine
)

target_link_libraries(CurseMarkEngine
    PUBLIC
    SDL3::SDL3
)

function(configure_engine_runtime target_name)
    if(WIN32)
        add_custom_command(TARGET ${target_name} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_if_different
            $<TARGET_RUNTIME_DLLS:${target_name}>
            $<TARGET_FILE_DIR:${target_name}>
            COMMAND_EXPAND_LISTS
        )
    endif()
endfunction()