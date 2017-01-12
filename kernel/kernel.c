#include "../drivers/screen.h"

void kernel_start() {
	//char* video_memory = (char*) 0xb8000;
	//*video_memory = 'B';
	
	//reset cursor to upper left	
	set_cursor(get_screen_offset(0,2));
	print("32-Bit Protected Mode Initiated.\n");
	print("Screen driver operational.\n");
    /*Below happens if there are more than two char arguments in print_char method:
	char (first arg): read as 0x7D no matter what
	attr (fourth arg): off by +0x01)*/

	int i;
	for(i=0; i<160; i++){
		print("Testscrolling");}	
}
