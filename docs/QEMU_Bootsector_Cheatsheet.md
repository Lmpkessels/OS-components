# QEMU Bootsector Cheatsheet
### x86 · BIOS · NASM · OS Development

## What is QEMU?
- QEMU is an emulator project
- There is NO generic `qemu` command on modern Ubuntu
- You must use architecture-specific binaries

## QEMU Command Families

### qemu-system-* (FULL MACHINE)
Use this for OS development.
Emulates CPU, RAM, BIOS/UEFI, disk, and devices.

Examples:
- qemu-system-i386
- qemu-system-x86_64
- qemu-system-arm

### qemu-user-* (USER MODE)
Runs single Linux programs only.
No BIOS, no booting, no kernel.

## Golden Rule
If you are booting something, use qemu-system-*

## Assemble Boot Sector
nasm boot_sect.asm -f bin -o boot_sect.bin

## Run Boot Sector
qemu-system-i386 -drive format=raw,file=boot_sect.bin

## Minimal Boot Sector
[org 0x7c00]
mov ah, 0x0e
mov al, 'X'
int 0x10
jmp $
times 510-($-$$) db 0
dw 0xaa55

## Boot Sector Rules
- Exactly 512 bytes
- Ends with 0xAA55
- Loaded at 0x7C00

## Common Mistakes
- Using `qemu`
- Typo: qemu-systems-i386
- Assembling .bin files
- Missing boot signature

## Useful Flags
-no-reboot
-monitor stdio
-d int
