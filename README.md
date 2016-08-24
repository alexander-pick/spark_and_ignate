A little OS project for learning
SparkBoot and IgniteKernel 0.1a
=========================================================================================================================

Hi there,

this is my little Bootlader and Kernel project I have done so far for studying the bootprocess and kernel/os design pattern required to boot code on a x86 system. It is sort of undone yet but I have learned a lot with this project and I did my best to comment it so you can possibly use and understand it for learning as well. 

To compile this project you need 3 things:

-> Visual C++ 1.52
Get it for free from MSDN or just search the web, you will find it easily (VC152)I cannot provide this here due to copyright reasons. Put the bin folder (or if you found the stripped bin package) in this project to /bin/vc152
https://www.google.de/search?q=VC152+bootloader

-> Visual Studio 2015 Community with free Visual C++
You get this great toy for free from Microsoft
https://www.visualstudio.com/de-de/downloads/download-visual-studio-vs.aspx

-> Bochs
to run everything 
https://sourceforge.net/projects/bochs/

To run it, load the img created by Build/BuildAll.bat with Bochs and start of debugging and development.

DO NOT TRY TO BUILD FROM VISUALSTUDIO!!!! USE THE .BAT FILES in BUILD/ !!!!

=========================================================================================================================

Here are some useful reads for others trying to build something like that with no particular order:

COFF vs OMF
http://stackoverflow.com/questions/966597/whats-the-difference-between-the-omf-and-coff-format

INT 10h Operations
https://courses.engr.illinois.edu/ece390/books/labmanual/graphics-int10h.html

16 Bit C Code with Visual Studio:
http://masm32.com/board/index.php?topic=4624.0

Interesting read
https://www.organicdesign.co.nz/Writing_a_boot_loader_in_assembler

Some things on GDT:
http://stackoverflow.com/questions/9137947/assembler-jump-in-protected-mode-with-gdt
http://stackoverflow.com/questions/36562268/triple-fault-when-jumping-into-protected-mode

I will add more if I find something helpful.

If you have success with expanding this, feel free to contribute to the project. Have fun!