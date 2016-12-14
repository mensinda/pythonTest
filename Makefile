SWIG        := /usr/bin/swig
CYTHON      := /usr/bin/cython

PYTHON_PATH := /usr/include/python3.5m/

SED         := /usr/bin/sed
RM          := /usr/bin/rm -f
CC          := /usr/bin/g++
CCFLAGS     := -Wall -fPIC -O3 -I./src -I$(PYTHON_PATH)
LDDFLAGS    := -shared -O3
SWIGFLAGS   := -Wall -c++ -python
CYTHONFLAGS := --cplus -3 -Wextra

objects_lib    = cpp/test.o cpp/classa.o
objects_swig   = swigLib_wrap.o
objects_cython = cythLib.o cythTest.o
objects = $(objects_lib) $(objects_swig) $(objects_cython)

VPATH = cpp

.PRECIOUS: %.cpp
.PHONY: all
all: _swigLib.so cythLib.so cythTest.so

cythLib.so:  benchLib.so cythLib.o
	$(CC) -o cythLib.so  $(LDDFLAGS) cythLib.o benchLib.so

cythTest.so:  benchLib.so cythTest.o
	$(CC) -o cythTest.so  $(LDDFLAGS) cythTest.o benchLib.so

_swigLib.so: benchLib.so $(objects_swig)
	$(CC) -o _swigLib.so $(LDDFLAGS) $(objects_swig)   benchLib.so

benchLib.so: $(objects_lib)
	$(CC) -o benchLib.so $(LDDFLAGS) $(objects_lib)

swigLib_wrap.cpp: swigLib.i
	$(SWIG) $(SWIGFLAGS) -o swigLib_wrap.cpp swigLib.i

cythLib.cpp: cythLib.pyx
	$(CYTHON) $(CYTHONFLAGS) cythLib.pyx -o cythLib.cpp

cythTest.cpp: cythTest.pyx
	$(CYTHON) $(CYTHONFLAGS) cythTest.pyx -o cythTest.cpp

%.o: %.cpp
	$(CC) -c $(CCFLAGS) $< -o $@

cpp/%.o: %.cpp
	$(CC) -c $(CCFLAGS) $< -o $@

.PHONY: clean
clean:
	$(RM) *.o cpp/*.o *.so *.cpp swigLib.py
