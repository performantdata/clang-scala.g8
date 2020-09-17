#-------------------------------------------------------
# Build a JNI-compatible API, using SWIG.

set_property(SOURCE HelloWorld.i PROPERTY CPLUSPLUS ON)
set_property(SOURCE HelloWorld.i PROPERTY COMPILE_OPTIONS -package $package$)

if (SBT_SOURCE_MANAGED)
  set(JAVA_OUTPUT_DIR \${SBT_SOURCE_MANAGED}/$package;format="package-dir"$)
else()
  set(JAVA_OUTPUT_DIR \${PROJECT_BINARY_DIR}/src_managed/main/java/$package;format="package-dir"$)
endif()

swig_add_library(HelloWorld_swig TYPE OBJECT
  LANGUAGE    java
  OUTPUT_DIR  \${JAVA_OUTPUT_DIR}
  OUTFILE_DIR .
  SOURCES     HelloWorld.i
)

set_target_properties(HelloWorld_swig PROPERTIES
  SWIG_USE_TARGET_INCLUDE_DIRECTORIES ON
  POSITION_INDEPENDENT_CODE ON            # needed to generate -fPIC
)

target_include_directories(HelloWorld_swig PRIVATE
  \${JNI_INCLUDE_DIRS}
  ../include
)


#-------------------------------------------------------
# Build the shared library, including the JNI API.

add_library(HelloWorld SHARED
  HelloWorld.cpp
  \$<TARGET_OBJECTS:HelloWorld_swig>
)
