# Make available to this project those packages on which we depend.

# `FetchContent` is the way to do this these days, not `ExternalProject`.
# See https://crascit.com/2015/07/25/cmake-gtest/ .
include(FetchContent)

# Shim for pre-3.14 `FetchContent`.
if(${CMAKE_VERSION} VERSION_LESS 3.14)
  macro(FetchContent_MakeAvailable NAME)
    FetchContent_GetProperties(${NAME})
    if(NOT ${NAME}_POPULATED)
      FetchContent_Populate(${NAME})
      add_subdirectory(${${NAME}_SOURCE_DIR} ${${NAME}_BINARY_DIR})
    endif()
  endmacro()
endif()

FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG        release-1.10.0
)

# Downloading Google Test like this allows us to build it with the same compiler flags
# as the rest of the code, potentially avoiding linkage issues.  (This is instead of
# relying on the `GoogleTest` CMake module and having the compiled library already
# installed.)
# See https://github.com/google/googletest/tree/master/googletest/README.md#incorporating-into-an-existing-cmake-project .
FetchContent_MakeAvailable(googletest)

