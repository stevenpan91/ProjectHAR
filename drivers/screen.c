int get_screen_offset(int col, int row){

	int returnval;
	returnval=(row*MAX_COLS+col)*2;

}

int get_cursor(){
	//device uses control reg as an index to select
	//internal registers
	//reg 14: high byte of cursor offset
	//reg 15: low byte of cursor offset
	//once internal register has been selected, we may read
	//or write a byte on the data register
	
	port_byte_out(REG_SCREEN_CTRL,14);
	int offset = port_byte_in(REG_SCREEN_DATA) << 8;
	port_byte_out(REG_SCREEN_CTRL,15);
	offset += port_byte_in(REG_SCREEN_DATA);

	//mult by 2 to convert to char cell offset
	return offset*2;

}

void set_cursor(int offset){
	//this may be incomplete
	offset /= 2; //cell to char offset
	port_byte_out(REG_SCREEN_CTRL,14);
	port_byte_out(REG_SCREEN_DATA, (unsigned char) (offet >> 8));
	port_byte_out(REG_SCREEN_CTRL,15);

}



//print char on screen at col,row or cursor
void print_char(char character, int col, int row, char attribute_byte){
	//create a byte (char) pointer to start of vid mem
	unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS;

	//if attribute byte is zero, assume default style
	if (!attribute_byte) {
		attribute_byte=WHITE_ON_BLACK;
	}

	//get vid mem offset for screen location
	int offset;

	//if col and row are non-negative use them for offset
	if (col >= 0 && row >= 0){
		offset=get_screen_offset(col,row);
	}
	else{
	//else use cursor position
		offset=get_cursor();
	}

	//if see newline set offset to end of current row
	//Nick multiplied MAX_COLS by 2 because each cell is 2 bytes
	if (character == '\n'){
		int rows = offset / (2*MAX_COLS);
		offset = get_screen_offset(79,rows);
	}
	//Otherwise, write the character and its attribute tpe to
	//vid memory at calculated offset
	else {
		vidmem[offset] = character;
		vidmem[offset+1] = attribute_byte;	
	}

	//Update offset to next char cell, 2 bytes ahead of current cell
	offset +=2;

	//make scrolling adjustment
	offset = handle_scrolling(offset);
	
	//Update cursor position on screen device
	set_cursor(offset);
}

void print_at(char* message, int col, int row){
	//Update cursor if col and row not negative
	if(col>=0 && row>=0) {
		set_cursor(get_screen_offset(col,row));
	}
	//Loop through each char of message and print it
	int i=0;
	while(message[i] != 0){
		print_char(message[i++], col, row, WHITE_ON_BLACK);
	}
}

void print(char* message) {
	print_at(message,-1,-1);
}

void clear_screen() {
	int row = 0;
	int col = 0;

	//write blank chars through vid mem
	for (row=0, row<MAX_ROWS; row++) {
		for (col=0; col<MAX_COLS; col++){
			print_char(' ', col,row, WHITE_ON_BLACK);
		}
	}
	//move cursor back
	set_cursor(get_screen_offset(0,0));

}

int handle_scrolling(int cursor_offset){
	//if cursor within screen return unmodified
	if(cursor_offset<MAX_ROWS*MAX_COLS*2){
		return cursor_offset;
	}

	//move rows back 1
	int i;
	for (i=1; i<MAX_ROWS; i++){
		memory_copy(
		get_screen_offset(0,i)+VIDEO_ADDRESS,
		get_screen_offset(0,i-1)+VIDEO_ADDRESS,
		MAX_COLS*2
		);
	}

	//blank last line
	char* last_line=get_screen_offset(0,MAX_ROWS-1) + VIDEO_ADDRESS;
	for(i=0; i<MAX_COLS*2; i++){
		last_line[i]=0;
	}

	//move offset to front of last row
	cursor_offset -= 2*MAX_COLS;

	//Return updated cursor position
	return cursor_offset;
}

