from libcpp.string cimport string
from benchLib cimport Test
from benchLib cimport ClassA

def runTest( int iter ):
  cdef Test   t   = Test()
  cdef ClassA cla = ClassA()
  cdef int i

  t.printHeadder( b"PURE Cython" )
  t.pureCPPBench( iter )

  print( "\nRAW Cython test ({:,} iterations; nanoseconds)".format( iter ) )

  t.startBench()
  for i in range( iter ):
    t.testFN1( 1, i )
  res = t.stopBench()

  print( "  ==> testFN1: {:,}".format( res ) )

  t.startBench()
  for i in range( iter ):
    t.testFN2( cla )
  res = t.stopBench()

  print( "  ==> testFN3: {:,}".format( res ) )

  t.startBench()
  for i in range( iter ):
    t.testFN3( &cla )
  res = t.stopBench()

  print( "  ==> testFN3: {:,}".format( res ) )
