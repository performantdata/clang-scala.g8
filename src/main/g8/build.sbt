organization := "$package$"
scalaVersion := "2.13.3"

name := "$name;format="normalize"$"

import scala.sys.process._

lazy val cmakeSetup = taskKey[Unit]("Set up the C/C++ build environment.")
lazy val cmakeBuild = taskKey[Seq[File]]("Build the C/C++ code.")

cmakeSetup := {
  s"rm -rf " !

  // Configure the CMake build to output generated Java into `sourceManaged`.
  s"cmake -S \${sourceDirectory.value} -B \${target.value}/cmake -G Ninja -D SBT_SOURCE_MANAGED:PATH=\${sourceManaged.value}" !
}

cmakeBuild := {
  cmakeSetup.value

  // Run the CMake build.
  s"cmake --build \${target.value}/cmake" !

  ((sourceManaged.value / "cmake") ** "*.java").get
}

Compile / sourceGenerators += cmakeBuild.taskValue
