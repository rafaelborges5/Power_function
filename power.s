
.text
intro:      .asciz "\nRafael and Lubov\nrafaelborges and lchalakova\nPowers\nWelcome to the program!\n"
base:     .asciz "Please insert a digit for the base number: "
exponent:   .asciz "Please insert a digit for the exponent number: "
formatstr:   .asciz "%ld"
result:    .asciz "The result is: %ld \n"


.global main

main:

    #prologue
    pushq   %rbp  #push the base pointer
    movq   %rsp, %rbp   #copy stack pointer value to base pointer

    movq   $0, %rax    #no vector registers in use for printf
    movq   $intro, %rdi  #first parameter:  welcome string
    call   printf    #call printf to print intro

    
    movq   $0, %rax    #no vector registers in use for printf
    movq   $base, %rdi  #first parameter:  welcome string
    call   printf    #call printf to print intro

    subq $16, %rsp  #allocate stack space for the variable
    leaq -8(%rbp), %rsi #load address of stack variable into rsi
    movq $formatstr, %rdi #load the first argument of scanf
    movq $0, %rax #no vector registers for scanf
    call scanf #call scanf


    movq   $0, %rax    #no vector registers in use for printf
    movq   $exponent, %rdi  #first parameter:  welcome string
    call   printf    #call printf to print intro

    leaq -16(%rbp), %rsi #load address of stack variable into rsi
    movq $formatstr, %rdi #load the first argument of scanf
    movq $0, %rax #no vector registers for scanf
    call scanf #call scanf

    popq %rsi  #pop the exponent from stack into rsi
    popq %rdi  #pop the base from stack into rdi
    call pow  #call pow
    
    movq %rax, %rsi  #copy the value from rax into rsi
    movq   $0, %rax    #no vector registers in use for printf
    movq   $result, %rdi  #first parameter:  the result string
    call   printf    #call printf to print result


    #epilogue
    movq %rbp, %rsp  #clear local variables from the stack
    popq %rbp      #restore the base pointer location


pow:
    #prologue
    pushq   %rbp  #push the base pointer
    movq   %rsp, %rbp   #copy stack pointer value to base pointer
    
    movq $1, %rax  #initialise total variable
    movq $0, %rcx  #iniliatise the loop counter
     
    loop:
        cmpq %rcx, %rsi #compare the counter to the exponent
        jle end_loop  #break from the loop if counter => to the exponent
        mulq %rdi   #Multiply the total by the base
        incq %rcx   #Increment the loop counter
        jmp loop  #Jump to the next iteration of the loop

    end_loop:
    


    #epilogue
    movq %rbp, %rsp  #clear local variables from the stack
    popq %rbp      #restore the base pointer location

    ret #return from pow

end:
    
    movq   $0, %rdi   #If there are no errors, rdi will be 0
    call    exit   #Exit the program
