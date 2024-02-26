# Task Bonus - Vector Instructions - SSE, AVX

## Theory moment

Computing systems can be of 4 types, depending on how many instructions are executed at the same time and how much data is processed at the same time: SISD, SIMD, MISD, MIMD.

- SISD (single instruction, single data) is the type used by you so far: a single instruction is executed at the same time and it is worked on only one date at the same time.
- MIMD (multiple instructions, multiple data): the subject of several subjects from the following years (APD, SO, ASC, APP).
In this type of architecture, several instructions can be executed simultaneously, which can operate on several data simultaneously, using threads.
- SIMD (single instruction, multiple data): the same instruction is executed on several data simultaneously. This type is the subject of an important part of the ASC course.
- MISD (multiple instructions, single data): very rare type.

Modern processors are of the MIMD type, as they have several cores, which in turn can have one or more threads.
However, these modern processors have also implemented SIMD type instructions, which are the purpose of this bonus task.

SIMD instructions, also called vector instructions, are [MMX](https://en.wikipedia.org/wiki/MMX_(instruction_set)), [SSE](https://en.wikipedia.org/wiki/Streaming_SIMD_Extensions) and [AVX](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions).
MMX is the first SIMD instruction set variant implemented on Intel processors, starting with the Intel Pentium P5.
SSE (Streaming SIMD Extensions) and AVX (Advanced Vector Extension) are improved variants of MMX instructions.
All instruction sets are used for operations on vectors, hence the name vector instructions.

Suppose we want to add 2 vectors of 8 elements each, of type int.
Until now, you would have used a for loop and added element by element.
The SIMD instructions allow us to perform all 8 additions simultaneously using only one AVX2 instruction, called VPADDD, or 2 SSE2/AVX instructions. The main difference between the MMX, SSE and AVX instruction sets is the number of bits that can be processed at the same time, AVX512 being the most powerful instruction set in this sense, being able to process 512 bits at the same time.

In order to perform these operations on vectors, the SIMD instructions use special registers: mm in the case of MMX, xmm in the case of SSE and AVX, ymm in the case of AVX2 and zmm in the case of AVX512.

## Requirement

You are required to implement a 64-bit assembly function, `vectorial_ops', which will receive a scalar, **s**, 3 vectors, **A**, **B** and **C** , and size of the vectors, **n**, and will perform the operation `D = s * A + B .* C`, where `.*` is the element-by-element multiplication of 2 vectors (`[1, 2, 3] .* [4, 5, 6] = [1 * 4, 2 * 5, 3 * 6] = [4, 10, 18]`).

The function has the following header:

`void vector_ops(int s, int A[], int B[], int C[], int n, int D[])`

The meaning of the parameters is:
   s -> a scalar
   A,B,C -> vectors
   n -> length of the vectors
   D -> the resulting vector

The function will not return anything, the result of the calculation is saved in the vector D, transmitted as a parameter!

## Remarks

- You can use any set of SIMD instructions to perform this task, depending on what you have available on the local machine.
To find out what capabilities your processor has, use the `cat /proc/cpuinfo' command.

- It is guaranteed that **n** is a multiple of 16.

- It is guaranteed that the result of any multiplication fits into an int (32 bits).

- If you use AVX to solve the theme, you will receive 0 points on VMchecker, because the machine on which the checker is running does not support AVX.
Mention in the comments or in the README that you used AVX, so we know that manual verification is needed.

## Punctuation

This task is worth 15 points.

## Useful resources

https://docs.oracle.com/cd/E36784_01/html/E36859/gntae.html

https://www.felixcloutier.com/x86/

https://www.intel.com/content/www/us/en/support/articles/000005779/processors.html