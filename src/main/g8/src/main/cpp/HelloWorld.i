%module example
%{
# include "example/HelloWorld.h"
%}

namespace example {

class HelloWorld {
public:
  HelloWorld();
  virtual ~HelloWorld();
};

}
