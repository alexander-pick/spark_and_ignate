#include "display.h"

/*
	PrintString: uses int 10h / 13h to print a asciiz string on screen
*/
void display::PrintString(
		const char __far *sOutputString,
		byte            cXOffset,
		byte            cYOffset,
		byte            cBackgroundColor,
		byte            cTextColor,
		bool            bUpdateCursor
	)
{

	/*
			  0001             0100
		|_ Background _| |_ Foreground _|
	*/

	byte cAttributes = ((cTextColor) | (cBackgroundColor << 4)); // build attribute byte by shifting background to the lower 4 bit

	byte iStringLength = string::Strlen(sOutputString);

	 
	//display::PrintAsHex(iStringLength);
	
	__asm
	{
		push	bp

		mov		ah, 13h							// function number		
		mov		al, bUpdateCursor				// output mode

		xor		bh, bh					
		mov		bl, cAttributes					// attribute byte, color -> low bit for/high bit background

		xor		cx, cx					
		mov		cl, iStringLength				// string length

		mov		dh, cYOffset					// y offset
		mov		dl, cXOffset					// x offset
		
		mov     es, word ptr[sOutputString+2]	// segment addr of buffer (es:bp)
		mov     bp, word ptr[sOutputString]		// offset addr of buffer

		int		10h

		pop		bp
	}

}

/*
	PrintAsHex: prints hex numbers to screen, there are more elegant ways to do that, but thats purely for debug purpose
*/
void display::PrintAsHex(char cChar)
{
	char cCharOut = 0x30;

	switch(cChar)
	{
		case 0x1:
			cCharOut = 0x31;
			break;
		case 0x2:
			cCharOut = 0x32;
			break;
		case 0x3:
			cCharOut = 0x33;
			break;
		case 0x4:
			cCharOut = 0x34;
			break;
		case 0x5:
			cCharOut = 0x35;
			break;
		case 0x6:
			cCharOut = 0x36;
			break;
		case 0x7:
			cCharOut = 0x37;
			break;
		case 0x8:
			cCharOut = 0x38;
			break;
		case 0x9:
			cCharOut = 0x39;
			break;
		case 0xA:
			cCharOut = 0x61;
			break;
		case 0xB:
			cCharOut = 0x62;
			break;
		case 0xC:
			cCharOut = 0x63;
			break;
		case 0xD:
			cCharOut = 0x64;
			break;
		case 0xE:
			cCharOut = 0x65;
			break;
		case 0xf:
			cCharOut = 0x66;
			break;
	}

	display::PrintChar(cCharOut);
}

/*
	PrintChar: uses int 10h / 0Eh to print a character on screen
*/
void display::PrintChar( char cChar)
{
	__asm
	{
		mov al, cChar						// load chat into al
		mov ah, 0Eh								// set function 0eh > print char
		int 10h						
	}
}

/*
	ClearScreen: uses int 10h / 00h to clear screen
*/
void display::ClearScreen()
{
	__asm
	{
		mov     al, 02h
		mov     ah, 00h
		int     10h
	}
}

/*
	ShowBoxCursor: uses int 10h / 01h to set box cursor on/off
*/
void display::ShowBoxCursor( bool inMode )
{
	byte flag = inMode ? 0 : 0x32;

	__asm
	{
		mov     ch, flag
		mov     cl, 07h
		mov     ah, 01h
		int     10h
	}
}

/*
	ShowCursor: uses int 10h / 01h to set standard cursor on/off
*/
void display::ShowCursor(bool inMode)
{
	byte flag = 0x32;
	
	flag = inMode ? 1 : 0x6;

	__asm
	{
		mov     ch, flag
		mov     cl, 07h
		mov     ah, 01h
		int     10h
	}
}