# 1
# Assume you have a 64 bit program that calls printf
# a.asm
nasm -f elf64 -l a.lst  a.asm
gcc -m64 -o a a.o

# 2
# Compile with: 
nasm -f elf twoString.asm
# Link with (64 bit systems require elf_i386 option): 
ld -m elf_i386 twoString.o -o twoString
./helloworld

# 3
# make syscall32.inc with grep magic:
grep __NR /usr/include/asm/unistd_32.h | grep define | sed -e 's/\#/\%/' -e 's/__NR_/sys_/' > syscalls32.inc
# Compile with:
nasm -f elf array.asm
# Link with
ld -m elf_i386 array.o -o array
