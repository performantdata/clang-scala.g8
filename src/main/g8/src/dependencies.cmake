# Make available to this project those packages on which we depend.
# See https://cliutils.gitlab.io/modern-cmake/chapters/testing/googletest.html

# `FetchContent` is the way to do this these days, not `ExternalProject`.
# See https://crascit.com/2015/07/25/cmake-gtest/ .
include(FetchContent)

FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG        v2.13.1
)

FetchContent_MakeAvailable(Catch2)
list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/contrib)
message(VERBOSE "Added ${catch2_SOURCE_DIR}/contrib to CMAKE_MODULE_PATH.")

# FetchContent_Declare(
#   googletest
#   GIT_REPOSITORY https://github.com/google/googletest.git
#   GIT_TAG        release-1.10.0
# )

# Downloading Google Test like this allows us to build it with the same compiler flags
# as the rest of the code, potentially avoiding linkage issues.  (This is instead of
# relying on the `GoogleTest` CMake module and having the compiled library already
# installed.)
# See https://github.com/google/googletest/tree/master/googletest/README.md#incorporating-into-an-existing-cmake-project .
# FetchContent_MakeAvailable(googletest)

# The C++ Guidelines Support Library, Microsoft implementation
FetchContent_Declare(
  gsl
  GIT_REPOSITORY https://github.com/Microsoft/GSL.git
  GIT_TAG        origin/master
  GIT_SHALLOW    True
)
FetchContent_MakeAvailable(gsl)
include_directories(${gsl_SOURCE_DIR}/include)
