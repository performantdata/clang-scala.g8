package $package$

/** Loads a JNI library with the given name.
  *
  * The library must be in the `LD_LIBRARY_PATH`.
  *
  * @param libraryName
  * 	system-independent name of the dynamic library to load, without the file extension or any "lib" prefix
  */
class JNILoader(libraryName: String) {
  System.loadLibrary(libraryName)
}
