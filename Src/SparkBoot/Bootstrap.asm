; Sparkboot (Stage0) 
; by Alexander Pick
;
; This code was purely written for educational purpouse, free to be used. Have fun, learn, evolve.
; 
; =======================================================================================================================================
;
; MBR is the first 512 Bytes of the disk. It can contain information on up to 4 partitions (each 16 Bytes long) + 2 Byte Magic (0x55AA), 
; so 440 Byte are left for our stage0 Loader.
;
; This is a very simple loader which will load the kernel at sector 2 of the disc to 1000:0000 and exec it. Currently the max size of the 
; kernel is set to 2,5 kb which is 5 sectors in total
;
; Todo: add FAT Support
;

code segment use16

	cBootAddr		EQU 7c00h
	cKernelAddr		EQU 1000h
	cDrive			EQU 0h

	;enable for protected mode code
	;bBootProtected  EQU 1

	assume cs:code, ds:data
 
	org		7c00h					; location where bios loads the boodcode to

	start:
	main:

        cli							; turn interupts off 

		xor ax,ax					; make ax zero

		mov ds,ax					; ds (Data Segment) = 0
        mov es,ax					; es (Extra Segment) = 0		
        mov ss,ax					; StackSegment = 0      
		  
        mov sp,cBootAddr			; Setup a stack with out stage0 as adress

        sti							; reenable interupts

		reset:						; reset the floppy drive

            xor ax,ax				; int function ah = 00h, drive reset 
            mov dl, cDrive			; drivenumber
            int 13h					; bios int 13h (disc operations)
            jc reset				; reset on error


		read:
			
			mov ax, cKernelAddr		; es causes invalid instruction if written directly
			mov es, ax				; put kernel adress to es
			xor bx, bx				; make bx zero

            mov ah, 2h				; int function ah = 2h, loads disc data to offset es:bx
            mov al, 5h				; load 5 sectors 5*512byte = 2,5Kb for the IgniteKernel, can be extended to 64 kb
            mov ch, 0				; cylinder = 0
            mov cl, 2h				; sector = 2 (1 is claimed by SparkBoot)
            mov dh, 0				; head = 0
            mov dl, cDrive			; drivenumber
            int 13h					; bios int 13h (disc operations)

            jc read					; Ups, I do it again (if error)

ifdef bBootProtected

		; added
		; A20 - prevent memory problems with caps key

		mov al, 0d1h
		out 64h, al					; Signal Write command
		mov al, 0dFh
		out 60h, al					; Enable A20
			
		cli							; disable interrupts

        lgdt fword ptr [GDT_null]	; load the GDT  
        mov eax,cr0					; get cr0 to eax
        or al, 1h					; set the protection enable bit (pe) in cr0    
        mov cr0,eax					; start protected mode

		sti							; reenable interrupts

		push 0
		push protected
		retf

	protected:

	dCodeOffset		EQU 8
	dDataOffset		EQU 16

		mov ax, dDataOffset			; Point segment registers to the data
		mov ds, ax					; selector defined in the gdt
		mov ss, ax
		mov es, ax
		mov fs, ax
		mov gs, ax

		jmp $						; should never be reached.

else

        push 1000h				; clumsy workaround, MASM won't compile a direct jmp 1000:0000
		push 0
		retf

		jmp $						; should never be reached.

endif
     
		db 510-($-start) dup(0)		; fill the rest of the sector with zero's
		dw 0AA55h					; add the boot loader signature to the end

code ends
data segment use32
		;GDT Definition
		; Consists of null descriptor, code and data segment + address vars 

		; Null Descriptor
		GDT_null:
			dd 0
			dd 0 

		; Code Segment, Base 0 / 4 GB
		GDT_code:
			dw 0FFFFh		; limit low
			dw 0            ; base low
			db 0            ; base middle
			db 10011010b    ; access
			db 11001111b    ; granularity
			db 0            ; base high

		; Data Segment, Base 0 / 4 GB
		GDT_data:
			dw 0FFFFh		; limit low
			dw 0            ; base low
			db 0            ; base middle
			db 10010010b    ; access
			db 11001111b    ; granularity
			db 0            ; base high
	
		GDT_end:

		GDT_r:
			dw 24				; size of GDT GDT_end - GDT_null - 1 = 24
			dd GDT_null			; offset of GDT

	data ends
end main                ; End of program

