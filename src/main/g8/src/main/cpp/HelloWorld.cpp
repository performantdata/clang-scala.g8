#include <iostream>
#include "example/HelloWorld.h"
using namespace std;

namespace example {

  HelloWorld::HelloWorld() {
    cout << "Hello world!";
  }

  HelloWorld::~HelloWorld() {
    cout << "Goodbye, cruel world!";
  }

} /* namespace example */
