# libasm: 42 School Assembly Language Library 💻🔧


[![42 School](https://img.shields.io/badge/42-School-blue)](https://42firenze.it/)
[![GitHub license](https://img.shields.io/github/license/Nazar963/42_libasm)](https://github.com/Nazar963/42_libasm/blob/main/LICENSE)
[![Build Status](https://img.shields.io/github/actions/workflow/status/Nazar963/42_libasm/.github/workflows/build.yml?branch=main)](https://github.com/Nazar963/42_libasm/.github/workflows/build.yml)
[![Bonus](https://img.shields.io/badge/Bonus-Fully_Implemented-green)](https://github.com/Nazar963/42_libasm)

A low-level programming project implementing standard C library functions in x86_64 assembly language, providing direct hardware interaction and performance optimization.

**Project Status**: ✅ All mandatory and bonus functions implemented

## Table of Contents 📖
- [Project Overview](#project-overview)
- [Implemented Functions](#implemented-functions)
- [Technical Details](#technical-details)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Performance](#performance)
- [Learning Resources](#learning-resources)
- [Acknowledgments](#acknowledgments)
- [License](#license)

## Project Overview

Libasm is a 42 School project focused on writing assembly language implementations of standard C library functions. This project:
- Introduces x86_64 assembly programming
- Demonstrates system call interfaces
- Explores low-level memory manipulation
- Compares performance with standard libraries
- Develops understanding of CPU registers and instructions

**Project Requirements**:
- Implement functions in NASM syntax (Intel flavor) ✅
- Create a static library `libasm.a` ✅
- Handle 64-bit Linux system calls ✅
- Include comprehensive testing ✅
- Bonus: Implement additional functions and data structures ✅

**Current Status**: All mandatory functions and all bonus functions are implemented and working.

## Implemented Functions

### Mandatory Functions (100% Complete)
| Function | Description | Prototype |
|----------|-------------|-----------|
| `ft_strlen` | Calculate string length | `size_t ft_strlen(const char *s)` |
| `ft_strcpy` | Copy string | `char *ft_strcpy(char *dest, const char *src)` |
| `ft_strcmp` | Compare strings | `int ft_strcmp(const char *s1, const char *s2)` |
| `ft_write` | Write to file descriptor | `ssize_t ft_write(int fd, const void *buf, size_t count)` |
| `ft_read` | Read from file descriptor | `ssize_t ft_read(int fd, void *buf, size_t count)` |
| `ft_strdup` | Duplicate string | `char *ft_strdup(const char *s)` |

### Bonus Functions (Implemented) ✅
| Function | Status | Description |
|----------|--------|-------------|
| `ft_atoi_base` | ✅ Implemented | Convert string to integer with custom base |
| `ft_list_push_front` | ✅ Implemented | Add element to list head |
| `ft_list_size` | ✅ Implemented | Count elements in list |
| `ft_list_remove_if` | ✅ Implemented | Conditional element removal |

## Technical Details

### Assembly Syntax
```asm
; Example: ft_strlen implementation
section .text
    global ft_strlen

ft_strlen:
    cmp rdi, 0
    je _error_handle
    xor rcx, rcx        ; Clear counter register
.loop:
    cmp byte [rdi + rcx], 0
    je _done
    inc rcx
    jmp .loop
_done:
    mov rax, rcx        ; Return length in RAX
    ret
```

### Key Concepts
1. **Register Usage**:
   - Function arguments: RDI, RSI, RDX, RCX, R8, R9
   - Return value: RAX
   - Preserved registers: RBX, RSP, RBP, R12-R15

2. **System Calls**:
   - `write`: syscall 1
   - `read`: syscall 0
   - `malloc`: syscall 9 (via libc)
   - `exit`: syscall 60

3. **Memory Management**:
   - Stack allocation for local variables
   - Heap allocation via `malloc` in `ft_strdup`
   - Proper stack alignment (16-byte boundary)

4. **Error Handling**:
   - Set `errno` appropriately
   - Return -1 on error
   - Preserve registers across function calls

## Installation

### Requirements
- NASM (Netwide Assembler)
- GNU Make
- GCC (for testing and linking)
- 64-bit Linux environment

### Compilation
```bash
# Clone repository
git clone https://github.com/Nazar963/42_libasm.git
cd 42_libasm

# Build library
make

# Build library and test program
make re

# Run test program
./run
```

### Makefile Targets
```makefile
all          # Compile mandatory functions
compile      # Compile main.s and link with libasm.a
fin          # Create executable 'run'
clean        # Remove object files
fclean       # Remove objects, library, and executable
re           # Rebuild everything (fclean + all + compile)
```

## Usage

### Include in Projects
1. **Create a header file** (recommended):
   ```bash
   # Create libasm.h
   cat > libasm.h << 'EOF'
   #ifndef LIBASM_H
   # define LIBASM_H
   # include <unistd.h>
   # include <stdlib.h>
   
   size_t ft_strlen(const char *s);
   char *ft_strcpy(char *dest, const char *src);
   int ft_strcmp(const char *s1, const char *s2);
   ssize_t ft_write(int fd, const void *buf, size_t count);
   ssize_t ft_read(int fd, void *buf, size_t count);
   char *ft_strdup(const char *s);
   
   // Bonus functions
   int ft_atoi_base(char *str, char *base);
   void ft_list_push_front(void **list, void *data);
   int ft_list_size(void *list);
   void ft_list_remove_if(void **list, void *data_ref, int (*cmp)(), void (*free_fct)());
   
   #endif
   EOF
   ```

2. Add to compilation:
   ```bash
   gcc your_program.c -L. -lasm -o program
   ```

3. Use in your code:
   ```c
   #include "libasm.h"
   
   int main() {
       char *str = "Hello Assembly!";
       size_t len = ft_strlen(str);
       char *copy = ft_strdup(str);
       // ... 
       free(copy);
       return 0;
   }
   ```

### Testing Individual Functions
```bash
# Build and run the main test program
make re
./run
```

## Testing

### Test Framework
The project includes a comprehensive test program in `main.s` that tests all implemented functions:

```asm
; Example test structure from main.s
section .data
    loco1 db "Hello, World!",10,0
    loco2 db "What's your name?",10,0
    test1 db "Hi its me",0
    test11 db "Ho its me",0
    ; ... more test cases

section .text
    extern ft_strlen
    extern ft_strcpy
    extern ft_strcmp
    extern ft_write
    extern ft_read
    extern ft_strdup
```

### Running Tests
```bash
# Build and run all tests
make re
./run

# The program will output test results for each function
```

## Performance

This implementation focuses on learning assembly language fundamentals rather than extreme optimization. The functions provide a direct translation of standard C library functions to assembly, demonstrating:

### Key Assembly Features Used
1. **Direct System Calls**: `ft_write` and `ft_read` use direct syscall instructions
2. **Register Usage**: Efficient use of x86_64 calling convention registers
3. **Error Handling**: Proper errno setting via `__errno_location`
4. **Memory Management**: Manual stack and heap management
5. **String Operations**: Byte-by-byte processing with conditional jumps

### Educational Value
- Understanding x86_64 calling conventions
- Learning system call interfaces
- Practicing register management
- Implementing error handling in assembly

## Learning Resources

1. **Assembly References**:
   - [Intel x64 Manual](https://software.intel.com/en-us/articles/intel-sdm)
   - [NASM Documentation](https://nasm.us/doc/)
   - [System Call Table](https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md)

2. **Tutorials**:
   - [ASM Beginner's Guide](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
   - [Linux Assembly Howto](http://tldp.org/HOWTO/Assembly-HOWTO/)
   - [x86 Cheat Sheet](https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf)

3. **Advanced Topics**:
   - [SIMD Optimization](https://stackoverflow.com/questions/11228855/header-files-for-x86-simd-intrinsics)
   - [Branch Prediction](https://stackoverflow.com/questions/11227809/why-is-processing-a-sorted-array-faster-than-processing-an-unsorted-array)
   - [Memory Alignment](https://software.intel.com/en-us/articles/data-alignment-when-migrating-to-64-bit-intel-architecture)

## Acknowledgments

- **42 School** for the challenging project
- **Intel** for processor documentation
- **NASM Developers** for the assembler
- **Peer reviewers** at 42 Network
- **Low-level programming community** for resources

## 🤝 Contributing
Feel free to submit issues or pull requests if you have suggestions for improving the application or adding more features.

## License
This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

## 📧 Contact
For questions or feedback, please open an issue in the repository.

## ⭐ Star this repository if you found it helpful!
[![GitHub stars](https://img.shields.io/github/stars/Nazar963/42_libasm?style=social)](https://github.com/Nazar963/42_libasm/stargazers)

---

🧠 *"The ultimate exercise in understanding how computers really work!"*  
[![42 School](https://img.shields.io/badge/42-profile-blue)](https://profile-v3.intra.42.fr/users/naal-jen)
[![GitHub Profile](https://img.shields.io/badge/GitHub-Nazar963-lightgrey)](https://github.com/Nazar963)
[![GitHub Follow](https://img.shields.io/github/followers/Nazar963?style=social)](https://github.com/Nazar963)

---

## 🍀 Goodluck:
Good luck with your libasm project at 42! 🚀
