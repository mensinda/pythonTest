#!/usr/bin/python3

import swigLib

iterations = 1000000

sw = swigLib.Test()
sw.printHeadder( "SWIG" )
sw.pureCPPBench( iterations )

sw_cla = swigLib.ClassA()

print( "\nPython / SWIG test ( %s )" % "{:,}".format( iterations ) )

sw.startBench()
for i in range( iterations ):
  sw.testFN1( 1, i )
res = sw.stopBench()

print( "  ==> testFN1: %s" % "{:,}".format( res ) )

sw.startBench()
for i in range( iterations ):
  sw.testFN2( sw_cla )
res = sw.stopBench()

print( "  ==> testFN3: %s" % "{:,}".format( res ) )

sw.startBench()
for i in range( iterations ):
  sw.testFN3( sw_cla )
res = sw.stopBench()

print( "  ==> testFN3: %s" % "{:,}".format( res ) )

del sw_cla
del sw
