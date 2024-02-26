# Task Bonus - Assembly 64bit

The task of implementing a function that intertwines 2 vectors `void intertwine(int *v1, int n1, int *v2, int n2, int *v);', in 64-bit assembly.

By interpolation is meant the creation of a new vector, which contains, alternatively, the elements of the 2 vectors.

## Example
- v1 = 1 1 1 1
- v2 = 2 2
- interleaving: 1 2 1 2 1 1

## Attention

If one vector is longer than the other, its elements will be placed at the end of the resulting vector.

The header of the function is `void intertwine(int *v1, int n1, int *v2, int n2, int *v);`

The meaning of the parameters:
   v1 -> address of the first vector
   n1 -> length of the first vector
   v2 -> address of the second vector
   n2 -> length of the second vector
   v -> address of the resulting vector.
  
The function does not return anything, the result of the interpolation will be saved in the vector v, passed as a parameter.

## Punctuation

This task is worth 5 points.