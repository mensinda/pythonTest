SWIG        := /usr/bin/swig

PYTHON_PATH := /usr/include/python3.5m/

SED         := /usr/bin/sed
RM          := /usr/bin/rm -f
CC          := /usr/bin/g++
CCFLAGS     := -Wall -fPIC -O3 -I./src -I$(PYTHON_PATH)
SWIGFLAGS   := -Wall -c++ -python

objects_lib  = cpp/test.o cpp/classa.o
objects_swig = swigLib_wrap.o
objects_cython =
objects = $(objects_lib) $(objects_swig) $(objects_cython)

VPATH = cpp

.PHONY: all
all: _swigLib.so

_swigLib.so: benchLib.so $(objects_swig)
	$(CC) -o _swigLib.so -shared $(objects_swig) benchLib.so

benchLib.so: $(objects_lib)
	$(CC) -o benchLib.so -shared $(objects_lib)

swigLib_wrap.cpp: swigLib.i
	$(SWIG) $(SWIGFLAGS) -o swigLib_wrap.cpp swigLib.i

%.o: %.cpp
	$(CC) -c $(CCFLAGS) $< -o $@

cpp/%.o: %.cpp
	$(CC) -c $(CCFLAGS) $< -o $@

.PHONY: clean
clean:
	$(RM) *.o cpp/*.o *.so *.cpp swigLib.py
