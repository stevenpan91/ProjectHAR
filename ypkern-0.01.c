//yp kernel
//credits to arjunsreedharan for base code

void kmain(void)
{
	consts char *str="YP test kernel";
	char *vidptr = (char*)0xb8000; //video memory

	unsigned int i=0;
	unsigned int j=0;

	//clear screen loop
	
	while(j<80*25*2){
	//blank char
	vidptr[j]=' ';

	//attribute byte
	vidptr[j+1]=0x07;
	j=j+2;	

	}

	j=0;

	//write string to video mem
	while(str[j] != '\0'){
	vidptr[i]=str[j];
	
	vidptr[i+1]=0x07;
	++j;
	i=i+2;
	
	}
	return;
}
