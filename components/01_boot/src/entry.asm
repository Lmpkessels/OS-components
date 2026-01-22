;
; an infinite loop that starts that tells BIOS to start the booting process.
;

loop:

    jmp loop                    ; jump to a new memory address to continue 
                                ; execution.

times 510 - ($ - $$) db 0       ; the block needs to contain 512 bytes.
                                ; so padd bytes containing 0s till 510 % 1 = 0, 
                                ; then room is left for the data word of 16 bits 
                                ; to starts the boot.

dw 0xaa55                       ; Write the 16-bit data word such that,
                                ; BIOS knows it's the boot sector.