add_executable(CurseMarkClone
    game.cpp
)

target_link_libraries(CurseMarkClone
    PRIVATE
    CurseMarkEngine
)

configure_engine_runtime(CurseMarkClone)
