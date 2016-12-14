from libcpp.string cimport string
from benchLib cimport Test
from benchLib cimport ClassA

cdef class PyTest:
  cdef Test   cpp_test
  cdef ClassA cpp_classa_obj
  def __cinit__( self ):
    self.cpp_test       = Test()
    self.cpp_classa_obj = ClassA()

  def testFN1( self, int a, int b ):
    return self.cpp_test.testFN1( a, b )

  def testFN2( self ):
    return self.cpp_test.testFN2( self.cpp_classa_obj )

  def testFN3( self ):
    return self.cpp_test.testFN3( &self.cpp_classa_obj )

  def printHeadder( self, name ):
    cdef string cpp_str = name
    self.cpp_test.printHeadder( cpp_str )

  def startBench( self ):
    self.cpp_test.startBench()

  def stopBench( self ):
    return self.cpp_test.stopBench()

  def pureCPPBench( self, i ):
    self.cpp_test.pureCPPBench( i )
