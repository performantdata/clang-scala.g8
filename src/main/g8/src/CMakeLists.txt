# `FetchContent` requires 3.11+.
# `UseSWIG` requires 3.13+ to use standard target names. (CMP0078)
cmake_minimum_required(VERSION 3.13...3.18 FATAL_ERROR)

project($name$
  VERSION 0.1.0
  LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_EXTENSIONS OFF)
add_compile_options("-g")

include(shims.cmake)
include(dependencies.cmake)

# Set up to generate JNI interfaces

find_package(Java COMPONENTS Development REQUIRED)
find_package(JNI REQUIRED)
find_package(SWIG 3.0 REQUIRED COMPONENTS java)
include(UseSWIG)


add_subdirectory(main)

# Only do these if this is the main project, and not if it is included through `add_subdirectory()`.
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  include(CTest)
  if(BUILD_TESTING)
    add_subdirectory(test/cpp)
  endif()

  find_package(Doxygen OPTIONAL_COMPONENTS dot)
  if(Doxygen_FOUND)
#    add_subdirectory(docs)
  else()
    message(STATUS "Doxygen not found, not building docs.")
  endif()
endif()
