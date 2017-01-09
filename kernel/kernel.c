#include "../drivers/screen.h"
//void testfunc(){}

//int addr=0xb8000;
//void print_char(char thechar,int col, int row, unsigned char attribute_byte)
void yp_print_char(char thechar, char attr, int col, int row)
{
	unsigned char *vidmem = (unsigned char*) 0xb8000;
	//char *vidmem = (char*) 0xb8000;
	//unsigned int offs2=get_screen_offset(rowblah,rowblah);
	int hi = row;
	unsigned int offs2=1;
	vidmem[offs2]=thechar;
	vidmem[offs2+1]=attr;

}
void main() {
	//char* video_memory = (char*) 0xb8000;
	//*video_memory = 'B';
	
	/*unsigned char *vidmem = (unsigned char*)0xb8000;
	char thechar=0x48;
	char attribute_byte=0x1e; //yellow on blue
	unsigned int offs2;
	offs2=get_screen_offset(0,0);
	vidmem[offs2] = thechar;
	vidmem[offs2+1]= attribute_byte;*/
	//*(vidmem+offs2) = thechar;
	//*(vidmem+offs2+1)=attribute_byte;	

	yp_print_char('H',0x1e,0,0);
	//print_char('H',0,0,0x1e);
	//char (first arg is being read as 0x7D no matter what
	//attr (fourth arg) is off by +0x01)
}
