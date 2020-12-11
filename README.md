![test status](https://github.com/performantdata/clang-scala.g8/workflows/test/badge.svg)

# A [Giter8][g8] template for combined Clang/Scala projects

This template generates a skeleton project that contains both Clang and Scala code.
The goal is to make all of this work together in a natural way.
It's aimed at Scala and Java developers who aren't up-to-date on C++ environment setup,
and aims to get them started with a working example.

Specific goals (not all achieved yet) are:

- The project's directory structure supports multiple languages in a natural way.
  I should be able to mix Scala Native and Java HotSpot tests into the project
  in order to build and test linkages to those environments.
  Adding tests for other language environments, like Python, may also become desirable.
  (GraalVM may obviate the need for all these variations in the future.)
  The emphasis, though, is on developing mostly in C++ and testing against a small amount of Scala/Java/etc. code.

- It's possible to run builds and tests equally well from the command line or the IDE,
  with sbt controlling the whole.
- `cmake` at the command line builds, tests and packages all the Clang code.
- `sbt` at the command line builds, tests and packages everything.
- The IDE shows Doxygen documentation when I hover over terms.
- I can use either libstdc++ or libc++, as needed.

## OS configuration

The definitive instructions for setting up the operating system's environment
are found in the continuous integration tests,
located in [the GitHub Workflow for this project](.github/workflows/test.yml).
Instructions are only given for Debian 10 currently.

### Debian 10
Prepare Aptitude per the [sbt download][sbt-download] and [backports instructions][buster-backports].
I added backports in order to pick up a 3.14+ CMake.

Sbt, CMake, Ninja, Clang and Doxygen are installed in the usual Debian way. It's probably useful to pick up a few extras, too:
```shell
sudo aptitude install doxygen-gui doxygen-doc openjdk-11-jdk swig sbt
sudo aptitude -t buster-backports install cmake-qt-gui cmake-doc clang-8 clang-8-doc libc++1-8 ninja-build
```

## running it
### Giter8

An instance of this Giter8 template is created in the usual way:
```shell
sbt new performantdata/clang-scala.g8
```
The below assumes that you've changed into the created directory, the one with the name that you entered.

### `cmake`

Though the CMake files theoretically support a range of CMake versions,
they've actually only been tested with 3.16.3.

The top-level `CMakeLists.txt` file is in the `src/` directory, so in the root directory, invoke:

```shell
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
cmake -S src -B target/cmake -G Ninja
cmake --build target/cmake
(cd target/cmake; ctest -VV)
```

setting the environment as described [here][cmake-env].
You may need to adjust the compiler paths from the above example.
(Placing the environment settings in your login script may help keep from forgetting to set them,
but then they affect every process. Your choice.)

### `sbt`
TBD

## directory structure

The directory layout may be unfamiliar to a typical C/C++ coder, who might have seen something more like [this][mod].
It instead follows [the standard sbt structure][sbt-directories], which has been in use in the Java world for decades.
- It extends it by adding directories `src/main/cpp/` and `src/test/cpp/` for C/C++ source code for the product and the tests, respectively.
  There is a corresponding `src/main/include/` for the distributed include files.
  The top-level `CMakeLists.txt` file is in the `src/` directory.
- Build outputs are placed into `target/cmake/` (instead of the usual `build/`).

You can think of it as two overlapping trees: one for the sbt build, and one for the CMake build (which the sbt build calls).

## IDE configuration

This is discussed on [a separate page](doc/IDE.md).

## further reading

The following tools are commonly used in C++ development. This is an opinionated list.

- [Clang]

  Some use [GCC] rather than Clang, but that's not the direction that I'm going.
  Future versions of this project will interface with OpenJDK's new GraalVM, which requires LLVM IR.

- [SWIG]

  Some use Java tools like `javac -h` to generate a JNI API from Java code.
  The advantage of SWIG is that it works from a C/C++ header-like syntax, generating the APIs for other languages.
  So it can not only generate a JNI API, but also APIs for Python, etc. from the same specification.

  Eventually, as GraalVM matures, I would hope that other languages would adopt it as their runtime.
  Then there would be no need for SWIG. But that's years away.

- [CMake]

  If you're new to CMake, [the tutorial][cmake-tut] is an obvious place to start,
  but I found that reading about [its build system][cmake-buildsystem] in parallel helps.
  [The language description][cmake-language] is also enlightening on basic syntax.
  For a more gradual description via examples, you may find
  [_CMake Cookbook_ (2018)][cmake-cookbook] online via your local library.

- [Ninja]

  If you're new to Ninja, just think of it as an intermediate representation for build scripting.
  Or as UNIX Makefiles, stripped down for fast execution.
  You shouldn't need to work with Ninja code directly.

- [Catch2]

  Some use [Googletest] rather than Catch2, but I prefer the BDD style.

- [Doxygen]

## related work

Similar instructions to these can be found in the book [_Advanced C++_ (2019)][advanced-c++],
which may be available online through your library.
(I started on this project well before discovering this book.)

Mizux Seiha maintains [a project demonstrating a polyglot CMake + SWIG project][mizux-cmake-swig].
It addresses CI, portable CMake, and SWIG code generation for Java/Python/.NET with language-specific tests and packaging,
but doesn't go so far as to make it a template for new projects.
My project doesn't care about CMake portability, since I expect high-performance code to run only on Linux.
It's also intended for non-trivial development in the targeted scripting languages in an IDE,
for providing a portable fallback implementation should a native code version be unavailable.


[advanced-c++]: https://en.wikipedia.org/wiki/Special:BookSources?isbn=9781838821135
[buster-backports]: https://backports.debian.org/Instructions/
[catch2]: https://github.com/catchorg/Catch2
[clang]: https://clang.llvm.org/
[cmake]: https://cmake.org/
[cmake-buildsystem]: https://cmake.org/cmake/help/v3.18/manual/cmake-buildsystem.7.html
[cmake-cookbook]: https://en.wikipedia.org/wiki/Special:BookSources?isbn=1788470710
[cmake-env]: https://cmake.org/cmake/help/latest/manual/cmake-env-variables.7.html#environment-variables-for-languages
[cmake-language]: https://cmake.org/cmake/help/latest/manual/cmake-language.7.html
[cmake-tut]: https://cmake.org/cmake/help/latest/guide/tutorial/index.html
[doxygen]: https://www.doxygen.nl/
[g8]: http://www.foundweekends.org/giter8/
[gcc]: https://gcc.gnu.org/
[googletest]: https://github.com/google/googletest
[mizux-cmake-swig]: https://github.com/Mizux/cmake-swig
[mod]: https://cliutils.gitlab.io/modern-cmake/chapters/basics/structure.html
[ninja]: https://ninja-build.org/
[sbt-directories]: https://www.scala-sbt.org/1.x/docs/Directories.html
[sbt-download]: https://www.scala-sbt.org/download.html
[swig]: http://www.swig.org/
