# Linux From Scratch – C Kernel Project Roadmap

> **Purpose**: build a real, minimal kernel from first principles in C, with just enough assembly to bootstrap execution. This is not a distribution and not a full Linux clone. It is a systems-learning project designed to expose how Linux *actually* works under the hood.

---

## Core Principles

- **Kernel-first**: everything grows from a single, stable kernel entry point
- **C-centric**: assembly is only used where the hardware requires it
- **Freestanding**: no libc, no runtime assumptions
- **Incremental**: kernel must remain bootable after every step
- **Read real code**: Linux source is a reference, not something to copy

---

## Kernel Foundation (Start Here)

**Goal**: establish a minimal execution anchor that never changes.

### What you build
- Bootable kernel image (GRUB / Multiboot)
- Assembly entry point (`start`)
- Transition into C (`kmain` / `kernel_main`)
- Minimal stack setup
- Basic output (serial preferred, VGA optional)
- Infinite idle loop

### What you learn
- What a kernel actually is (vs userland)
- The boot → kernel boundary
- How control is transferred into C
- Why freestanding code exists
- How little is required for a real kernel

### References (PDF-first)
- *Writing a Simple Operating System — from Scratch* — Nick Blundell
- *Intel® 64 and IA-32 Architectures SDM Vol. 1* (boot & execution model)

### Study Repos (do not copy)
- https://github.com/cfenollosa/os-tutorial
- https://github.com/mit-pdos/xv6-public
- https://github.com/klange/toaruos

> **Rule**: build this once. Keep it minimal and stable. All later subsystems plug into this kernel.

---

## 1. Boot → Protected Mode Kernel

### What you build
- Real-mode bootloader
- Switch to 32-bit protected mode
- Global Descriptor Table (GDT)
- Controlled jump into C kernel

### What you learn
- What happens before Linux runs
- Real mode vs protected mode
- Why segmentation exists

### References
- *Writing a Simple Operating System — from Scratch* — Nick Blundell

---

## 2. Interrupts & Syscalls (IDT Project)

### What you build
- Interrupt Descriptor Table (IDT)
- Timer interrupt (IRQ0)
- Keyboard interrupt (IRQ1)
- Software interrupt for syscalls

### What you learn
- How the CPU enters the kernel
- Why syscalls exist
- Kernel vs user boundary

### References
- *Intel® SDM Vol. 3A* — Interrupts & Exceptions

---

## 3. Physical Memory Manager

### What you build
- BIOS / bootloader memory map parsing
- Page frame bitmap allocator
- `alloc_page()` / `free_page()`

### What you learn
- What “free memory” really means
- Fragmentation and allocator trade-offs
- Linux memory intuition

### References
- *Linux Kernel Development* — Memory chapters
- OSDev Wiki — Physical Memory Management

---

## 4. Virtual Memory & Paging

### What you build
- Page directory and page tables
- Enable paging
- Identity + higher-half kernel mapping

### What you learn
- Why virtual memory exists
- Address translation
- Process isolation foundations

### References
- *Understanding the Linux Virtual Memory Manager* — Mel Gorman

---

## 5. Cooperative Scheduler

### What you build
- Task structure
- Context switching (save/restore registers)
- Round-robin cooperative scheduler

### What you learn
- What a process actually is
- Scheduling trade-offs
- Why preemption is hard

### References
- *Operating Systems: Three Easy Pieces* — Scheduling

---

## 6. Userspace ABI & Mini Syscall Layer

### What you build
- Syscall table
- Basic syscalls (`write`, `exit`, `getpid`)
- Defined ABI contract

### What you learn
- Why libc exists
- ABI stability
- Kernel entry mechanisms

### References
- *Linux System Programming* — Robert Love

---

## 7. Simple Filesystem (RAMFS)

### What you build
- In-memory filesystem
- Inodes and file descriptors
- `open`, `read`, `write`

### What you learn
- Why VFS exists
- Why “everything is a file”
- Filesystem abstraction

### References
- *Linux Kernel Filesystems* (IBM)

---

## 8. TTY & Console Driver

### What you build
- Keyboard driver
- Line discipline
- Terminal abstraction

### What you learn
- Why terminals behave strangely
- Shell ↔ kernel interaction
- TTY architecture

### References
- *Linux Device Drivers* — TTY chapters

---

## 9. init Process & Process Tree

### What you build
- PID 1 process
- Parent / child relationships
- Zombie reaping

### What you learn
- Linux boot lifecycle
- Why `init` is special
- Process hierarchy

---

## Recommended Build Order

1. Boot + GDT
2. Interrupts
3. Physical memory
4. Paging
5. Scheduler
6. Syscalls
7. Filesystem
8. TTY
9. init

---

## Kernel Rules (Non‑Negotiable)

- Compile freestanding (`-ffreestanding`, `-nostdlib`)
- Kernel must boot after every change
- Add one feature at a time
- Write minimal self-tests (panic on failure)
- After each milestone, read the matching Linux subsystem:
  - `arch/x86/`, `kernel/`, `mm/`, `fs/`, `drivers/tty/`

---

## Definition of Done

A kernel that:
- Boots reliably in QEMU
- Enters C deterministically
- Handles interrupts
- Manages memory
- Switches tasks
- Supports basic syscalls
- Provides a minimal filesystem

---

## Goal

This roadmap trains **systems thinking**, not tool usage. Completing even the first 3–4 stages deeply is enough to surpass most developers in low-level understanding.

