#include "string.h"
#include "display.h"

byte string::Strlen(const char __far *sInput)
{

	byte iLength = 0;

	while (sInput[iLength] != '\0') // itterate over string until asciiz zero is found
	{
		++iLength;
		
	}

	return iLength;

}
