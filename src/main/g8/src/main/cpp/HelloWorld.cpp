#include "example/HelloWorld.h"

namespace example {

HelloWorld &
HelloWorld::append(std::vector<char> v) {
  vec.insert(vec.end(), v.begin(), v.end());
  return *this;
}

std::vector<char>
HelloWorld::get() const { return vec; }

} // namespace example
