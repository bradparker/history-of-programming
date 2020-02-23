mov rax, 0xc ; sys_brk
mov rdi, 0   ; address = 0
syscall

mov rsi, rax ; copy current end of data segment to rsi

add rax, 0x2 ; add 2 to end of existing data segment / allocate 2 bytes of memory
mov rdi, rax ; address = rax
mov rax, 0xc ; sys_brk
syscall

inc rsi              ; move rsi to next memory address
mov BYTE [rsi], 0x0a ; put newline
dec rsi              ; move back to beginning of 'buffer'

; The first two fibs are special

; First fib
mov rax, 0

; Print current fib
; Make int in rax a printable char
add rax, 48
; Move lower byte of rax to address stored in rsi
mov [rsi], al
; Call write with stdout to output to terminal
mov rax, 0x1 ; sys_write
mov rdi, 0x1 ; fd = stdout
mov rdx, 0x2 ; length = 2
syscall

; Set next fib and away we go
mov rax, 1

; First two state values
mov r8, 0
mov r9, 1

; Initialize counter
; I can't use rcx as my counter because sys_write uses it as a counter
mov r10, 0

; Print current fib, calculate next one
loop:
  add rax, 48
  mov [rsi], al

  mov rax, 0x1 ; sys_write
  mov rdi, 0x1 ; fd = stdout
  mov rdx, 0x2 ; length = 2
  syscall

  ; Calculate next fib
  mov rax, r8
  add rax, r9
  mov r8,  r9
  mov r9,  rax

  ; Increment counter
  inc r10
  ; Compare counter
  cmp r10, 6
  ; Loop if counter less than six
  jl loop

; Free memory
mov rax, 0xc ; sys_brk
mov rdi, rsi ; address = rsi (original location)
syscall

; Exit
mov rax, 0x3c ; sys_exit
mov rdi, 0    ; exit code = 0
syscall
