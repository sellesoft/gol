#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <string.h>

#define SIZE 50
#define AREA (SIZE * SIZE)
#define BUFFER_SIZE (AREA + 4*SIZE + 4 + SIZE) //world + borders + corners + newlines
#define forI(a) for(int64_t i = 0; i < (a); ++i)

uint8_t world[AREA] = {0};
uint8_t temp_world[AREA] = {0};
uint8_t world_buffer[BUFFER_SIZE+1] = {0};

int main(){
	printf("Starting Life...\n");
	
	//init world
	srand(time(0));
	forI(AREA){
		if(((float)rand() / (float)RAND_MAX) < .40){
			world[i] = 1;
		}
	}
	
	//init world buffer
	uint64_t cursor = 0;
	forI(SIZE+2){ world_buffer[cursor++] = '='; }; world_buffer[cursor++] = '\n';
	forI(AREA){
		if(i % SIZE == 0){ world_buffer[cursor++] = '|'; }
		world_buffer[cursor++] = (world[i] ? '+' : ' ');
		if(i % SIZE == SIZE-1){ world_buffer[cursor++] = '|'; world_buffer[cursor++] = '\n'; }
	}
	forI(SIZE+2){ world_buffer[cursor++] = '='; };
	
	//loop
	uint64_t tick = 0;
	uint8_t neighbours = 0;
	while(1){
		//print the world
		printf("Tick: %zu\n", tick);
		printf("%s\n", world_buffer);
		
		//wait for input
		getc(stdin);
		
		//simulate
		forI(AREA){
			//collect alive neighbours
			neighbours = 0;
			if(world[(i     -1 <     0) ? AREA       -1 : i     -1]) neighbours += 1; //left
			if(world[(i-SIZE-1 <     0) ? AREA-i-SIZE-1 : i-SIZE-1]) neighbours += 1; //topleft
			if(world[(i-SIZE   <     0) ? AREA-i-SIZE   : i-SIZE  ]) neighbours += 1; //top
			if(world[(i-SIZE+1 <     0) ? AREA-i-SIZE+1 : i-SIZE+1]) neighbours += 1; //topright
			if(world[(i     +1 >= AREA) ? 0             : i     +1]) neighbours += 1; //right
			if(world[(i+SIZE+1 >= AREA) ? 0     +SIZE+1 : i+SIZE+1]) neighbours += 1; //botright
			if(world[(i+SIZE   >= AREA) ? 0     +SIZE   : i+SIZE  ]) neighbours += 1; //bot
			if(world[(i+SIZE-1 >= AREA) ? 0     +SIZE-1 : i+SIZE-1]) neighbours += 1; //botleft
			
			//evolve
			temp_world[i] = (neighbours == 3 || (neighbours == 2 && world[i]));
			world_buffer[SIZE+4 + (i/SIZE)*3 + i] = temp_world[i] ? '+' : ' ';
		}
		
		memcpy(world, temp_world, AREA*sizeof(uint8_t));
		tick += 1;
	}
}