; Ignite (Stage1 / Kernel) 
; 2016 by Alexander Pick
;
; This code was purely written for educational purpouse, free to be used, licensed under MIT Licese. 
; Have fun, learn, evolve.
; 

code segment use16

	extrn _KernelInit:near			; extren c++ function to load

	assume cs:code
 
	org		0h					; for Kernel

	; TODO: for some odd reason this file is skipped, and the kernel is entered via kernel.cpp
	; needs to be fixed.

	start:
	main:
        call _KernelInit			; jump into the C++ World
	
	code ends
end start                ; End of program

