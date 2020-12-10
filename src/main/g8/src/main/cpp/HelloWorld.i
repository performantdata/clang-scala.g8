%module example
%{
#include "example/HelloWorld.h"
%}

%include "std_vector.i"

namespace std {
  %template(vector_UC) vector<unsigned char>;
};

namespace example {

class HelloWorld {
public:
  constexpr HelloWorld & append(std::vector<char> v);
  constexpr std::vector<char> get() const;
};

}
