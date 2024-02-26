# Task Bonus - System calls

## Theory

In general, any interaction with the I/O (HDD, SSD, video card) can only be done by the operating system.
But in making the programs, we need to read files that are on a disk, so they can only be accessed by the operating system.
That's why there are system calls, which are the way a regular user can perform privileged operations, such as reading a file from disk.
Through a system call, we ask the operating system to perform a certain operation and return its result.
In assembly, the result of the system call is put in EAX.

A system call involves interrupting the operating system, using the special `int' instruction.
`int' receives as a parameter the interrupt number, which, in the case of system calls, is 0x80.
After receiving the interrupt, the operating system looks in the registers to identify what kind of system call it is.
It looks especially in the EAX, EBX, ECX, EDX registers.
In EAX is the interrupt number.
For example, the `exit' system call, which terminates the execution of a program, uses the value 1 in EAX.

## Requirement

Using system calls, read the contents of a text file, given as an argument to the function `replace_marco', and replace each occurrence of the word "Marco" with "Polo".
Write the new content to a new file, also given as an argument.

## Specifications
  * The task will be performed in 32-bit Assembly
  * You need the system calls `sys_open`, `sys_read`, `sys_write`, `sys_close`.
  * These system calls also exist in C, in the form of functions with the same name (without "sys_").
  * Attention: these system calls are specific to Linux. Other operating systems implement other system calls
  * You are not allowed to use external functions (eg `fgets') to open, close files or to write or read from files
  * There is no need to call `exit' at the end of the function
  * The files contain a maximum of 100 characters
  * In case of error, assembly system calls return -ERRNO, where ERRNO is a standard Linux error code.


## Punctuation

The task is worth 10p.
No points will be awarded if reading, writing, opening and closing files is not done with system calls.

## Useful resources

[ERRNO Codes](https://www.thegeekstuff.com/2010/10/linux-error-codes/)