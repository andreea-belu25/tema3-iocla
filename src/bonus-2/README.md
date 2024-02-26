# Task Bonus - AT&T

The task of implementing a function that adds 2 vectors of size `n', then subtracts from the resulting vector 3 numbers, defined by `#define` (`*_VALUE`), in `positions.h`, from the positions indicated also in `positions.h` (`*_POSITION`), in 32-bit assembly, using AT&T syntax.
\Positions must be scaled with the size of the vector, they being defined for a vector of size 10.

AT&T syntax is the 2nd syntax in which assembly code can be written for the x86 architecture.
This syntax is the only one understood by the GNU, GAS assembler and is the only one used in the Linux kernel.
As a convention, files using AT&T syntax have the `.S' extension, while Intel syntax files use the `.asm' extension.
Also, files with AT&T syntax can use GCC preprocessing directives such as `#define` and `#include`.

The differences between AT&T and Intel are important, especially in the way addressing is used and the order of assembly instruction arguments. For details, see the document in the ``Useful resources'' section of this document.

## Example
- n : 5
- v1: 1 2 3 4 5
- v2: 10 9 8 7 6

### Result after assembly:
11 11 11 11 11

### The numbers in `positions.h`:
- value: 10, position: 2, scaled position for n = 5: 1
- value: 127, position: 4, scaled position for n = 5: 2
- value: 21, position: 7, scaled position for n = 5: 3

### Final vector:
11 1 -116 -10 11

## Useful resources
- https://imada.sdu.dk/~kslarsen/dm546/Material/IntelnATT.htm

## Punctuation

This task is worth 10 points.

## Attention

Use the 'macro' functionality of assembly language to avoid repetitive code.
Duplication of pieces of code can bring punctuation on the coding-style side.