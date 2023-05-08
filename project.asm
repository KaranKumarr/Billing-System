;            -------------------------------------------
;                    BILLING MANAGEMENT SYSTEM
;            -------------------------------------------

.model small
.stack 100h

.data
   
   ; menu-related msgs
   input_password db 'Please Enter Your Password$'
   tryagain db "Try Again? (1/0): $"
   key_message db 'Press any key to continue... $'
   password db 'coding$'
   incorrect_password db 10,13, 'Incorrect Password$'    
   welcome db 10,13,10,13, 'WELCOME TO MEDICAL STORE$'
   msg1 db 10,13,10,13, 'Choose a Option: $'
   msg2 db 10,13,10,13, 'What Do You Want To Buy$'
   msg_medicines db 10,13, 'Press 1 to buy medicines$'
   medicines_sold db 10,13, 'Press 2 to see medicines statistics$'
   input_again db 10,13, 'Please Press one of the above given keys$'
   wrong_input db 10,13, 'Wrong Input$'
   exit_program db 10,13,'Press 4 to exit$'
   
   ; temp variables
   opt1 db 10,13, '1. Panadol - 4rs$'
   opt2 db 10,13, '2. Paracetamol - 3rs$'
   opt3 db 10,13, '3. Cleritek - 2rs$'
   opt4 db 10,13, '4. Aspirin - 2rs$'
   opt5 db 10,13, '5. Brufen - 1rs$'
   opt6 db 10,13, '6. Surbex Z - 5rs$'
   opt7 db 10,13, '7. Arinac - 4rs$'
   opt8 db 10,13, '8. Sinopharm Vaccine - 2rs$'
   opt9 db 10,13, '9. Pfizer Vaccine - 8rs$'
   
   ; newline
   newLine db 10,13, '$'     
   
   ; medicine related msgs
   msg_panadol db 10,13, 'How many panadols do you want to buy$'
   msg_paracetamol db 10,13, 'How many paracetamol do you want to buy$'
   msg_cleritek db 10,13, 'How many cleritek do you want to buy$'
   msg_aspirin db 10,13, 'How many aspirin do you want to buy$'
   msg_brufen db 10,13, 'How many brufen do you want to buy$'
   msg_surbex db 10,13, 'How many subex do you want to buy$'
   msg_arinac db 10,13, 'How many arinac do you want to buy$'
   msg_sinopharm db 10,13, 'How many Sinopharm Vaccine do you want to buy$'
   msg_pfizer db 10,13, 'How many Pfizer Vaccine do you want to buy$'
   total_msg db 'Total Earned= $'
   
   ; price related msgs
   price_panadol dw 4
   price_paracetamol dw 3
   price_cleritek dw 2    
   price_aspirin dw 2
   price_brufen dw 1
   price_surbex dw 5    
   price_arinac dw 4
   price_sinopharm dw 2
   price_pfizer dw 8
   
   ; amount-related msgs
   amount_earned db 10,13,'Amount earned= $'
   amount db 0
   amount_print db 10,13,'Press 3 to show amount earned today$'
   panadol_sold db 0
   paracetamol_sold db 0
   cleritek_sold db 0
   aspirin_sold db 0
   brufen_sold db 0
   surbex_sold db 0
   arinac_sold db 0
   sinopharm_sold db 0
   pfizer_sold db 0
   
   ; report(output) msgs
   panadol_print db 10,13, 'Panadols sold = $'
   pfizer_print db 10,13, 'Pfizer Vaccine sold = $'
   sinopharm_print db 10,13, 'Sinopharm Vaccine sold = $'
   arinac_print db 10,13, 'Arinac sold = $'
   surbex_print db 10,13, 'Surbex sold = $'
   aspirin_print db 10,13, 'Aspirin sold = $'
   brufen_print db 10,13, 'Brufen sold = $'
   cleritek_print db 10,13, 'Cleritek sold = $'
   paracetamol_print db 10,13, 'Paracetamol sold = $'  
            
.code

main proc
    
    ; here we can access tha variables from data segment on heap       
    mov ax,@data
    mov ds,ax
    
    ; moving the offset address of menu label into bx
    ; as to perform unconditional jmp to this label through
    ; procedures
    mov bx, offset menu

password_label:                                    

    ; printing the new line
    mov dx,offset newLine
    mov ah,9
    int 21h
    
    ; printing the input_password string
    mov dx, offset input_password
    mov ah,9
    int 21h
    
    ; printing the new line
    mov dx,offset newLine
    mov ah,9
    int 21h
    
    mov si, 0   ; to traverse through password-array
    mov cx,6    ; 6 = length of 'coding'
 
    ; loop to input password  
 l1:
    mov ah,1
    int 21h
    cmp al,password[si]
    jne incorrect
    inc si
    loop l1
   
    ; printing the new line
    mov dx,offset newLine
    mov ah,9
    int 21h
   
    ; press any key to continue
    mov ah, 9
    mov dx, offset key_message
    int 21h
    
    ; getting the character to continue
    mov ah, 1
    int 21h
   
    mov dx, offset welcome
    mov ah, 9
    int 21h
   
    ; menu procedure
    ; here we are showing menu to choose different options 
    ; you can see menu in the data segment
menu:
        
    mov dx, offset msg1                                
    mov ah, 9
    int 21h
        
    mov dx, offset msg_medicines                        
    mov ah, 9
    int 21h
        
    mov dx, offset medicines_sold
    mov ah, 9
    int 21h
        
    mov dx, offset amount_print
    mov ah,9
    int 21h
        
    mov dx, offset exit_program
    mov ah,9
    int 21h
        
    mov ah, 9
    mov dx, offset msg1
    int 21h
    
    ; after displaying the menu, getting the input
    ; from the user to continue
    mov ah, 1
    int 21h
    
    ;here we compare the choosen value and move to the label according to choice
    cmp al,'1'
     je menu2   ; control transfered to "buying medicine"
     
    cmp al,'3'  ; control transfered to "show_amount label"
     je show_amount
     
    cmp al,'4'  ; exit BMS (billing Management System)
     je exit
     
    cmp al,'2'  ; control transfered to "Statistics of Medicines - Quantity"
     call medicines_stats
     
    cmp al, '2'
     jmp start1
    
    ; if none of the cases matched, the obvious case
    ; is that user had entered value other than menu
    ; so displaying proper msg and shifting the control
    ; to input_again label
    mov dx, offset wrong_input
    mov ah,9
    int 21h
    
    mov dx, offset input_again
    mov ah, 9
    int 21h
    
    jmp start1
    
    ;this is the label of start1 from where it will move to menu again    
start1: 
    mov dx, offset newLine
    mov ah,9
    int 21h
    
    ; shifting the control to display the menu
    jmp menu
    
    ; control shifted from line - 183
    ;this label will show the amount earned by selling medicine
show_amount:
    mov dx, offset amount_earned
    mov ah, 9
    int 21h
        
    mov dl, amount
    add dl, 30h
    mov ah, 0
    mov ah, 2
    int 21h
    
    ; shifting the control to start from where
    ; new line will be printed and jump to menu label 
    jmp start1   
     
     ; a special label for incorrect password-input
incorrect:

    ; displaying a proper msg for incorrect password                                 
    mov dx,offset incorrect_password       
    mov ah,9                              
    int 21h
    
    ; printing new line
    mov dx, offset newLine
    mov ah, 09h
    int 21h
    
    ; asking the user whether to try again or
    ; to exit the BILLING MANAGEMENT SYSTEM
    mov dx, offset tryagain
    mov ah, 09h
    int 21h
     
    ; getting the user's choice
    mov ah, 1
    int 21h
    
    ; 1 means yes and user will be prompted to password label
    ; to re-enter password
    cmp al, '1'
    je password_label
    
    ; if there is any other input than 1
    ; then it is obvious to exit BMS (Billing Management System)
    jmp exit
    
    
    ;this is the second menu procedure
    ;in this procedure there is given a menu of different medicines to choose any
menu2 proc 
        
        ; displaying the medicine msgs in the menu
        mov dx,offset msg2
        mov ah,9
        int 21h
        
        mov dx,offset opt1
        mov ah,9
        int 21h
        
        mov dx,offset opt2
        mov ah,9
        int 21h
            
        mov dx,offset opt3
        mov ah,9
        int 21h
        
        mov dx,offset opt4
        mov ah,9
        int 21h
        
        mov dx,offset opt5
        mov ah,9
        int 21h
            
        mov dx,offset opt6
        mov ah,9         
        int 21h
        
        mov dx,offset opt7
        mov ah,9
        int 21h
        
        mov dx,offset opt8
        mov ah,9
        int 21h
            
        mov dx,offset opt9
        mov ah,9
        int 21h
        
        ; new line
        mov dx,offset newLine
        mov ah,9
        int 21h    
        
        ; after displaying the menu, the BMS will prompt
        ; the user to enter his choice about medicine
        mov ah,1
        int 21h
        
        ; after the choice is selected by the user it will
        ; be compared one by one by cmp instruction
        cmp al,'1'
        je panadol 
        cmp al,'2'
        je paracetamol
        cmp al,'3'
        je cleritek
        cmp al,'4'
        je aspirin
        cmp al,'5'
        je brufen  
        cmp al,'6'
        je surbex
        cmp al,'7'
        je arinac
        cmp al,'8'
        je sinopharm
        cmp al,'9'
        je pfizer
    
        ; from line 343 to 649
        ; each label performs the following operations
        ;   * Display a proper msgs of the respective medicine
        ;   * input the # of medicine to buy
        ;   * updating the medicine statistics
        ;   * calculaing the total amount
panadol:
         
        mov dx,offset msg_panadol
        mov ah,9
        int 21h
            
        mov dx,offset newLine
        mov ah,9
        int 21h        
        
        mov ah,1
        int 21h
        
        sub al,48
        
        add panadol_sold,al
        mul price_panadol
        
        add amount,al
        mov cl,al
        
        mov dx,offset newLine
        mov ah,9
        int 21h
        
        mov dx,offset total_msg
        mov ah,9
        int 21h
        
        mov dl,cl
        add dl,30h
        
        mov ah,2
        int 21h     
                
        jmp start

paracetamol:
    
        mov dx,offset msg_paracetamol
        mov ah,9
        int 21h
            
        mov dx,offset newLine
        mov ah,9
        int 21h        
        
        mov ah,1
        int 21h
        
        sub al,48
        
        add paracetamol_sold,al
        mul price_paracetamol
        
        add amount,al
        mov cl,al
        mov dx,offset newLine
        mov ah,9
        int 21h
        mov dx,offset total_msg
        mov ah,9
        int 21h
        mov dl,cl
        add dl,48
        mov ah,2
        int 21h
        
        jmp start                  
    
cleritek:
        
        mov dx,offset msg_cleritek
        mov ah,9
        int 21h
            
        mov dx,offset newLine
        mov ah,9
        int 21h        
        
        mov ah,1
        int 21h
        
        sub al,48
        
        add cleritek_sold,al
        mul price_cleritek
        
        add amount,al
        mov cl,al
        mov dx,offset newLine
        mov ah,9
        int 21h
        mov dx,offset total_msg
        mov ah,9
        int 21h
        mov dl,cl
        add dl,48
        mov ah,2
        int 21h
        
        jmp start
        
aspirin:
         
        mov dx,offset msg_aspirin
        mov ah,9
        int 21h
            
        mov dx,offset newLine
        mov ah,9
        int 21h        
        
        mov ah,1
        int 21h
        
        sub al,48
        
        add aspirin_sold,al
        mul price_aspirin
        
        add amount,al
        mov cl,al
        mov dx,offset newLine
        mov ah,9
        int 21h
        mov dx,offset total_msg
        mov ah,9
        int 21h
        mov dl,cl
        add dl,48
        mov ah,2
        int 21h
                
        jmp start
           
brufen:
         
        mov dx,offset msg_brufen
        mov ah,9
        int 21h
            
        mov dx,offset newLine
        mov ah,9
        int 21h        
        
        mov ah,1
        int 21h
        
        sub al,48
        
        add brufen_sold,al
        mul price_brufen
        
        add amount,al
        mov cl,al
        mov dx,offset newLine
        mov ah,9
        int 21h
        mov dx,offset total_msg
        mov ah,9
        int 21h
        mov dl,cl
        add dl,48
        mov ah,2
        int 21h   
                
        jmp start
        
surbex:
         
        mov dx,offset msg_surbex
        mov ah,9
        int 21h
            
        mov dx,offset newLine
        mov ah,9
        int 21h        
        
        mov ah,1
        int 21h
        
        sub al,48
        
        add surbex_sold,al
        mul price_surbex
        
        add amount,al
        mov cl,al
        mov dx,offset newLine
        mov ah,9
        int 21h
        mov dx,offset total_msg
        mov ah,9
        int 21h
        mov dl,cl
        add dl,48
        mov ah,2
        int 21h                
                
        jmp start
     
arinac:
         
        mov dx,offset msg_arinac
        mov ah,9
        int 21h
            
        mov dx,offset newLine
        mov ah,9
        int 21h        
        
        mov ah,1
        int 21h
        
        sub al,48
        
        add arinac_sold,al
        mul price_arinac
        
        add amount,al
        mov cl,al
        mov dx,offset newLine
        mov ah,9
        int 21h
        mov dx,offset total_msg
        mov ah,9
        int 21h
        mov dl,cl
        add dl,48
        mov ah,2
        int 21h
                
        jmp start
        
sinopharm:
         
        mov dx,offset msg_sinopharm
        mov ah,9
        int 21h
            
        mov dx,offset newLine
        mov ah,9
        int 21h        
        
        mov ah,1
        int 21h
        
        sub al,48
        
        add sinopharm_sold,al
        mul price_sinopharm
        
        add amount,al
        mov cl,al
        mov dx,offset newLine
        mov ah,9
        int 21h
        mov dx,offset total_msg
        mov ah,9
        int 21h
        mov dl,cl
        add dl,48
        mov ah,2
        int 21h
                
        jmp start
     
pfizer:
 
        mov dx,offset msg_pfizer
        mov ah,9
        int 21h
            
        mov dx,offset newLine       ;line feed
        mov ah,9
        int 21h        
        
        mov ah, 1                   ;input from user
        int 21h
        
        sub al, 48                  ;convert data into numerical digit 
        
        add pfizer_sold, al         ;add input to already sold medicine
        mul price_pfizer
        
        add amount, al              ;add al to original total amount earned
        mov cl, al                  ;save the amount
        
        mov dx, offset newLine      ;line feed
        mov ah, 9
        int 21h
        
        mov dx, offset total_msg    ;display message (total amount)
        mov ah, 9
        int 21h
        
        mov dl, cl
        add dl, 48                  ;convert data into numerical digit 
        mov ah, 2
        int 21h
                
        jmp start

start:
    mov dx,offset newLine           ;line feed
    mov ah,9
    int 21h
    
    jmp bx                          ;bx has offset menu
            
menu2 endp
        
exit:
    mov ah,4ch                      ;console return to dos
    int 21h
        
    ret
            
main endp                           ;main end
    
medicines_stats proc
          
    mov dx,offset panadol_print     ;display line of medicine name
    mov ah,9
    int 21h
        
    add panadol_sold,48             ;convert data into numerical digit
        
    mov dl,panadol_sold             ;display count how much a specific medicine sold
    mov ah,2
    int 21h
        
    mov dx,offset paracetamol_print ;display line of medicine name
    mov ah,9
    int 21h
        
    add paracetamol_sold,48         ;convert data into numerical digit
        
    mov dl,paracetamol_sold         ;display count how much a specific medicine sold
    mov ah,2
    int 21h

    mov dx,offset cleritek_print    ;display line of medicine name
    mov ah,9
    int 21h 
        
    add cleritek_sold,48            ;convert data into numerical digit
        
    mov dl,cleritek_sold            ;display count how much a specific medicine sold
    mov ah,2
    int 21h
        
    mov dx,offset aspirin_print     ;display line of medicine name
    mov ah,9
    int 21h
    
    add aspirin_sold,48             ;convert data into numerical digit
        
    mov dl,aspirin_sold             ;display count how much a specific medicine sold
    mov ah,2
    int 21h
        
    mov dx,offset brufen_print      ;display line of medicine name
    mov ah,9
    int 21h
        
    add brufen_sold,48              ;convert data into numerical digit
        
    mov dl,brufen_sold              ;display count how much a specific medicine sold
    mov ah,2
    int 21h
        
    mov dx,offset arinac_print      ;display line of medicine name
    mov ah,9
    int 21h
        
    add arinac_sold,48              ;convert data into numerical digit
        
    mov dl,arinac_sold              ;display count how much a specific medicine sold
    mov ah,2
    int 21h
        
    mov dx,offset pfizer_print      ;display line of medicine name
    mov ah,9
    int 21h
        
    add pfizer_sold,48              ;convert data into numerical digit
        
    mov dl,pfizer_sold              ;display count how much a specific medicine sold
    mov ah,2
    int 21h
        
    mov dx,offset sinopharm_print   ;display line of medicine name
    mov ah,9
    int 21h
        
    add sinopharm_sold,48           ;convert data into numerical digit  
        
    mov dl,sinopharm_sold           ;display count how much a specific medicine sold
    mov ah,2
    int 21h
    
    mov ah, 09h
    mov dx, offset newLine          ;line feed
    int 21h
    
    mov ah, 09h
    mov dx, offset key_message      ;display line 'Press any key to continuue'
    int 21h
    
    mov ah, 01h
    int 21h
    
    mov ah, 09h
    mov dx, offset newLine          ;line feed
    int 21h
    
    
    jmp bx                          ; bx has offset menu

    ret                             ;return
        
medicines_stats endp                ;function end

end main                            ;program end
