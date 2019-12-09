#include "stm8s.h"
#include "echo.h"
#define MASKLAST 0x02


void init(void)
{
	GPIOC -> DDR = 0x00;
	GPIOC -> CR1 = 0x00;
	GPIOC -> CR2 = 0x00;
	
	GPIOB -> DDR = 0xFF;
	GPIOB -> CR1 = 0xFF;
	GPIOB -> CR2 = 0x00;
	
	GPIOA -> DDR = 0x00;
	GPIOA -> CR1 = 0x00;
	GPIOA -> CR2 = 0x00;
}

void setOnLed(void)
{
	init();
	while(1)
	{
		GPIOB -> ODR = GPIOC -> IDR;		
		if(GPIOA -> IDR & MASKLAST)
		{
			GPIOB -> ODR = GPIOB ->ODR |0x01;
		}
		else
			GPIOB -> ODR = GPIOB ->ODR &0xFE;
	}
	
}


