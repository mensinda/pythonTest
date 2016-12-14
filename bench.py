#!/usr/bin/python3

import sys, os
# Fix path for .so
os.environ["LD_LIBRARY_PATH"] = os.path.dirname(os.path.realpath(__file__))

import swigLib
import cythLib
import cythTest

def swigTest( sw, i ):
  sw.printHeadder( "SWIG" )
  sw.pureCPPBench( i )

  sw_cla = swigLib.ClassA()

  print( "\nPython / SWIG test ({:,} iterations; nanoseconds)".format( i ) )

  sw.startBench()
  for i in range( i ):
    sw.testFN1( 1, i )
  res = sw.stopBench()

  print( "  ==> testFN1: {:,}".format( res ) )

  sw.startBench()
  for i in range( i ):
    sw.testFN2( sw_cla )
  res = sw.stopBench()

  print( "  ==> testFN3: {:,}".format( res ) )

  sw.startBench()
  for i in range( i ):
    sw.testFN3( sw_cla )
  res = sw.stopBench()

  print( "  ==> testFN3: {:,}".format( res ) )



def cythonTest( cyth, i ):
  cyth.printHeadder( b"Cython" )
  cyth.pureCPPBench( i )

  print( "\nPython / Cython test ({:,} iterations; nanoseconds)".format( i ) )

  cyth.startBench()
  for i in range( i ):
    cyth.testFN1( 1, i )
  res = cyth.stopBench()

  print( "  ==> testFN1: {:,}".format( res ) )

  cyth.startBench()
  for i in range( i ):
    cyth.testFN2()
  res = cyth.stopBench()

  print( "  ==> testFN3: {:,}".format( res ) )

  cyth.startBench()
  for i in range( i ):
    cyth.testFN3()
  res = cyth.stopBench()

  print( "  ==> testFN3: {:,}".format( res ) )


iterations = 10000000
if len(sys.argv) > 1:
  iterations = int(sys.argv[1])

# init bindings
sw   = swigLib.Test()
cyth = cythLib.PyTest()

swigTest( sw, iterations )
print("\n\n")
cythonTest( cyth, iterations )
print("\n\n")
cythTest.runTest( iterations )

sw.startBench()
for i in range( iterations ):
  continue
res = sw.stopBench()
print( "\n\nEmpty python loop with {:,} iterations takes {:,} ns".format(iterations, res) )
