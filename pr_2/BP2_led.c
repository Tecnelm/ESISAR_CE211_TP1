#include "bp2_led.h"
#include "stm8s.h"

#define MASKBTN 1<<7
#define MASKLED 0x01
 
void init(void)
{
	GPIOD -> DDR =0x01 ;///out
	GPIOD -> CR1 =0x01 ;
	GPIOD -> CR2 =0x00 ;
	
	GPIOE -> DDR = 0x00;///in
	GPIOE -> CR1 = 1<<7;
	GPIOE -> CR2 = 0x00;
	
	GPIOB -> DDR = 0xFF;
	GPIOB -> CR1 = 0xFF;
	GPIOB -> CR2 = 0x00;
}


void setOnwhenPress(void)
{
	init();
	while(1){
		if(GPIOE -> IDR & MASKBTN){
		GPIOD ->ODR = GPIOD->ODR | MASKLED;}
		else{
		GPIOD ->ODR = GPIOD->ODR & ~MASKLED;}
	}
	
}
void aff12WhenPress(void)
{
	init();
	while(1){
		if(GPIOE -> IDR & MASKBTN)
			aff1();
		else
			aff2();
	}
	
}


void aff1(void)
{
	GPIOB ->ODR = 0b01100000;
	
}

void aff2(void)
{
	GPIOB -> ODR =0b11011010 ;
}