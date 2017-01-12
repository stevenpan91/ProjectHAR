//copy bytes from one place to another
void memory_copy(char* source,char* dest, int no_bytes){
	//unsigned int makes this work
	unsigned int i;
	for (i=0; i<no_bytes; i++){
		*(dest+i) = *(source+i);
	}

}
