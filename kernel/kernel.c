#include "../drivers/screen.h"

void kernel_start() {
	//char* video_memory = (char*) 0xb8000;
	//*video_memory = 'B';
	
	//reset cursor to upper left	
	set_cursor(0);
	print_char('H',-1,-1,0x1e);
	print_char('M',-1,-1,0x1e);
	/*Below happens if there are more than two char arguments in print_char method:
	char (first arg): read as 0x7D no matter what
	attr (fourth arg): off by +0x01)*/
	
	//print_char('M',1,0,0x1e);
	//print_at("Testing",2,0);
        print_at("TestNegative",-1,-1);
	//print('X');
	//print('X');
}
