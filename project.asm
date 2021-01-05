.model small

.stack 100h

.data
   
   input_password db 'Please Enter Your Password$'
   password db 'qwerty$'
   incorrect_password db 10,13, 'Incorrect Password$'    
   welcome db 10,13,10,13, 'WELCOME TO MEDICAL STORE$'
   msg1 db 10,13,10,13, 'Choose a Option$'
   msg2 db 10,13,10,13, 'What Do You Want To Buy$'
   msg_medicines db 10,13, 'Press 1 to buy medicines$'
   medicines_sold db 10,13, 'Press 2 to see medicines statistics$'
   input_again db 10,13, 'Please Press one of the above given keys$'
   wrong_input db 10,13, 'Wrong Input$'
   exit_program db 10,13,'Press 4 to exit$'
   opt1 db 10,13, '1. Panadol - 4rs$'
   opt2 db 10,13, '2. Paracetamol - 3rs$'
   opt3 db 10,13, '3. Cleritek - 2rs$'
   opt4 db 10,13, '4. Aspirin - 2rs$'
   opt5 db 10,13, '5. Brufen - 1rs$'
   opt6 db 10,13, '6. Surbex Z - 5rs$'
   opt7 db 10,13, '7. Arinac - 4rs$'
   opt8 db 10,13, '8. Sinopharm Vaccine - 2rs$'
   opt9 db 10,13, '9. Pfizer Vaccine - 8rs$'
   newLine db 10,13, '$'     
   msg_panadol db 10,13, 'How many panadols do you want to buy$'
   msg_paracetamol db 10,13, 'How many paracetamol do you want to buy$'
   msg_cleritek db 10,13, 'How many cleritek do you want to buy$'
   msg_aspirin db 10,13, 'How many aspirin do you want to buy$'
   msg_brufen db 10,13, 'How many brufen do you want to buy$'
   msg_surbex db 10,13, 'How many subex do you want to buy$'
   msg_arinac db 10,13, 'How many arinac do you want to buy$'
   msg_sinopharm db 10,13, 'How many Sinopharm Vaccine do you want to buy$'
   msg_pfizer db 10,13, 'How many Pfizer Vaccine do you want to buy$'
   total_msg dw 'Total Earned= $'
   price_panadol dw 4
   price_paracetamol dw 3
   price_cleritek dw 2    
   price_aspirin dw 2
   price_brufen dw 1
   price_surbex dw 5    
   price_arinac dw 4
   price_sinopharm dw 2
   price_pfizer dw 8    
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
        
        
    mov ax,@data
    mov ds,ax

    mov dx,offset input_password
    mov ah,9
    int 21h
    mov dx,offset newLine
    mov ah,9
    int 21h
    mov bx,offset password
    mov cx,6
    
    l1:
    mov ah,1
    int 21h
    cmp al,[bx]
    jne incorrect
    inc bx
    loop l1
    
    start:
    mov dx,offset newLine
    mov ah,9
    int 21h
    call menu

    mov dx,offset newLine
    mov ah,9
    int 21h    
    
    mov ah,1
    int 21h
    
    cmp al,'1'
    je menu2  
    cmp al,'2'
    je medicines_stats
    cmp al,'3'
    je show_amount
    cmp al,'4'
    je exit
    
    mov dx,offset wrong_input
    mov ah,9
    int 21h
    mov dx,offset input_again
    mov ah,9
    int 21h    
    jmp start
     
     
     
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
        add dl,48
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
            
        mov dx,offset newLine
        mov ah,9
        int 21h        
        
        mov ah,1
        int 21h
        
        sub al,48
        
        add pfizer_sold,al
        mul price_pfizer
        
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
     
        show_amount: 
        
        mov dx,offset amount_earned
        mov ah,9
        int 21h
        
        mov dl,amount
        add dl,48
        mov ah,2
        int 21h
        
        jmp start   
        
        incorrect:
        
        mov dx,offset incorrect_password
        mov ah,9
        int 21h
        jmp exit
        
        exit:
        mov ah,4ch
        int 21h
            
main endp
    
    menu proc
      
        mov dx,offset welcome
        mov ah,9
        int 21h
        
        mov dx,offset msg1
        mov ah,9
        int 21h
        
        mov dx,offset msg_medicines
        mov ah,9
        int 21h
        
        mov dx,offset medicines_sold
        mov ah,9
        int 21h
        
        mov dx,offset amount_print
        mov ah,9
        int 21h
        
        mov dx,offset exit_program
        mov ah,9
        int 21h                   
        
             
        ret
          
    menu endp
    
    menu2 proc  
        
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
        
        mov dx,offset newLine
        mov ah,9
        int 21h    
        
        mov ah,1
        int 21h
        
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
        
        ret
            
            
    menu2 endp
     
    medicines_stats proc
          
        mov dx,offset panadol_print
        mov ah,9
        int 21h
        
        add panadol_sold,48
        
        mov dl,panadol_sold
        mov ah,2
        int 21h
        
        mov dx,offset paracetamol_print
        mov ah,9
        int 21h
        
        add paracetamol_sold,48
        
        mov dl,paracetamol_sold
        mov ah,2
        int 21h
        
        
        mov dx,offset cleritek_print
        mov ah,9
        int 21h 
        
        add cleritek_sold,48
        
        mov dl,cleritek_sold
        mov ah,2
        int 21h
        
        mov dx,offset aspirin_print
        mov ah,9
        int 21h
        
        add aspirin_sold,48
        
        mov dl,aspirin_sold
        mov ah,2
        int 21h
        
        
        mov dx,offset brufen_print
        mov ah,9
        int 21h
        
        add brufen_sold,48
        
        mov dl,brufen_sold
        mov ah,2
        int 21h
        
        mov dx,offset arinac_print
        mov ah,9
        int 21h
        
        add arinac_sold,48
        
        mov dl,arinac_sold
        mov ah,2
        int 21h
        
        mov dx,offset pfizer_print
        mov ah,9
        int 21h
        
        add pfizer_sold,48
        
        mov dl,pfizer_sold
        mov ah,2
        int 21h
        
        mov dx,offset sinopharm_print
        mov ah,9
        int 21h
        
        add sinopharm_sold,48
        
        mov dl,sinopharm_sold
        mov ah,2
        int 21h
        
        
        ret 
          
    medicines_stats endp     
        
end main