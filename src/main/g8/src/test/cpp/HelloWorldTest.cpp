#include <catch2/catch.hpp>
// #include "gtest/gtest.h"

#include <vector>
#include "example/HelloWorld.h"

namespace example {

SCENARIO( "HelloWorld says hello", "[helloworld]" ) {
  GIVEN( "A HelloWorld" ) {
    HelloWorld hw;

    WHEN( "vectors are added" ) {
      hw.append(std::vector<char>{ 'H','e','l','l','o' })
        .append(std::vector<char>{ ',',' ' })
        .append(std::vector<char>{ 'w','o','r','l','d' })
        .append(std::vector<char>{ '!' });

      THEN( "they come back in order" ) {
        auto s = hw.get();
        REQUIRE(std::string(s.begin(), s.end()) == "Hello, world!");
      }
    }
  }
}

} // namespace example
