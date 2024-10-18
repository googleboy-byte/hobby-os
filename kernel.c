void main() {

	char* video_memory = (char*) 0xb8000; // pointer to char, point to first cell of vidmem
	*video_memory = "X"; // store "X" at the address pointed to by the pointer

}