/* Quicksort is obviously well-known, but it is still very, very clever :) */

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define N (100)

void randomize(int *arr, int n) {
  int i;
  for(i=0; i < N; i++) {
    arr[i] = rand() % INT_MAX;
  }
}

void output(int *arr, int n) {
  int i;
  for(i=0; i < N; i++) {
    printf("%d\n", arr[i]);
  }
}

void merge(int *dst, int *lt, int lti , int pivot, int *gt, int gti) {
  int i,dsti=0;
  for(i=0; i < lti; i++) {
    dst[dsti++] = lt[i];
  }
  dst[dsti++] = pivot;
  for(i=0; i < gti; i++) {
    dst[dsti++] = gt[i];
  }
}

void quicksort(int *arr, int n) {
  if(n <= 1) {
    return;
  }
  int i;
  int pivoti = rand() % n;
  int pivot = arr[pivoti];
  int *lt = (int *)malloc(n * sizeof(int));
  int *gt = (int *)malloc(n * sizeof(int));
  int lti = 0, gti = 0;
  for(i = 0; i < n; i++) {
    if(i == pivoti) continue;
    if(arr[i] < pivot) {
      lt[lti] = arr[i];
      lti++;
    }
    else {
      gt[gti] = arr[i];
      gti++;
    }
  }
  quicksort(gt,gti);
  quicksort(lt,lti);
  merge(arr,lt,lti,pivot,gt,gti);
  free(lt);
  free(gt);
}

int main() {
  int *arr = (int *)malloc(N * sizeof(int));
  randomize(arr,N);
  output(arr,N);
  quicksort(arr,N);
  output(arr,N);
  free(arr);
  return 0;
}
