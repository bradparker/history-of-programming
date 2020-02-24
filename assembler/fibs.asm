; Get program break
mov rax, 0xc ; sys_brk
mov rdi, 0   ; address = 0
syscall

; Copy current program break to rsi
; It's the register sys_write refers to when looking for
; the start of the buffer
mov rsi, rax

; Allocate 2 bytes of memory by moving program break
add rax, 0x2 ; new offset
mov rdi, rax ; address = rax
mov rax, 0xc ; sys_brk
syscall

; Always have a newline in second byte of buffer
inc rsi
mov BYTE [rsi], 0x0a
dec rsi

; The first two fibs are special

; First fib
mov rax, 0

; Print

; Make int in rax a printable char
add rax, 48
; Move lower byte of rax to address stored in rsi
mov [rsi], al
; Call write with stdout to output to terminal
mov rax, 0x1 ; sys_write
mov rdi, 0x1 ; fd = stdout
mov rdx, 0x2 ; length = 2
syscall

; Second fib
mov rax, 1

; Print
add rax, 48
mov [rsi], al
mov rax, 0x1 ; sys_write
mov rdi, 0x1 ; fd = stdout
mov rdx, 0x2 ; length = 2
syscall

; Previous two fibs, for iterating
mov r8, 0
mov r9, 1

; Counter
mov r10, 0

loop:
  ; Calculate current fib from previous two
  mov rax, r8
  add rax, r9

  ; Move the previous fib, include the current one
  mov r8,  r9
  mov r9,  rax

  ; Print current fib
  add rax, 48
  mov [rsi], al
  mov rax, 0x1 ; sys_write
  mov rdi, 0x1 ; fd = stdout
  mov rdx, 0x2 ; length = 2
  syscall

  ; Increment counter
  inc r10
  ; Compare counter
  cmp r10, 5
  ; Loop if counter less than five
  jl loop

; Free memory
mov rax, 0xc ; sys_brk
mov rdi, rsi ; address = rsi (original location)
syscall

; Exit
mov rax, 0x3c ; sys_exit
mov rdi, 0    ; exit code = 0
syscall
