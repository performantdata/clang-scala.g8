# IDE configuration

The template **does not** generate IDE-specific files; that's left to the user, as follows.
(There's nothing about these instructions that's specific to this template.
These are the usual ways of importing Scala and Clang projects.)

## [Eclipse CDT][cdt] (C/C++)

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
under <kbd><kbd><samp>C/C++ Build</samp></kbd> &gt;
  <kbd><samp>Cmake4eclipse</samp></kbd> &gt;
  <kbd><samp>Host OS overrides</samp></kbd></kbd>,
for the "Buildscript generator (-G)", choose Ninja.
Under C/C++ Build &gt; Environment,
for the <samp>Configuration</samp> "[ All configurations ]",
set the `CC` and `CXX` variables to your `clang` and `clang++` paths, respectively.

## [IntelliJ IDEA][idea]

### C++
I don't have [the IntelliJ C++ trial-use products][intellij-cpp], so can't help you there.

### Scala
For the Scala product, import the project as an sbt project.
It seems to be necessary to ["Use sbt shell" "for builds"][ideasbt],
due to the inclusion of CMake CLI calls in the sbt build configuration confusing the internal builder.

In order to get the `HelloWorldSpec` test to succeed,
it's necessary to set the environment variable `LD_LIBRARY_PATH` to `target/cmake/main/cpp:$LD_LIBRARY_PATH`
in its run configuration.

## [VSCodium][vscodium]

VSCodium is a free-software build of Visual Studio Code.
Not really an IDE, just an editor, but with much of the functionality.
[The instructions for installing on Debian “buster” with backports][vscodium-install] are available on the VSCodium site.
Once in the application, install the “Scala (Metals)” and “CMake” extensions.

[Clang's own instructions][clang-get-started] only cover using it with Visual Studio, not Eclipse or VSCodium.


[blog-clang]: https://blog.performantdata.com/
[cdt]: https://www.eclipse.org/cdt/
[clang-get-started]: https://clang.llvm.org/get_started.html
[idea]: https://www.jetbrains.com/idea/
[ideasbt]: https://www.jetbrains.com/help/idea/sbt-support.html#sbt_settings
[intellij-cpp]: https://www.jetbrains.com/cpp/
[vscodium]: https://vscodium.com/
[vscodium-install]: https://github.com/VSCodium/vscodium#install-with-package-manager
