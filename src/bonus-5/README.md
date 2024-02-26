# Task Bonus - Floating Point

## Theory

All modern processors have a set of special instructions, which know how to do floating point calculations.
These calculations are performed by a component of the processor, called **Floating Point Unit** (FPU).
Floating-point instructions do not use registers, but only a special stack, separate from the normal program stack, and memory.
All floating point instructions act on the top of the special stack, denoted `SP(0)', together with a memory location or the next element on the stack, `SP(1)'.

A function that returns a float value will put that value on the top of the 32-bit floating-point stack.
On 64 bits, value will be put in `xmm0` (vector register).

## Requirement

Write the `do_math' function, which receives 3 float type parameters, **x**, **y** and **z** and returns the result of the calculation `x * sqrt(2) + y * sin(z * PI * 1 / e)`, using 32-bit Assembly.

## Punctuation

This task is worth 15 points.

## Specifications

**PI** and **e** cannot be declared as variables by you.
They must be found out / used only through the instructions provided by the FPU.

## References

[https://docs.oracle.com/cd/E18752_01/html/817-5477/eoizy.html](FPU Instructions)