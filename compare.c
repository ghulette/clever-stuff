// Implement compare without lessthan. From Andy.

#include <stdlib.h>
#include <stdio.h>

typedef unsigned int uint;

// Andy used this function instead of &&
uint zero(uint x) {
  return (x - 1) / 0xFFFFFFFF;
}

// My solution, only works for a != b != 0
uint umax(uint a, uint b) {
  uint t1 = (a / b) && ((a / b) / (a / b));
  uint t2 = (b / a) && ((b / a) / (b / a));
  return (a * t1) + (b * t2);
}

void test_umax(int n) {
  int i;
  srand(time(NULL));
  for(i = 0; i < n; i++) {
    uint n1 = rand() % 0xFFFF;
    uint n2 = rand() % 0xFFFF;
    uint n3 = umax(n1,n2);
    if(n3 == (n1 > n2 ? n1 : n2)) {
      printf("Ok: umax(%d,%d) = %d\n", n1, n2, n3);
    }
    else {
      printf("Failed: umax(%d,%d) = %d\n", n1, n2, n3);
    }
  }
}

int main() {
  test_umax(10);
  return 0;
}
