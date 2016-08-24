#ifndef __DISPLAY__
#define __DISPLAY__

#include "types.h"
#include "string.h"

class display
{
public:
	static void ClearScreen();

	static void PrintString(
		const char 		__far *sOutputString,
		byte            cXOffset = 0,
		byte            cYOffset = 0,
		byte            cBackgroundColor = BLACK,
		byte            cTextColor = GREEN,
		bool            bUpdateCursor = true
	);

	static void PrintChar( char cChar);

	static void PrintAsHex(char cChar);

	static void ShowCursor( bool inMode);

	static void ShowBoxCursor(bool inMode);
};

#endif
