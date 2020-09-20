package $package$

import org.scalatest.freespec.AnyFreeSpec

/** Test the JNI API.
 * 
 */
class HelloWorldSpec extends AnyFreeSpec {
  "The HelloWorld native library" - {
    "loads" in {
      new JNILoader("HelloWorld")
    }

    "does something" in {
      val hello = new HelloWorld()
      hello.delete()
    }
  }
}
