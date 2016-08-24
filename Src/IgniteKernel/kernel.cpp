#include "display.h"

extern "C" void KernelInit()
{
	display::ClearScreen();
	display::ShowCursor(false);

	char message[] = { 'I','G','N','I','T', 'E', ' ', '0', '.', '1', 'a', '\0' };

	//const char message[] = "This is a test"; // fails due to some wired compiler additions

	display::PrintString(message);

	// TODO:
	// implement int 11h and 12h
	// 11h = BIOS equipment list
	// 12h = memory size

	// TODO:
	// implement simple scanf function for command prompt

	// TODO:
	// implement simple commands like time (int 1Ah / AH = 00) and int 19h reboot

	for (;;); // loop to infinity...

	return; // never reached
}
