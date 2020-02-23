mov rax, 0xc ; sys_brk
mov rdi, 0   ; address = 0
syscall

mov rsi, rax ; copy current end of data segment to rsi

add rax, 0xe ; add 14 to end of existing data segment / allocate 14 bytes of memory
mov rdi, rax ; address = rax
mov rax, 0xc ; sys_brk
syscall

mov rcx, rsi         ; use rcx as cursor
mov BYTE [rcx], 0x48 ; Put first char at starting memory location
add rcx, 1           ; move cursor to next memory address
mov BYTE [rcx], 0x65 ; Put next char at cursor location
add rcx, 1           ; move cursor to next memory address
mov BYTE [rcx], 0x6c ; Etc ...
add rcx, 1
mov BYTE [rcx], 0x6c
add rcx, 1
mov BYTE [rcx], 0x6f
add rcx, 1
mov BYTE [rcx], 0x2c
add rcx, 1
mov BYTE [rcx], 0x20
add rcx, 1
mov BYTE [rcx], 0x77
add rcx, 1
mov BYTE [rcx], 0x6f
add rcx, 1
mov BYTE [rcx], 0x72
add rcx, 1
mov BYTE [rcx], 0x6c
add rcx, 1
mov BYTE [rcx], 0x64
add rcx, 1
mov BYTE [rcx], 0x21
add rcx, 1
mov BYTE [rcx], 0x0a

mov rax, 0x1 ; sys_write
mov rdi, 0x1 ; fd = stdout
mov rdx, 0xe ; length = 14
syscall

mov rax, 0xc ; sys_brk
mov rdi, rsi ; address = rsi (original location) / free memory
syscall

mov rax, 0x3c ; sys_exit
mov rdi, 0    ; exit code = 0
syscall
