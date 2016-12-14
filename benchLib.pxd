from libcpp.string cimport string

cdef extern from "cpp/classa.hpp":
  cdef cppclass ClassA:
    ClassA() except +
    int    getInt()
    string getStr()

cdef extern from "cpp/test.hpp":
  cdef cppclass Test:
    Test()
    int testFN1( int a, int b )
    int testFN2( ClassA a )
    int testFN3( ClassA *a )

    void printHeadder( string str )
    void              startBench()
    long unsigned int stopBench()

    void pureCPPBench( int iterations )
