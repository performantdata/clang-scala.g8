# Shim for pre-3.14 `FetchContent`.
# See https://cliutils.gitlab.io/modern-cmake/chapters/projects/fetch.html
# See https://cmake.org/cmake/help/latest/module/FetchContent.html#populating-the-content
if(\${CMAKE_VERSION} VERSION_LESS 3.14)
  macro(FetchContent_MakeAvailable NAME)
    FetchContent_GetProperties(\${NAME})
    string(TOLOWER "\${NAME}" lcName)
    if(NOT \${lcName}_POPULATED)
      FetchContent_Populate(\${NAME})
      add_subdirectory(\${\${lcName}_SOURCE_DIR} \${\${lcName}_BINARY_DIR})
    endif()
  endmacro()
endif()
