include(Catch)
# include(GoogleTest)

add_executable(HelloWorldTest
  main.cpp
  HelloWorldTest.cpp
)
target_link_libraries(HelloWorldTest
  Catch2::Catch2
  HelloWorld
)
# target_link_libraries(HelloWorldTest gtest gmock gtest_main)

target_include_directories(HelloWorldTest PRIVATE
  ../../main/include
)

catch_discover_tests(HelloWorldTest
  EXTRA_ARGS --success
)
# gtest_discover_tests(HelloWorldTest)
