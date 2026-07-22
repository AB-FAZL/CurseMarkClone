add_executable(CurseMarkClone
    game.cpp
)

target_link_libraries(CurseMarkClone
    PRIVATE
    SDL3::SDL3
)

if(WIN32)
    add_custom_command(TARGET CurseMarkClone POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_RUNTIME_DLLS:CurseMarkClone>
        $<TARGET_FILE_DIR:CurseMarkClone>
        COMMAND_EXPAND_LISTS
    )
endif()
