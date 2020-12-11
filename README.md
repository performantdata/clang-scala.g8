# A [Giter8][g8] template for combined Clang/Scala projects.

This template generates a skeleton project that contains both Clang and Scala code.
The goal is to make all of this work together in a natural way.
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

The template **does not** generate IDE-specific files; that's left to the user, as follows.
(There's nothing about these instructions that's specific to this template.
 These are the usual ways of importing Scala and Clang projects.)

### [Eclipse CDT][cdt] (C/C++)

I'll assume that you have Eclipse CDT configured for the Clang/LLVM toolchain, and Cmake4eclipse.
If not, read [my blog post on installing these tools][blog-clang].

To import the project:

- Follow the instructions on <https://github.com/sbt/sbteclipse>.
  This adds the Scala and Java natures and sets up the source directory.
- From the menu, choose File &gt; Import… &gt; Existing Projects into Workspace.
  Choose the directory that the template created.
- In the Project Explorer view, open the menu on the project directory,
  choose New &gt; Convert to a C/C++ Project (Adds C/C++ Nature).

Delete the `CMakeLists.txt` and `*.cpp` files that the Eclipse wizard created in the project directory.

In the project's <kbd><samp>Properties</samp></kbd> page,
under <kbd><samp>C/C++ Build &gt; Cmake4eclipse &gt; Host OS overrides,
for the "Buildscript generator (-G)", choose Ninja.
Under C/C++ Build &gt; Environment,
for the <samp>Configuration</samp> "[ All configurations ]",
set the `CC` and `CXX` variables to your `clang` and `clang++` paths, respectively.

### [IntelliJ IDEA][idea]

#### C++
I don't have [the IntelliJ C++ trial-use products][intellij-cpp], so can't help you there.

#### Scala
For the Scala product, import the project as an sbt project.
It seems to be necessary to ["Use sbt shell" "for builds"][ideasbt],
due to the inclusion of CMake CLI calls in the sbt build configuration confusing the internal builder.

In order to get the `HelloWorldSpec` test to succeed,
it's necessary to set the environment variable `LD_LIBRARY_PATH` to `target/cmake/main/cpp:$LD_LIBRARY_PATH`
in its run configuration.

### [VSCodium][vscodium]

Not really an IDE, just an editor, but with much of the functionality.

[g8]: http://www.foundweekends.org/giter8/
[mod]: https://cliutils.gitlab.io/modern-cmake/chapters/basics/structure.html
[blog-clang]: https://blog.performantdata.com/
[buster-backports]: https://backports.debian.org/Instructions/
[cdt]: https://www.eclipse.org/cdt/
[cmake-env]: https://cmake.org/cmake/help/latest/manual/cmake-env-variables.7.html#environment-variables-for-languages
[idea]: https://www.jetbrains.com/idea/
[ideasbt]: https://www.jetbrains.com/help/idea/sbt-support.html#sbt_settings
[intellij-cpp]: https://www.jetbrains.com/cpp/
[sbt-directories]: https://www.scala-sbt.org/1.x/docs/Directories.html
[sbt-download]: https://www.scala-sbt.org/download.html
[vscodium]: https://vscodium.com/
