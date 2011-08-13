/* This prints the numbers 1..1000 with no loops or conditionals. From:
http://stackoverflow.com/questions/4568645/printing-1-to-1000-without-loop-or-
conditionals/4583502#4583502 */

#include <stdio.h>
#include <stdlib.h>

void main(int j) {
  printf("%d\n", j);
  (main + (exit - main)*(j/1000))(++j);
}
