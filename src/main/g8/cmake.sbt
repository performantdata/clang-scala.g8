import scala.sys.process._

lazy val cmakeSetup = taskKey[Unit]("Set up the C/C++ build environment.")
lazy val cmakeBuild = taskKey[Seq[File]]("Build the C/C++ code.")

cmakeSetup := {
  val cmakeBuildDir = target.value / "cmake"
  s"rm -rf \$cmakeBuildDir".!

  // Configure the CMake build to output generated Java into `sourceManaged`.
  val sourceManagedDir = sourceManaged.value / "main"
  s"cmake -S \${sourceDirectory.value} -B \$cmakeBuildDir -G Ninja -D SBT_SOURCE_MANAGED:PATH=\$sourceManagedDir".!
}

cmakeBuild := {
  cmakeSetup.value

  // Run the CMake build.
  s"cmake --build \${target.value}/cmake".!

  ((sourceManaged.value / "main") ** "*.java").get
}

Compile / sourceGenerators += (Compile / cmakeBuild).taskValue
