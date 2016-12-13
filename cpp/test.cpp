/*
 * Copyright (c) 2016, <copyright holder> <email>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *     * Neither the name of the <organization> nor the
 *     names of its contributors may be used to endorse or promote products
 *     derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY <copyright holder> <email> ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <copyright holder> <email> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#include "test.hpp"
#include <iostream>
#include <locale>

namespace DARK_MAGIC {

// Turns off the optimizer
void escape( void *p ) { asm volatile( "" : : "g"( p ) : "memory" ); }
void               clobber() { asm volatile( "" : : : "memory" ); }
}


void Test::printHeadder( std::string str ) {
  std::cout << "          PYTHON BINDING TEST" << std::endl
            << "          ===================" << std::endl
            << std::endl
            << "  -- Binding Tool: " << str << std::endl
            << std::endl;
}

int Test::testFN1( int a, int b ) { return a + b; }
int Test::testFN2( ClassA a ) { return a.getInt() + a.getStr().size(); }
int Test::testFN3( ClassA *a ) { return a->getInt() + a->getStr().size(); }


void Test::startBench() { benchStart = std::chrono::high_resolution_clock::now(); }

long unsigned int Test::stopBench() {
  TP                       end             = std::chrono::high_resolution_clock::now();
  std::chrono::nanoseconds elapsed_seconds = end - benchStart;
  return elapsed_seconds.count();
}

void Test::pureCPPBench( int iterations ) {
  int      res;
  uint64_t t1;
  uint64_t t2;
  uint64_t t3;

  std::cout.imbue( std::locale( "" ) );
  std::cout << "Pure C++ bench (" << iterations << " iterations; nanoseconds):" << std::endl;

  startBench();
  for ( int i = 0; i < iterations; i++ ) {
    res = testFN1( 0, i );
    DARK_MAGIC::escape( &res );
  }
  t1 = stopBench();

  std::cout << "  ==> testFN1: " << t1 << std::endl;

  startBench();
  for ( int i = 0; i < iterations; i++ ) {
    res = testFN2( c1 );
    DARK_MAGIC::escape( &res );
  }
  t2 = stopBench();

  std::cout << "  ==> testFN2: " << t2 << std::endl;

  startBench();
  for ( int i = 0; i < iterations; i++ ) {
    res = testFN3( &c1 );
    DARK_MAGIC::escape( &res );
  }
  t3 = stopBench();

  std::cout << "  ==> testFN3: " << t3 << std::endl << std::endl;
}
