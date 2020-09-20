#include <iostream>
#include "example/HelloWorld.h"

namespace example {

  HelloWorld::HelloWorld() {
    std::cout << "Hello world!";
  }

  HelloWorld::~HelloWorld() {
    std::cout << "Goodbye, cruel world!";
  }

} // namespace example
