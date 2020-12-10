#ifndef EXAMPLE_HELLOWORLD_H_
#define EXAMPLE_HELLOWORLD_H_

#include <vector>

namespace example {

/** A simple example of passing vectors. */
class HelloWorld {
private:
  std::vector<char> vec;

public:
  /** Append the given vector to our internal vector.
   *
   * @return this object
   */
  HelloWorld & append(std::vector<char> v);

  /** Return our internal vector. */
  std::vector<char> get() const;
};

}

#endif // EXAMPLE_HELLOWORLD_H_
