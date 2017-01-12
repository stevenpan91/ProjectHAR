# ProjectHAR
It's a secret.

Noted issues:
------------------------
Screen Driver
------------------------

1. Erratic behavior of video memory
  
  a. print_char(char character, int col, int row, int attribute_byte) works
  
     print_char(char character, int col, int row, row attribute_byte) doesn't for whatever reason

  b. Character pointers offset by +1 null character with each call
     
     Calling print_at(char&#42; message, int col, int row) from kernel fills null char at message[0]
     
     Calling print(char&#42; message) from kernel fills null char at message[0] and message[1]

Screen driver issues have been hacked around to work and therefore the driver is unstable. Further modification is required.
